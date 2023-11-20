# basic-auth-s3-nginx

1. follow up the values.yaml and fill the environment data
2. secret file data generate follow below
```bash=
htpasswd -c basic_auth_user_pass user1
cat basic_auth_user_pass | base64 # copy the result and paste to your values.yaml "SecretFile.data"
```

```yaml=
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/listen-ports: '[{ "HTTP" : 80 }, { "HTTPS" : 443 }]'
    alb.ingress.kubernetes.io/actions.ssl-redirect: '{ "Type" : "redirect", "RedirectConfig" : { "Protocol" : "HTTPS", "Port" : "443", "StatusCode" : "HTTP_301" } }'
    alb.ingress.kubernetes.io/group.name: xxxxx
    alb.ingress.kubernetes.io/certificate-arn: xxxxx
  hosts:
    - host: test.example.com
      paths:
        - path: /
          pathType: Prefix

resources:
  limits:
    cpu: 100m
    memory: 64Mi
  requests:
    cpu: 100m
    memory: 64Mi

env:
  - name: S3_BUCKET_NAME
    value: your-bucket
  - name: S3_SERVER
    value: s3.us-west-2.amazonaws.com
  - name: S3_SERVER_PORT
    value: 443
  - name: S3_SERVER_PROTO
    value: https
  - name: S3_REGION
    value: us-west-2
  - name: S3_STYLE
    value: virtual
  - name: DEBUG
    value: false
  - name: AWS_SIGS_VERSION
    value: 4
  - name: ALLOW_DIRECTORY_LIST
    value: true
  - name: PROVIDE_INDEX_PAGE
    value: true
  - name: PROXY_CACHE_MAX_SIZE
    value: 10g
  - name: PROXY_CACHE_INACTIVE
    value: 60m
  - name: PROXY_CACHE_VALID_OK
    value: 1h
  - name: PROXY_CACHE_VALID_NOTFOUND
    value: 1m
  - name: PROXY_CACHE_VALID_FORBIDDEN
    value: 30s
  - name: AWS_ACCESS_KEY_ID
    value:
  - name: AWS_SECRET_ACCESS_KEY
    value:

secretFile:
  - name: base_auth_file
    data:
    mountTo: /etc/nginx/
```

## Helm install

- helm repo add basic-auth-s3-nginx https://dachichang.github.io/basic-auth-s3-nginx
- helm repo update
- helm upgrade --install basic-auth-s3-nginx basic-auth-s3-nginx/basic-auth-s3-nginx -f your-values.yaml -n default
