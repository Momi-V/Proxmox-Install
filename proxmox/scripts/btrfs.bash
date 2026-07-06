#!/bin/bash

mkdir /var/lib/pve
btrfs subvolume create /var/lib/pve/local-btrfs
btrfs subvolume list /

cat <<'EOL' > /etc/pve/storage.cfg
dir: local
        path /var/lib/vz
        content iso,vztmpl,backup
        disable

btrfs: local-btrfs
        path /var/lib/pve/local-btrfs
        content iso,vztmpl,backup,images,rootdir
EOL
cat /etc/pve/storage.cfg
