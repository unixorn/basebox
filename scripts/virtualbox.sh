#!/bin/sh

yum -y install kernel-devel kernel-headers gcc patch perl

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
mkdir /tmp/vbox
mount -t iso9660 -o loop $VBOX_ISO /tmp/vbox
sh /tmp/vbox/VBoxLinuxAdditions.run
umount /tmp/vbox
rm -rf /tmp/vbox $VBOX_ISO

yum -y remove kernel-devel kernel-headers gcc patch perl
