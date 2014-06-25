#
# Cookbook Name:: xen
# Recipe:: default
#
# Copyright (C) 2014 Norman Joyner
#
# All rights reserved - Do Not Redistribute
#

# install xen
package "xen-hypervisor-amd64" do
    action :install
    options "--force-yes"
    notifies :write, "log[reboot-message]"
end

# update grub defaults
execute "update grub defaults" do
    command "sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=\"Xen 4.1-amd64\"/' /etc/default/grub"
    not_if "grep 'Xen 4.1-amd64' /etc/default/grub"
    notifies :run, "execute[update-grub]"
end

# run update-grub
execute "update-grub" do
    command "update-grub"
    action :nothing
end

# reboot message
log "reboot-message" do
    message "Installed Xen ... Please reboot your system for changes to take effect!"
    action :nothing
end

# write /etc/networking/interfaces to configure networking bridge
template "/etc/network/interfaces" do
    source "network_interfaces.erb"
    owner "root"
    group "root"
    mode 0644
    variables ({
        :bridge_name => node['xen']['bridge_name'],
        :bridge_ports => node['xen']['bridge_ports']
    })
end

# install xen tools
package "xen-tools" do
    action :install
    options "--force-yes"
end

# support loopback images
execute "modprobe loop max_loop=255" do
    command "modprobe loop max_loop=255"
end
