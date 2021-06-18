docker-hugo
===========

Dockerfile for Hugo

[![CI to Docker Hub](https://github.com/dceoy/docker-hugo/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/dceoy/docker-hugo/actions/workflows/docker-publish.yml)

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/hugo/).

```sh
$ docker image pull dceoy/hugo
```

Usage
-----

Run hugo commands

```sh
# Run a web server
$ docker container run --rm -p 1313:1313 -v ${PWD}:/work -w /work \
    dceoy/hugo server --bind=0.0.0.0 --buildDrafts --watch

# Create a new content
$ docker container run --rm -v ${PWD}:/work -w /work \
    dceoy/hugo new post/new.md
```

Run hugo commands with docker-compose

```sh
# Run a web server
$ docker-compose -f /path/to/docker-hugo/docker-compose.yml up

# Execute another command
$ docker-compose -f /path/to/docker-hugo/docker-compose.yml \
    run --rm hugo <hugo_command>
```
