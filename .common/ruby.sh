#!/bin/bash -eux

wget -O- http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz | tar oxz
cd yaml*
./configure --prefix=/opt/vagrant
make && make install
cd ..
rm -rf *yaml*

wget -O- http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz | tar oxz
cd ruby*
./configure --prefix=/opt/vagrant --with-opt-dir=/opt/vagrant
make && make install
/opt/vagrant/bin/gem update --system
/opt/vagrant/bin/gem update
/opt/vagrant/bin/gem clean
/opt/vagrant/bin/gem install chef puppet --no-rdoc --no-ri
cd ..
rm -rf *ruby*

echo 'PATH=$PATH:/opt/vagrant/bin' > /etc/profile.d/ruby.sh
