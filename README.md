docker-hugo
===========

Dockerfile for Hugo

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/hugo/).

```sh
$ docker pull dceoy/hugo
```

Usage
-----

Run a web server

```sh
$ docker container run --rm -p 1313:1313 -v ${PWD}:/work -w /work \
    dceoy/hugo server --bind=0.0.0.0 --buildDrafts --watch
```

Run a web server with docker-compose

```sh
$ docker-compose -f /path/to/docker-hugo/docker-compose.yml up
```
