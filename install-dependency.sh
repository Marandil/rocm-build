#!/bin/bash

# ubuntu 20.04
# apt-get install -y python-is-python3

# basic
apt-get install -y build-essential git git-lfs cmake ninja-build libnuma-dev python3 python3-pip

# 12.roct-thunk-interface
apt-get install -y libdrm-dev zlib1g-dev libudev-dev

# 15.rocr-runtime
apt-get install -y libelf-dev xxd

# 16.rocminfo
apt-get install -y pciutils kmod

# 20.clr
apt-get install -y mesa-common-dev \
                   dpkg-dev rpm libelf-dev rename liburi-encode-perl \
                   libfile-basedir-perl libfile-copy-recursive-perl libfile-listing-perl libfile-which-perl \
                   file doxygen graphviz

# 21.rocfft
apt-get install -y python3-dev

# 22.rocblas
apt-get install -y gfortran python3-venv libtinfo-dev libmsgpack-dev

# 33.roctracer
pip3 install cppheaderparser

# 35.miopen
apt-get install -y pkg-config libsqlite3-dev libbz2-dev

# 43.rocgdb
apt-get install -y bison flex gcc make ncurses-dev texinfo g++ zlib1g-dev \
                   libexpat-dev python3-dev liblzma-dev libbabeltrace-dev \
                   libbabeltrace-ctf-dev

# 51.rocsolver
apt-get install -y libfmt-dev

# 62.rock-dkms
apt-get install -y autoconf

# 73.rocmvalidationutil
apt-get install -y libpci3 libpci-dev doxygen unzip libpciaccess-dev

# 74.rocr_debug_agent
apt-get install -y libdw-dev
