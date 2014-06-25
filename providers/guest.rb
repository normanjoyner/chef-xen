action :create do
    # build command
    command = [
        "xen-create-image",
        "--hostname #{new_resource.hostname}",
        "--dist #{new_resource.dist}",
        "--lvm #{new_resource.lvm}",
        "--vcpus #{new_resource.vcpus}",
        "--memory #{new_resource.memory}mb",
        "--size #{new_resource.size}mb",
        "--password #{new_resource.password}"
    ]

    # add networking if enabled
    command.push("--dhcp") if new_resource.networking_enabled

    # execute guest creation
    execute "install xen guest #{new_resource.hostname}" do
        command command.join(" ")
        not_if "test -f /etc/xen/#{new_resource.hostname}.cfg"
    end

    # start the guest
    execute "start xen guest #{new_resource.hostname}" do
        command "xl create /etc/xen/#{new_resource.hostname}.cfg"
        not_if "xl list #{new_resource.hostname}"
        action :run
    end
end

action :pause do
    # pause the guest
    execute "pause xen guest #{new_resource.hostname}" do
        command "xl pause #{new_resource.hostname}"
    end
end

action :unpause do
    # unpause the guest
    execute "unpause xen guest #{new_resource.hostname}" do
        command "xl unpause #{new_resource.hostname}"
    end
end

action :shutdown do
    # shutdown the guest
    execute "shutdown xen guest #{new_resource.hostname}" do
        command "xl shutdown #{new_resource.hostname}"
    end
end

action :destroy do
    # destroy the guest
    execute "destroy xen guest #{new_resource.hostname}" do
        command "xl destroy #{new_resource.hostname}"
    end
end
