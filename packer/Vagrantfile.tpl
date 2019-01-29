# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "njoyx_dev/FreeBSD"
  config.ssh.shell = "/bin/csh"
  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: [".git/", "Vagrantfile", ".gitignore"]
end
