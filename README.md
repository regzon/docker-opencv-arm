# docker-opencv-arm

Collection of Dockerfiles for building opencv in python for arm-based systems
with docker.

Using this repository you can build docker images with opencv to run them
on arm systems later. The only requirement is [Docker][docker-ce-link].

[docker-ce-link]: https://www.docker.com/products/docker-engine


## Usage

Build can be ran with `build.sh` (on arm systems) or with `crossbuild.sh` (on x86_64 system).
Crossbuild will patch the kernel with qemu first to allow it to execute arm binaries.


## Contents

Repository consists of two parts

### pre-installed image

This image has opencv already installed in python,
hence can be used as a base image for other images that use opencv-python.

### multistage image

This image is used for multistage building. It provides opencv binaries
in `/opt/opencv` directory that can be copied and then manually installed
as a python package.
