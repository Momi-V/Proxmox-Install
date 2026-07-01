#!/bin/bash

mkdir install-tmp
cd install-tmp

tpID=10001
vmNAME=microos
vmDESC="openSUSE MicroOS base template"

qm create $tpID \
--name $vmNAME --description "$vmDESC" --cores 1 --cpu cputype=host --memory 1024 --balloon 1024 --net0 model=virtio,bridge=vmbr0 --bios ovmf --ostype l26 \
--machine q35 --scsihw virtio-scsi-single --onboot 0 --cdrom none --agent enabled=1 --boot order=virtio0 --efidisk0 local-btrfs:4,efitype=4m,pre-enrolled-keys=1

curl -O -L https://download.opensuse.org/tumbleweed/appliances/openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2

qm disk import $tpID openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 local-btrfs
qm set $tpID --virtio0 local-btrfs:$tpID/vm-$tpID-disk-1.raw,cache=writeback,discard=on,iothread=1
qm disk resize $tpID virtio0 25G

qm set $tpID --template 1

cd .. && rm -rf install-tmp
