#!/bin/bash
#
installDocker(){
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum makecache fast
yum install -y  docker-ce-19.03.13
for i in start enable;do systemctl $i docker;done
cat  > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://o4uba187.mirror.aliyuncs.com"],
   "exec-opts": ["native.cgroupdriver=systemd"],
   "graph":  "/var/lib/docker"
}
EOF
for i in enable restart; do systemctl restart docker ;done
}

installDocker
