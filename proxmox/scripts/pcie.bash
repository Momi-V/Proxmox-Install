#!/bin/bash

cat <<'EOL' > /etc/modules-load.d/vfio.conf
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
EOL
cat /etc/modules-load.d/vfio.conf

PCI=$(lspci -n -s 0e:00 | awk -F ': ' {'print $2'} | awk -F ' ' {'print $1'})
echo "options vfio-pci ids=$(echo $PCI | sed 's/ /,/g') disable_vga=1" > /etc/modprobe.d/vfio.conf
cat /etc/modprobe.d/vfio.conf

echo "options kvm ignore_msrs=1 report_ignored_msrs=0" > /etc/modprobe.d/kvm.conf
cat /etc/modprobe.d/kvm.conf

sed -i -E 's/(GRUB_CMDLINE_LINUX_DEFAULT=".*)"/\1 amd_iommu=on iommu=pt pcie_acs_override=downstream,multifunction"/g' /etc/default/grub
sed -i -E 's/#GRUB_TERMINAL=console/GRUB_TERMINAL=console/g' /etc/default/grub
cat /etc/default/grub

update-initramfs -u -k all
update-grub
