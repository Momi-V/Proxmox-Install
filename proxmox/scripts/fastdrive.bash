#!/bin/bash

apt update
apt install -y parted

drive=( /dev/nvme0n1 /dev/nvme1n1 )
for i in ${drive[@]}; do
  parted -s -a optimal $i 'mklabel gpt mkpart primary 0% 100%'
done
drive=( ${drive[@]/%/p1} )
sleep 1

mkfs.btrfs -f -L data -m raid1 -d raid0 ${drive[@]}

mkdir /mnt/fast
mount /dev/nvme0n1p1 /mnt/fast

{ echo; echo '/dev/nvme0n1p1  /mnt/fast  btrfs  nofail  0  2'; } >> /etc/fstab
fstrim -av

btrfs subvolume create /mnt/fast/vms
pvesm add btrfs fast-storage --path /mnt/fast/vms --content iso,vztmpl,images,rootdir

{ crontab -l 2> /dev/null
cat <<'EOL'

0 5 * * 0 btrfs balance start -musage=50 -dusage=50 /mnt/fast
0 5 * * 1 btrfs scrub start /mnt/fast
EOL
} | crontab -

