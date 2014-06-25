chef-xen
====================

##About

###Description
A chef cookbook for setting up Xen and managing guests

###Author
Norman Joyner - norman.joyner@gmail.com

##Getting Started

###Recipes

####default
Install and configure Xen on the system

###LWRPs

####guest
Manage specified Xen guest

Variables:
* ```hostname```: guest name and system hostname (name attribute)
* ```dist```: distro to install
* ```lvm```: lvm volume group name
* ```networking_enabled```: enabling dhcp networking (defaults to true)
* ```vcpus```: vcpus allocated to guest (defaults to 1)
* ```memory```: memory allocated to guest in megabytes (defaults to 512)
* ```size```: disk allocated to guest in megabytes (defaults to 4096)
* ```password```: password for guest

Actions:
* ```create```: create / start guest
* ```pause```: pause guest
* ```unpause```: unpause guest
* ```shutdown```: shutdown guest
* ```destroy```: destroy guest

##Examples

###Installing Xen
```bash
recipe['xen']
```

###Creating a Trusty guest
```ruby
    xen_guest "my-first-guest" do
        dist "trusty"
        lvm "hypervisor-vg"
        vcpus 2
        memory 2048
        size 10240
        password "my-first-password"
        action :create
    end
```

###Destroying the Trusty guest
```ruby
    xen_guest "my-first-guest" do
        action :destroy
    end
```
