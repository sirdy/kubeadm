## Init Master

```
~]# kubeadm  init --kubernetes-version v1.19.4 \
              --apiserver-advertise-address 192.168.1.11 \
              --control-plane-endpoint k8s-vip.linux.io \
              --image-repository registry.aliyuncs.com/google_containers \
              --pod-network-cidr 10.244.0.0/16 \
              --service-cidr 10.96.0.0/12 |tee kubeadm-init.log
```

##  Join Node

```
~]# kubeadm join k8s-vip.linux.io:6443 --token k6h0i5.0jrgwy9zzkpwalai \
    --discovery-token-ca-cert-hash sha256:9f7f9f236fe3a898aa5e7eb8d86804de0a87d9eb82d6fdabe66a151b465cca43 
```
## Flannel

```
~]# kubectl  apply -f kube-flannel-v0.13.11-rc1.yml
```

## IPVS MODE

```
~]# kubectl  edit configmap/kube-proxy -n kube-system
  ...
    mode: "ipvs"
  ...
~]# kubectl  get pod -A -l k8s-app=kube-proxy
NAMESPACE     NAME               READY   STATUS    RESTARTS   AGE
kube-system   kube-proxy-b72wr   1/1     Running   4          9d
kube-system   kube-proxy-rnk2n   1/1     Running   4          9d
kube-system   kube-proxy-vxksr   1/1     Running   4          9d
~]# kubectl  delete pod kube-proxy-b72wr kube-proxy-rnk2n kube-proxy-vxksr  -n  kube-system
~]# ifconfig  kube-ipvs0
```

## Example Running

- Create a deployment by kubectl 

```
~]# kubectl  create deployment demoapp --image=ikubernetes/demoapp:v1.0 --replicas=2 --dry-run=client
```
- Create a Service for ClusterIP

```
~]# kubectl expose deploy/demoapp --type=ClusterIP  --port=80 --target-port=80 
```

- Create a Service for NodePort

```
~]# kubectl expose deploy/demoapp --type=NodePort  --port=80 --target-port=80 
kubectl  get svc/demoapp
NAME      TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
demoapp   NodePort   10.97.120.127   <none>        80:32573/TCP   42m
```

- Access by HostIP

```
~]# curl http://192.168.1.21:32573/
iKubernetes demoapp v1.0 !! ClientIP: 10.244.2.0, ServerName: demoapp-5f7d8f9847-9882t, ServerIP: 10.244.1.4!
```
