# s3-nginx

## build docker image

```bash=
docker build --platform linux/amd64 -t dachichang/basic-auth-s3-nginx:1.0.0 .
docker push dachichang/basic-auth-s3-nginx:1.0.0
```

## package helm

```bash=
helm package charts/basic-auth-s3-nginx --app-version 1.0.0 --version 1.0.0
```


## host in artifacthub.io

1. create new repo https://github.com/DachiChang/basic-auth-s3-nginx
2. git checkout -b gh-pages (use github pages to service static helm repo)
3. mv basic-auth-s3-nginx-1.0.0.tgz . (push helm pacakge to the repo)
4. helm repo index . (create helm repo index)
5. artifacthub.io create a helm repo url point to https://dachichang.github.io/basic-auth-s3-nginx/
