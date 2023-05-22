[![Bit Docker](https://img.shields.io/badge/Bit-Docker-086dd7)](https://hub.docker.com/u/bitsrc) [![Bit Docker Node 17](https://img.shields.io/badge/Image-bitsrc/dev--node17:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node17) [![Bit Docker Node 16 More Heap](https://img.shields.io/badge/Image-bitsrc/dev--node16m:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node16m) [![Bit Docker Node 16](https://img.shields.io/badge/Image-bitsrc/dev--node16:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node16) [![Bit Docker Node 15](https://img.shields.io/badge/Image-bitsrc/dev--node15:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node15)
# Docker Images for Bit Application Development

## Installing Docker

Install Docker using [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Using the Image

The `bit` images come in many flavors, each designed for a specific use case.

> `bitsrc/dev-node<node-version>:<bit-version>`

**Note:** Choose the image with the node version that you prefer. If you have multiple app components, expose the ports accordingly. Each container version is aligned with the corresponding Bit version. Vist [DockerHub](https://hub.docker.com/r/bitsrc) to explore different variants.

```sh
docker run -it -v "$(pwd)":/workspace -p 3000:3000 bitsrc/dev-node16mx:0.1.48
```

When specifying the mounting path, refer [file sharing](https://docs.docker.com/desktop/settings/mac/#file-sharing) guidelines in Docker Desktop.
- `$(pwd)`  - (Mount current working directory)
- `/Users`  - (Mount `Users` Directory in MacOS)
- `/Users/<your-username>/<project-directory>`  - (Mount the project directory in MacOS)

Use the [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) to easily access containers. To reconnect to a running container manually:

1. Check the container ID by using. If the container is not running you can first start it.
```sh
docker ps
```

2. Connect to the container
```sh
docker exec -it <container-id> /bin/bash
```

# Contributor Guide
If you plan to push a new image to Docker Hub, you can follow the below steps.

**Note:** Use the correct node version suffix to the image name.

1. Build the docker image locally

```sh
docker build --build-arg NODE_IMAGE_VARIANT=16 --build-arg BIT_VERSION=0.1.48 --build-arg NODE_HEAP_SIZE=2048 -t bitsrc/node-16:0.1.48 .
```

## BIT_VERSION (Required)

This is the version of Bit, used in the image. To check for latest bvm version use the following command.

```sh
bvm version
```

Then specify it as a build-arg to the image (e.g Bit version 0.1.48).

```
docker build --build-arg BIT_VERSION=0.1.48 -t bitsrc/node-16:0.1.48 .
```

## NODE_IMAGE_VARIENT (Optional, Default=16)

You can specify the base Node image varient for the docker image. We would recommend to use one of the below varients that supports Bit.

- 15
- 16
- 17

Then specify it as a build-arg to the image (e.g Node image variant 17).
```
docker build --build-arg BIT_VERSION=0.1.48 --build-arg NODE_IMAGE_VARIANT=17 -t bitsrc/node-17:0.1.48 .
```

**Note:** You can find other Node image variants in [Docker Hub - Node Image](https://hub.docker.com/_/node).

## NODE_HEAP_SIZE (Optional, Default 2048)

You can specify a custom heap size for the image. However, we would recommend to use one of the below sizes.

- 2048
- 4096
- 8192

Then specify it as a build-arg to the image (e.g Heap memory 2048).

```
docker build --build-arg BIT_VERSION=0.1.48 --build-arg NODE_HEAP_SIZE=2048 -t bitsrc/node-16:0.1.48 .
```

```
docker build --build-arg BIT_VERSION=0.1.48 --build-arg NODE_HEAP_SIZE=4096 -t bitsrc/node-16m:0.1.48 .
```

```
docker build --build-arg BIT_VERSION=0.1.48 --build-arg NODE_HEAP_SIZE=8192 -t bitsrc/node-16mx:0.1.48 .
```

**Note:** For image naming convensions, use the suffix `m` for 4096 and `mx` for 8192, as a part of the image name.

2. Push the docker image to Docker Hub

```
docker push bitsrc/dev-node16:0.1.48
```

3. Update this READ.ME file, with the newly created docker image variants.

   [![Bit Docker Node 16](https://img.shields.io/badge/Image-bitsrc/dev--node16:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node16)

---

### Useful Commands

You can use the Docker Desktop to perform below actions.

**Show images**
```sh
docker images
```

**Show running containers**
```sh
docker ps
```

**Run a stopped docker container**
```sh
docker start <container-name>
```

**Show all docker containers**
```sh
docker ps -a
```

**Delete docker image**
```sh
docker rmi <image-name>
```

**Delete all dangling docker images (images without names)**
```sh
docker image prune
```

**Delete docker container**
```sh
docker rm <container-name>
```