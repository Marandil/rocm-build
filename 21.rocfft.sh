#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocfft
cd $ROCM_BUILD_DIR/rocfft

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/bin/hipcc cmake \
    -DAMDGPU_TARGETS="$AMDGPU_TARGETS" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_SET_DESTDIR=OFF \
    -DCPACK_PACKAGING_INSTALL_PREFIX="$ROCM_INSTALL_DIR" \
    -DCMAKE_INSTALL_PREFIX=rocfft-install \
    -G Ninja \
    $ROCM_GIT_DIR/rocFFT

cmake --build .
cmake --build . --target package
$RUN_DPKG -i *.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"
