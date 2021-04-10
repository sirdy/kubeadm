~]# kubectl get pods -n ingress-nginx   -l app.kubernetes.io/name=ingress-nginx --watch
NAME                                        READY   STATUS      RESTARTS   AGE
ingress-nginx-admission-create-p454w        0/1     Completed   0          14m
ingress-nginx-admission-patch-bt26p         0/1     Completed   1          14m
ingress-nginx-controller-8645fc8447-cn7jh   1/1     Running     0          14m

~]# kubectl  get svc -n ingress-nginx
NAME                                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller             NodePort    10.103.111.25   <none>        80:30080/TCP,443:30443/TCP   15m
ingress-nginx-controller-admission   ClusterIP   10.97.51.68     <none>        443/TCP                      15m
