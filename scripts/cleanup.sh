#!/bin/sh

uname -a

# CLEANUP YUM
yum clean all
rm -rf /var/cache/* /usr/share/doc/*

# ZERO OUT FREE DISK SPACE
dd if=/dev/zero of=/tmp/EMPTY bs=1M
rm -f /tmp/EMPTY
