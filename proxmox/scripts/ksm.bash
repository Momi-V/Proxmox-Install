#!/bin/bash

apt install -y ksmtuned

sed -i.bak "s+# KSM_THRES_COEF=.*+KSM_THRES_COEF=50+g" /etc/ksmtuned.conf
cat /etc/ksmtuned.conf

systemctl restart ksmtuned
