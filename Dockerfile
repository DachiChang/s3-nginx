FROM nginxinc/nginx-s3-gateway

COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
