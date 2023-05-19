[![Bit Docker](https://img.shields.io/badge/Bit-Docker-086dd7)](https://hub.docker.com/r/bitsrc/devimage) [![Bit Docker](https://img.shields.io/badge/Image-bitsrc/devimage:0.1.46-yellow)](https://hub.docker.com/layers/bitsrc/devimage/0.1.46/images/sha256-ab2bffdcdd51ea5919dec32b708ea2568b170687c49e5d9f9865af2f831679ba?context=explore)
# Docker Image for Bit Application Development

## Installing Docker

Install Docker using [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Using the Image from Docker Hub
```sh
docker run -it -v /Users/../<your-project-directory>:/workspace bitsrc/devimage:0.1.46
```
Each container version is aligned with the corresponding Bit version. Vist [DockerHub](https://hub.docker.com/r/bitsrc/devimage)to explore different versions.

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
docker rmi
```

**Delete docker container**
```sh
docker rm <image-name>
```
