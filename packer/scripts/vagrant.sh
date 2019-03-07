#!/bin/sh
set -ex
pkg install -y bash sudo
echo "vagrant" | pw useradd vagrant -h 0 -s /usr/local/bin/bash -G wheel -c "vagrant"
echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /usr/local/etc/sudoers.d/vagrant
echo "Defaults:vagrant !requiretty" >> /usr/local/etc/sudoers.d/vagrant
chmod 0440 /usr/local/etc/sudoers.d/vagrant

pkg install -y ca_root_nss
ln -sf /usr/local/share/certs/ca-root-nss.crt /etc/ssl/cert.pem
mkdir -pm 700 ~vagrant/.ssh
cd ~vagrant/.ssh
fetch -am -o authorized_keys 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 authorized_keys
chown -R vagrant:wheel ~vagrant

pkg install -y rsync
