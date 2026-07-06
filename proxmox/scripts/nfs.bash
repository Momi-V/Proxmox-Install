#!/bin/bash

mkdir /mnt/prox
{ echo; echo 'truenas:/mnt/bigSpin/prox  /mnt/prox  nfs  defaults  0  0'; } >> /etc/fstab
mount -a
