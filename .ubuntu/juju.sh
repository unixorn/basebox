#!/bin/sh

apt-get update
apt-get install -qq software-properties-common
add-apt-repository -y ppa:juju/devel
apt-get update
apt-get install -qq juju-core
