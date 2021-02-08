
```
# (umask 077; openssl genrsa -out nginx.key 2048)
# openssl req -new -x509 -key nginx.key  -out nginx.crt -subj /C=CN/ST=Beijing/L=Beijing/O=devops/CN=www.linux.io
```
