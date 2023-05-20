[![Bit Docker](https://img.shields.io/badge/Bit-Docker-086dd7)](https://hub.docker.com/u/bitsrc) [![Bit Docker Node 17](https://img.shields.io/badge/Image-bitsrc/dev--node17:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node17) [![Bit Docker Node 16 More Heap](https://img.shields.io/badge/Image-bitsrc/dev--node16m:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node16m) [![Bit Docker Node 16](https://img.shields.io/badge/Image-bitsrc/dev--node16:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node16) [![Bit Docker Node 15](https://img.shields.io/badge/Image-bitsrc/dev--node15:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node15)
# Docker Images for Bit Application Development

## Installing Docker

Install Docker using [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Using the Image from Docker Hub

**Note:** Choose the image with the node version that you prefer. If you have multiple app components, expose the ports accordingly. Each container version is aligned with the corresponding Bit version. Vist [DockerHub](https://hub.docker.com/r/bitsrc/devimage) to explore different versions.

```sh
docker run -it -v ~/Workspace:/workspace -p 3000:3000 bitsrc/dev-node16m:0.1.46
```
When choosing the mounting path, refer [file sharing](https://docs.docker.com/desktop/settings/mac/#file-sharing) guidelines in Docker Desktop.
- **/Users**
- **~/Workspace**

Use the [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) to easily access containers. To reconnect to a running container manually:

1. Check the container ID by using. If the container is not running you can first start it.
```sh
docker ps
```

2. Connect to the container
```sh
docker exec -it <container-id> /bin/bash
```

---
## Building a Custom Docker Image
You can build your custom image using the Docker file and create a container with Bit for application development. You can customize the Dockerfile to use a different Node version.

### Building the Docker Image
```sh
docker build -t <my-bit-image> .
```
### Creating a Docker Container with Mounted Volume 
```sh
docker run -it -v /Users:/workspace <my-bit-image>
```
**Note:** Ensure that sharing is allowed for the local volume. The local path is the absolute path and case sensitive. 

### Other Useful Commands

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

# Contributor Guide
If you plan to push a new image to Docker Hub, you can follow the below steps.

**Note:** Use the correct node version suffix to the image name.

1. Build the docker image locally

```sh
docker build -t bitsrc/dev-node16:0.1.46 .

```

2. Push the docker image

```
docker push bitsrc/dev-node:0.1.46
```

3. Update this Readme file by adding or updating the badge with the latest Bit version, for each Node.js version.

   [![Bit Docker Node 16](https://img.shields.io/badge/Image-bitsrc/dev--node16:0.1.46-brightgreen)](https://hub.docker.com/r/bitsrc/dev-node16)
