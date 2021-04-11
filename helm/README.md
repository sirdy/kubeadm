```
# kubectl  get sc
NAME       PROVISIONER          RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
longhorn   driver.longhorn.io   Delete          Immediate           true                   12m
```

- helm repo add bitnami https://charts.bitnami.com/bitnami
- helm repo update
- helm search repo redis
- helm show readme bitnami/redis
- helm install redisdb bitnami/redis --set master.persistence.storageClass=longhorn --set slave.persistence.storageClass=longhorn
- helm status redisdb
- helm list

