# Asuswrt Legacy Builder
Docker images based on Ubuntu 20.04 that contain necessary tools.
You might want to use this to build AsusWRT Merling legacy firmware v380.70 yourself.
It supports RT-N16, RT-N66U, RT-AC66U and RT-AC56U, but it has only been tested with RT-AC66U.

**Warning: Compiling firmware from source is at your own risk!**

## Setup
```bash
docker volume create asuswrt-src
docker pull diblo/asuswrt-legacy-builder:latest
docker run -it --rm -v asuswrt-src:/source diblo/asuswrt-legacy-builder:latest /bin/bash
```

From the docker image, download and patch the source code with:
```bash
setup-src
```

NOTE: the source code is stored in the volume `asuswrt-src`.

## Usage
```bash
docker run -it --rm -v "$PWD:/image" -v asuswrt-src:/source diblo/asuswrt-legacy-builder:latest /bin/bash
```

From the docker image, set the environment variables by:
```bash
source /opt/envs/[rt-n16, rt-n66u, rt-ac66u, rt-ac56u]
```

Once you have set the environment, you will be in the working directory. From here you can build the firmware with:
```bash
make clean && make [rt-n16, rt-n66u, rt-ac66u, rt-ac56u]
```

Once the image is built, it can be copied from the `<workdir>/image` folder to the `/image` folder.

NOTE: the AsusWRT image is stored in the volume `asuswrt-src`.
