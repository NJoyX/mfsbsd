# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "njoyx_dev/freebsd"
  config.vm.box_check_update = true

  config.ssh.forward_agent = true
  config.ssh.keep_alive = true
  config.ssh.insert_key = false

  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: [".git/", "Vagrantfile", ".gitignore"]

  config.vm.provider "parallels" do |prl|
    prl.memory = 2048
    prl.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo svnlite co svn://svn0.eu.freebsd.org/base/releng/$(echo "`uname -r`" | cut -d'-' -f1) /usr/src

    pkg update -qf
    pkg upgrade -qf
    pkg install -fy parallels-tools bash
    chsh -s bash vagrant
    kldload -n if_pvmnet
  SHELL
end
