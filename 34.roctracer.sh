#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/roctracer
cd $ROCM_BUILD_DIR/roctracer

START_TIME=`date +%s`

ROCTRACER_ROOT=$ROCM_GIT_DIR/roctracer
BUILD_TYPE=Release
PREFIX_PATH=$ROCM_INSTALL_DIR
PACKAGE_ROOT=$ROCM_INSTALL_DIR/roctracer
PACKAGE_PREFIX=$ROCM_INSTALL_DIR/roctracer
LD_RUNPATH_FLAG="-Wl,--enable-new-dtags -Wl,--rpath,$ROCM_INSTALL_DIR/lib:$ROCM_INSTALL_DIR/lib64"
HIP_API_STRING=1
export HIP_PATH=$ROCM_INSTALL_DIR/hip
export HSA_RUNTIME_INC=$ROCM_INSTALL_DIR/hsa/include/hsa/hsa.h

cmake \
    -DGPU_TARGETS="$AMDGPU_TARGETS" \
    -DCMAKE_MODULE_PATH=$ROCTRACER_ROOT/cmake_modules \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_PREFIX_PATH="$PREFIX_PATH" \
    -DCMAKE_INSTALL_PREFIX=$PACKAGE_ROOT \
    -DCPACK_PACKAGING_INSTALL_PREFIX=$PACKAGE_PREFIX \
    -DCPACK_GENERATOR="DEB" \
    -DCMAKE_SHARED_LINKER_FLAGS="$LD_RUNPATH_FLAG" \
    -DHIP_API_STRING="$HIP_API_STRING" \
    -DHIP_PATH=$ROCM_INSTALL_DIR/hip \
    -DHSA_RUNTIME_INC=$HSA_RUNTIME_INC \
    -G Ninja \
    $ROCTRACER_ROOT

cmake --build .
cmake --build . --target package
$RUN_DPKG -i *.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"
