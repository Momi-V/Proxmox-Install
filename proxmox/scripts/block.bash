#!/bin/bash

lsblk
hdparm -S 60 /dev/sd*
fstrim -av
