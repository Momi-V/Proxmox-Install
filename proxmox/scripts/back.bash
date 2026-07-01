#!/bin/bash

cat <<'EOL' > /etc/apt/sources.list.d/pbs-no-subscription.list
# Proxmox Backup Server pbs-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pbs bookworm pbs-no-subscription
EOL

apt update && apt full-upgrade -y && apt autopurge -y
apt install -y proxmox-backup-server

mv /etc/apt/sources.list.d/pbs-enterprise.list /etc/apt/sources.list.d/pbs-enterprise.list.bak
