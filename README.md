docker-hugo
===========

Dockerfile for Hugo

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/hugo/).

```sh
$ docker pull dceoy/hugo
```

Run a container

```sh
$ docker container run --rm -it -p 1313:1313 -v $(pwd):/work -w /work dceoy/hugo -h
```
