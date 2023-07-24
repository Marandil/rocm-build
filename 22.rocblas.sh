#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocblas
cd $ROCM_BUILD_DIR/rocblas

# cd $ROCM_GIT_DIR/rocBLAS
# bash $ROCM_GIT_DIR/rocBLAS/install.sh -d

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/bin/hipcc cmake \
    -DAMDGPU_TARGETS="$AMDGPU_TARGETS" \
    -DROCM_PATH="$ROCM_INSTALL_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DTensile_LOGIC=asm_full \
    -DTensile_ARCHITECTURE=all \
    -DTensile_CODE_OBJECT_VERSION=V3 \
    -DTensile_LIBRARY_FORMAT=yaml \
    -DTensile_COMPILER=hipcc \
    -DRUN_HEADER_TESTING=OFF \
    -DBUILD_FILE_REORG_BACKWARD_COMPATIBILITY=ON \
    -DCPACK_SET_DESTDIR=OFF \
    -DCMAKE_INSTALL_PREFIX=rocblas-install \
    -DCPACK_PACKAGING_INSTALL_PREFIX="$ROCM_INSTALL_DIR" \
    -DCPACK_GENERATOR=DEB \
    -G Ninja \
    $ROCM_GIT_DIR/rocBLAS

cmake --build .
cmake --build . --target package
$RUN_DPKG -i *.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"
