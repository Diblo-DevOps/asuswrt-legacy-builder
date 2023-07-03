# Asuswrt Legacy Builder
Docker images based on Ubuntu 20.04 that contain necessary tools.
You might want to use this to build AsusWRT Merling legacy firmware v380.70 yourself.
It supports RT-N16, RT-N66U, RT-AC66U and RT-AC56U, but it has only been tested with RT-AC66U.

**Warning: Compiling firmware from source is at your own risk!**

## Usage

```bash
docker volume create asuswrt-src
docker pull diblo/asuswrt-legacy-builder:latest
docker run -it --rm -v "$PWD:/image" -v asuswrt-src:/source diblo/asuswrt-legacy-builder:latest /bin/bash

```

From within the docker image:
1. Download and patch the source code with `setup-src`
2. Set the environment variables by `source /opt/envs/[rt-n16, rt-n66u, rt-ac66u, rt-ac56u]`

When you have set the environment you will be in the workdir.
From here you can build the firmware with `make clean && make [rt-n16, rt-n66u, rt-ac66u, rt-ac56u]`.
Once the image is built, it can be copied from the `<workdir>/image` folder to the `/image` folder.
