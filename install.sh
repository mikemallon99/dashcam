#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Symlink our dashcam service file to the system
ln -sf $SCRIPT_DIR/dashcam.service /etc/systemd/system/dashcam.service

# Havent tested
# sudo systemctl start dashcam
# sudo systemctl enable dashcam

# Mount USB Drive
# Add this to /etc/fstab
# UUID=27AD-3A75        /mnt/usbdrive   vfat    uid=1000,gid=1000,umask=022,utf8,noatime,nofail,x-systemd.automount  0  0
sudo systemctl daemon-reload
sudo mount -a
# verify:
mount | grep /mnt/usbdrive

