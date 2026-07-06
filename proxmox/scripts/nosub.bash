#!/bin/bash

sed -i.bak 's/notfound/active/g' /usr/share/perl5/PVE/API2/Subscription.pm
systemctl restart pveproxy

sed -i.bak -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart proxmox-backup-proxy
