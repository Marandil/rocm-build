#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/hipcc
cd $ROCM_BUILD_DIR/hipcc

HIP_DIR=$ROCM_GIT_DIR/HIP

START_TIME=`date +%s`

cmake \
    -DCMAKE_PREFIX_PATH="$ROCM_INSTALL_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_GENERATOR=DEB \
    -DROCM_PATCH_VERSION="$ROCM_LIBPATCH_VERSION" \
    -DCMAKE_INSTALL_PREFIX="$ROCM_BUILD_DIR/hipcc/install" \
    -DCPACK_PACKAGING_INSTALL_PREFIX="$ROCM_INSTALL_DIR" \
    -G Ninja \
    $ROCM_GIT_DIR/HIPCC

cmake --build .
cmake --build . --target package
# $RUN_DPKG -i hipcc*.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"
