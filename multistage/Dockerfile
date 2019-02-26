ARG PYTHON_VERSION_SHORT=3.5
ARG OPENCV_VERSION=4.0.0
ARG CPU_CORES=4

FROM arm32v7/python:${PYTHON_VERSION_SHORT}-stretch

ARG DEBIAN_FRONTEND=noninteractive

RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        apt-utils \
        build-essential; \
    apt-get install -y --no-install-recommends \
        # Build utils
        cmake \
        git \
        pkg-config \
        unzip \
        wget \
        # Required dependencies
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        # Optional dependencies
        python-numpy \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libdc1394-22-dev; \
    # Clear apt cache
    rm -rf /var/lib/apt/lists/*

RUN pip install numpy

ARG OPENCV_VERSION
ENV OPENCV_VERSION=$OPENCV_VERSION

# Download latest source and contrib
RUN set -e; \
    cd /tmp; \
    wget -c -nv -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip; \
    unzip opencv.zip; \
    wget -c -nv -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip; \
    unzip opencv_contrib.zip

ARG PYTHON_VERSION_SHORT
ENV PYTHON_VERSION=$PYTHON_VERSION_SHORT

ARG CPU_CORES

# Build opencv
RUN set -e; \
    cd /tmp/opencv-$OPENCV_VERSION; \
    mkdir build; \
    cd build; \
    mkdir /opt/opencv; \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-$OPENCV_VERSION/modules \
        -D CMAKE_INSTALL_PREFIX=/opt/opencv \
        -D PYTHON2_EXECUTABLE=$(which python${PYTHON_VERSION}) \
        -D PYTHON3_EXECUTABLE=$(which python${PYTHON_VERSION}) \
        -D PYTHON_INCLUDE_DIR=$(python${PYTHON_VERSION} -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
        -D PYTHON_PACKAGES_PATH=$(python${PYTHON_VERSION} -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
        # Build without GUI support
        -D WITH_QT=OFF \
        -D WITH_GTK=OFF \
        # Build with python
        -D BUILD_PYTHON_SUPPORT=ON \
        -D BUILD_NEW_PYTHON_SUPPORT=ON \
        # Ignore all unnecessary stages
        -D BUILD_opencv_apps \
        -D BUILD_SHARED_LIBS \
        -D BUILD_EXAMPLES=OFF \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D BUILD_DOCS=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D BUILD_TESTS \
        ..; \
    make -j$CPU_CORES; \
    make install; \
    ldconfig; \
    # Clean up
    make clean; \
    cd /tmp; \
    rm -rf /tmp/*

CMD ["/bin/bash"]

