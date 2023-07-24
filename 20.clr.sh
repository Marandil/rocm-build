#!/bin/bash

# https://rocm.docs.amd.com/projects/HIP/en/docs-5.6.0/developer_guide/build.html

set -e

mkdir -p $ROCM_BUILD_DIR/clr
cd $ROCM_BUILD_DIR/clr

HIPCC_BUILD_DIR=$ROCM_BUILD_DIR/hipcc
HIP_DIR=$ROCM_GIT_DIR/HIP

START_TIME=`date +%s`

cmake \
    -DOFFLOAD_ARCH_STR="--offload-arch=$AMDGPU_TARGETS" \
    -DHIP_PLATFORM=amd \
    -DHIP_COMMON_DIR="$HIP_DIR" \
    -DHIPCC_BIN_DIR="$HIPCC_BUILD_DIR" \
    -DCLR_BUILD_HIP=On \
    -DCLR_BUILD_OCL=Off \
    -DCMAKE_PREFIX_PATH="$ROCM_INSTALL_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_GENERATOR=DEB \
    -DROCM_PATCH_VERSION="$ROCM_LIBPATCH_VERSION" \
    -DCMAKE_INSTALL_PREFIX="$ROCM_BUILD_DIR/clr/install" \
    -DCPACK_PACKAGING_INSTALL_PREFIX="$ROCM_INSTALL_DIR" \
    -G Ninja \
    $ROCM_GIT_DIR/clr

cmake --build .
cmake --build . --target package
$RUN_DPKG -i hip-dev*.deb $HIPCC_BUILD_DIR/hipcc*.deb hip-doc*.deb hip-runtime-amd*.deb # hip-samples*.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"
