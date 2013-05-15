#!/bin/sh

# PREREQS
apt-get -qq update
apt-get -qq install \
    lxc wget bsdtar linux-image-extra-$(uname -r) \
    debconf-utils git

# INSTALL
echo 'golang-go golang-go/dashboard boolean false'|debconf-set-selections
apt-get -qq install golang-go
git clone -b 'v0.3.0' --depth=1 git://github.com/dotcloud/docker.git
cd docker
make && cp ./bin/docker /usr/local/bin/
cd ..

# DAEMON
cat <<UPSTART >/etc/init/dockerd.conf
start on runlevel [2345]
stop  on runlevel [016]
respawn
exec /usr/local/bin/docker -d
UPSTART
grep -qv aufs /proc/filesystems && modprobe aufs
start dockerd > /dev/null

# CLEAN
rm -rf docker
dpkg --purge debconf-utils git golang-go
apt-get -y autoremove
apt-get -y clean
