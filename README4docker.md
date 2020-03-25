# Docker Configuration

## Start html static with nginx by docker run manually

```
$ docker pull nginx
$ docker run --name docker-nginx-detect-face-frontend -p 80:80 -v {root-dir}/detect-fact-frontend/build:/usr/share/nginx/html -v {root-dir}/detect-fact-frontend/nginx.conf:/etc/nginx/conf.d/default.conf -d nginx
```

If there is any update on build folder and default.conf file, it should be restart container docker-nginx-detect-face-frontend

```
$ docker restart docker-nginx-detect-face-frontend
```

Stop and remove container

```
$ docker stop docker-nginx-detect-face-frontend
$ docker rm docker-nginx-detect-face-frontend
```

## Start html static with Dockerfile

```
$ docker build -t detect-face-frontend-nginx .
$ docker run --name detect-face-ui -it -p 80:80 -d detect-face-frontend-nginx
```

## Start html static with docker compose
```
$ docker-compose up --build
```

## Attach to runnning container (Console terminal)

```
$ docker attach detect-face-frontend-nginx
```

## Access to container

```
$ docker exec -it <hash-container> bash
Or,
$ docker-compose exec detect-face-frontend-nginx bash
```
