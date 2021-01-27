#!/bin/bash
#
installKubeadm() {
cat  > /etc/yum.repos.d/kubernetes.repo << EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum repolist
yum install -y kubeadm-1.19.4 kubelet-1.19.4 kubectl-1.19.4
systemctl enable kubelet
}

installKubeadm
