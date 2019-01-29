#!/bin/sh

for d in ada0 da0 vtbd0; do
  if [ -e "/dev/$d" ]; then
    export ZFSBOOT_DISKS=$d
    break
  fi
done
unset d

POOL="tank"
ARCH="`/sbin/sysctl -n hw.machine_arch`"
RELEASE=$(echo "`uname -r`" | cut -d'-' -f1)

destroygeom -d $ZFSBOOT_DISKS -p $POOL
zfsinstall -u http://ftp.freebsd.org/pub/FreeBSD/releases/$ARCH/$RELEASE-RELEASE -d $ZFSBOOT_DISKS -s 8G -p $POOL -L

echo "packer" | pw -R /mnt/ usermod root -h 0
echo "PermitRootLogin yes" >> /mnt/etc/ssh/sshd_config

sysrc -f /mnt/etc/rc.conf sshd_enable="YES"
sysrc -f /mnt/etc/rc.conf sendmail_enable="NONE"
interface="`ifconfig -l | cut -d' ' -f1`"
sysrc -f /mnt/etc/rc.conf ifconfig_$interface="dhcp"
