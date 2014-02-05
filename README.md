# Building VM Images

## Install Dependencies

1.  Install [Packer.io](http://www.packer.io/downloads.html)

2.  Install [VirtualBox (including extensions)](https://www.virtualbox.org/wiki/Downloads)

3.  Install [Vagrant](http://www.vagrantup.com/downloads.html)

## Build Images

1.  Building an Image
    
        packer build centos.json

2.  Install the Image
    
        vagrant box add centos-$(date -u +%Y.%m.%d)

3.  Share the Image
    
    Place the image on an HTTP server where it can be shared &
    referenced in the Vagrantfile at the top level of this project.
