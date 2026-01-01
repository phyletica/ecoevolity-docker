# About

![Docker Image Version](https://img.shields.io/docker/v/phyletica/ecoevolity-docker)

This repository contains a Dockerfile for building a Docker image with
[ecoevolity](http://phyletica.org/ecovolity)
and
[pycoevolity](https://github.com/phyletica/pycoevolity)
preinstalled.

# How to manually update image on docker hub

## 1. Build the docker image locally

Navigate to this directory and build the docker image:

```bash
cd path/to/ecoevolity-docker
sudo docker build --pull --no-cache -t phyletica/ecoevolity-docker:latest .
```

The `--pull` flag forces docker to download the latest version of the base
image.
The `--no-cache` flag forces docker to do a fresh build (not reuse cached
layers).

To verify the image exists locally, run:

```bash
sudo docker image ls
```

## 2. Log in to docker hub

You need to be logged in to docker hub to upload the new image.
To authenticate your docker hub account, use the following command:

```bash
sudo docker login
```

## 3. Push the new image to docker hub

Once the new build is finished and you are logged in, use the following command
to upload the image to the docker hub repo:

```bash
sudo docker push phyletica/ecoevolity-docker:latest
```
