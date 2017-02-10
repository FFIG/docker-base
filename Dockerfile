# Defines an image that is used as the base for all FFIG Docker images. This
# includes the dependencies required to build and use FFIG, but not the FFIG
# code or derived applications.

FROM ubuntu:16.04
MAINTAINER FFIG <support@ffig.org>

RUN apt-get -y update && \
    apt-get install -y \
        python-software-properties \
        software-properties-common

# Software dependencies - sorted alphabetically
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get -y update && \
    apt-get install -y \
        clang \
        cmake \
        git \
        golang \
        libc++-dev \
        libc++1 \
        libclang-3.8-dev \
        ninja-build \
        pypy \
        python-pip \
        python3 \
        python3-pip \
        ruby \
        ruby-dev

# Python dependencies
RUN pip install --upgrade pip && \
    pip install jinja2 nose && \
    pip3 install --upgrade pip && \
    pip3 install jinja2 nose

# Ruby dependencies
RUN gem install ffi

# Cleanup
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# User and environment setup
RUN useradd c-api-user && \
    mkdir -p /home/ffig && \
    chown c-api-user /home/ffig

ENV HOME=/home/ffig \
    LD_LIBRARY_PATH=/usr/lib/llvm-3.8/lib:$LD_LIBRARY_PATH
