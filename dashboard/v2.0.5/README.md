
#### 登录dashboard (1)

```
~]# kubectl  apply -f admin-user.yaml
~]# kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
```
#### 登录dashboard (2)

```
~]# kubectl config  set-credentials k8s-cluster-admin --token=`kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"` --kubeconfig=/tmp/k8s-cluster-admin.conf

```

#### 登录dashboard (3)

```
~]# kubectl  create serviceaccount cluster-sa -n kubernetes-dashboard
~]# kubectl  create clusterrolebinding sa-cluster-admin --clusterrole=cluster-admin  --serviceaccount=kubernetes-dashboard:cluster-sa
~]# kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
```

