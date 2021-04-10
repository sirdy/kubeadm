
```
~]# kubectl  get ingress
Warning: extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
NAME        CLASS    HOSTS            ADDRESS        PORTS   AGE
ingress-a   <none>   www.sirdy-a.io   192.168.1.23   80      13m
```

```
因为使用了 externalIP ，所以可以直接通过域名访问
# curl -H "Host:  www.sirdy-a.io" 192.168.1.23
iKubernetes demoapp v1.0 !! ClientIP: 10.244.2.8, ServerName: deploy-a-5b65fb4c69-cmjbt, ServerIP: 10.244.2.9!
# curl -H "Host:  www.sirdy-a.io:30080" 192.168.1.23
iKubernetes demoapp v1.0 !! ClientIP: 10.244.2.8, ServerName: deploy-a-5b65fb4c69-8q597, ServerIP: 10.244.3.3!
```
