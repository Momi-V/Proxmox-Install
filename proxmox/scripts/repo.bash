#!/bin/bash

mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.bak

cat <<'EOL' > /etc/apt/sources.list.d/pve-no-subscription.list
# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve trixie pve-no-subscription
EOL

apt-key adv --fetch-keys https://enterprise.proxmox.com/debian/proxmox-release-trixie.gpg
apt update && apt full-upgrade -y && apt autopurge -y
