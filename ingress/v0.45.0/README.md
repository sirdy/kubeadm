 ```
 ~]# kubectl  get svc -n ingress-nginx
NAME                                 TYPE        CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
ingress-nginx-controller             NodePort    10.103.111.25   192.168.1.23   80:30080/TCP,443:30443/TCP   46m
ingress-nginx-controller-admission   ClusterIP   10.97.51.68     <none>         443/TCP                      46m
 ```
 
 使用 externalIP ，我们可以直接通过域名访问，无需再添加端口，即当域名为 `www.sirdy-a.io` 时，我们可以通过一下两种方式都能访问后端服务
 - https://www.sirdy-a.io/
 - https://www.sirdy-a.io:30080
