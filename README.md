# Building VM Images

## Install Dependencies

1.  Install [Packer.io](http://www.packer.io/downloads.html)

2.  Install [VirtualBox (including extensions)](https://www.virtualbox.org/wiki/Downloads)

3.  Install [Vagrant](http://www.vagrantup.com/downloads.html)

## Build Images

1.  Building an Image
    
        packer build -only=vagrant centos.json
        mv centos-vagrant.box centos-vagrant-$(date -u +%Y.%m.%d).box

2.  Install the Image
    
        vagrant box add centos centos-vagrant-$(date -u +%Y.%m.%d).box

3.  Share the Image
    
    Place the image on an HTTP server where it can be shared &
    referenced in a Vagrantfile.
