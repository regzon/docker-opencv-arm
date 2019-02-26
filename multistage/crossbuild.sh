docker run --rm --privileged multiarch/qemu-user-static:register --reset
docker build -t opencv-arm-multistage:4.0.0-py3.5 -f Dockerfile-crossbuild .
