#!/bin/bash
#
kubeadm  init --kubernetes-version v1.19.4 \
              --apiserver-advertise-address 192.168.1.11 \
              --control-plane-endpoint k8s-vip.linux.io \
              --image-repository registry.aliyuncs.com/google_containers \
              --pod-network-cidr 10.244.0.0/16 \
              --service-cidr 10.96.0.0/12 |tee kubeadm-init.log

# kubeadm  token  create --print-join-command
