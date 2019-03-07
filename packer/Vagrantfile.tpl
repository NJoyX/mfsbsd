# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "njoyx_dev/FreeBSD"

  config.vm.box_check_update = true
  config.ssh.forward_agent = true
  config.ssh.keep_alive = true

  config.vm.synced_folder ".", "/vagrant", disabled: true
end
