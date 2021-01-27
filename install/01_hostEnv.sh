Hostenv(){
# 主机名解析
cat >> /etc/hosts << EOF
192.168.1.11 k8s-master01.linux.io k8s-master01 master01 k8s-vip.linux.io k8s-vip vip
192.168.1.12 k8s-master02.linux.io k8s-master02 master02 
192.168.1.13 k8s-master03.linux.io k8s-master03 master03 
192.168.1.21 k8s-node01.linux.io k8s-node01 node01
192.168.1.22 k8s-node02.linux.io k8s-node02 node02
EOF
# 关闭防火墙和selinux
for i in stop disable ;do systemctl $i firewalld; done
setenforce 0 && sed -i "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

# 禁用swap分区
swapoff -a && sudo sed -i 's/.*swap.*/#&/' /etc/fstab

# 配置阿里mirrors
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
yum install -y epel-release lrzsz ntpdate wget conntrack ipvsadm ipset iptables curl sysstat net-tools bind-utils vim telnet 

# 调整内核参数
cat << EOF  > /etc/sysctl.d/kubernetes.conf
net.core.netdev_max_backlog=10000
net.core.somaxconn=32768
net.ipv4.tcp_max_syn_backlog=8096
fs.inotify.max_user_instances=8192
fs.file-max=2097152
fs.inotify.max_user_watches=524288
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_rmem=4096 12582912 16777216
net.ipv4.tcp_wmem=4096 12582912 16777216
net.core.rps_sock_flow_entries=8192
net.ipv4.neigh.default.gc_thresh1=2048
net.ipv4.neigh.default.gc_thresh2=4096
net.ipv4.neigh.default.gc_thresh3=8192
net.ipv4.tcp_max_orphans=32768
net.ipv4.tcp_max_tw_buckets=32768
vm.max_map_count=262144
kernel.threads-max=30058
net.ipv4.ip_forward=1
kernel.core_pattern=core
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.tcp_tw_recycle=0
vm.swappiness=0
vm.overcommit_memory=1
vm.panic_on_oom=0
fs.inotify.max_user_watches=89100
fs.file-max=52706963
fs.nr_open=52706963
net.ipv6.conf.all.disable_ipv6=1
EOF
modprobe overlay
modprobe br_netfilter
sysctl  --system

# 时间同步
yum install -y  chrony
cat  > /etc/chrony.conf << EOF
server ntp.aliyun.com iburst
stratumweight 0
driftfile /var/lib/chrony/drift
rtcsync
makestep 10 3
bindcmdaddress 127.0.0.1
bindcmdaddress ::1
keyfile /etc/chrony.keys
commandkey 1
generatecommandkey
logchange 0.5
logdir /var/log/chrony
EOF
for i in enable start; do systemctl $i chronyd.service; done
chronyc sources
}

Hostenv
