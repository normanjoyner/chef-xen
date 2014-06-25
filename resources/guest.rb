actions :create, :pause, :unpause, :shutdown, :destroy
default_action :create

attribute :hostname, :kind_of => String, :name_attribute => true
attribute :dist, :kind_of => String, :required => true
attribute :lvm, :kind_of => String, :required => true
attribute :networking_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :vcpus, :kind_of => Fixnum, :default => 1
attribute :memory, :kind_of => Fixnum, :default => 512
attribute :size, :kind_of => Fixnum, :default => 4096
attribute :password, :kind_of => String, :required => true
