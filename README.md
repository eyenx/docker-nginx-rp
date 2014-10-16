## docker-nginx-rp

Simple dockerized nginx reverseproxy w/ [Jinja2](http://jinja.pocoo.org/) templating using [j2cli](https://pypi.python.org/pypi/j2cli/).

`/etc/nginx/nginx.conf` is created from nginx.tmpl with environment variables passed to [docker](http://docker.io)

### example nginx.tmpl


used environment variables:

```
RESOLVER = dns resolver (ex. 8.8.8.8)
SERVER_NAME = server name used for nginx (ex. example.com)
BACKEND_ADDR = backend address (ex. mybackend-1.example.com)
BACKEND_PORT = backend port (ex. 4000)
```


```
user  nginx;
daemon off;
worker_processes  1;

error_log  /proc/self/fd/2 warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    resolver {{ RESOLVER }};
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /proc/self/fd/1 main;
    sendfile        on;
    keepalive_timeout  65;

server {
        listen 80;
        server_name {{ SERVER_NAME }};
        access_log /proc/self/fd/1;
        error_log /proc/self/fd/2;
        location / {
            proxy_pass http://{{ BACKEND_ADDR }}:{{ BACKEND_PORT }}$request_uri?;
            proxy_set_header Host $server_name;
        }
    }
}

```


### build

`docker build -t myimage .`

### run

Passing environment variables yourself

```
docker run -p 80:80 -e VARIABLE=value myimage
```

Works with links too

```
docker run -p 80:80 --link backendimage:backendimage myimage
``` 

Ideal for [tutum](http://tutum.co)

