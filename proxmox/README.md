# Proxmox
Useful scriptlets for various Proxmox tweaks

## All scripts
```
mkdir setup && cd setup
list=( block btrfs font dhcp hosts cron repo back ksm fastdrive nfs nosub template)
for i in ${list[@]}; do
  curl -O https://raw.githubusercontent.com/Momi-V/Notizen/main/proxmox/scripts/$i.bash
  chmod +x $i.bash
  cat $i.bash
  bash $i.bash
done
cd ..
reboot
```
