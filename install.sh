#!/bin/bash

echo "nameserver 114.114.114.114" > /etc/resolv.conf
IP=`ip route get 114.114.114.114 | awk 'NR==1 {print $NF}'`
echo $IP $HOSTNAME >>  /etc/hosts


yum clean all
rm -rf /etc/yum.repos.d/*.repo
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
sed -i '/aliyuncs/d' /etc/yum.repos.d/CentOS-Base.repo
sed -i 's/$releasever/7.2.1511/g' /etc/yum.repos.d/CentOS-Base.repo
sed -i '/aliyuncs/d' /etc/yum.repos.d/epel.repo

echo "
[ceph]
name=ceph
baseurl=http://mirrors.aliyun.com/ceph/rpm-hammer/el7/x86_64/
gpgcheck=0
[ceph-noarch]
name=cephnoarch
baseurl=http://mirrors.aliyun.com/ceph/rpm-hammer/el7/noarch/
gpgcheck=0
" > /etc/yum.repos.d/ceph.repo

yum install ceph ceph-radosgw ceph-deploy -y

mkdir /root/cluster & cd /root/cluster & rm -f /root/cluster/*
cd /root/cluster

sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0
systemctl stop firewalld 
systemctl disable firewalld

ceph-deploy new $HOSTNAME

echo osd pool default size = 1 >> ceph.conf
echo osd crush chooseleaf type = 0 >> ceph.conf
echo osd max object name len = 256 >> ceph.conf

mkdir /var/run/ceph/
chown ceph:ceph /var/run/ceph/
chown ceph:ceph /osd
ceph-deploy mon create-initial
mkdir /osd & rm -rf /osd/*
ceph-deploy osd prepare $HOSTNAME:/osd
ceph-deploy osd activate  $HOSTNAME:/osd

ceph -s
