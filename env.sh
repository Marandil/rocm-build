#!/bin/bash

export ROCM_INSTALL_DIR=/opt/rocm
export ROCM_MAJOR_VERSION=5
export ROCM_MINOR_VERSION=6
export ROCM_PATCH_VERSION=0
export ROCM_VERSION=$ROCM_MAJOR_VERSION.$ROCM_MINOR_VERSION.$ROCM_PATCH_VERSION
export ROCM_LIBPATCH_VERSION=50600
export CPACK_DEBIAN_PACKAGE_RELEASE=22.04
export ROCM_PKGTYPE=DEB
export ROCM_GIT_DIR=/source/ROCm
export ROCM_BUILD_DIR=/source/rocm-build/build
export ROCM_PATCH_DIR=/source/rocm-build/patch
export ROCM_DIST_DIR=/source/rocm-build/dist
export AMDGPU_TARGETS="gfx1010;gfx1030"
# export CMAKE_DIR=/local/cmake-3.18.6-Linux-x86_64
export PATH=$ROCM_INSTALL_DIR/bin:$ROCM_INSTALL_DIR/llvm/bin:$ROCM_INSTALL_DIR/hip/bin:$PATH
# export PATH=$ROCM_INSTALL_DIR/bin:$ROCM_INSTALL_DIR/llvm/bin:$ROCM_INSTALL_DIR/hip/bin:$CMAKE_DIR/bin:$PATH

export RUN_DPKG="dpkg"  # override with echo to skip dpkg -i, or add sudo if not building as root
