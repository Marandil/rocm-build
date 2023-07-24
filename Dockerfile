FROM ubuntu:22.04 AS rocm-build

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
        build-essential \
        ninja-build \
        cmake \
        git \
        git-lfs \
        repo \
        libnuma-dev \
        python3 \
        python3-pip

RUN mkdir -p /source \
 && cd /source \
   && mkdir rocm-build \
   && mkdir ROCm \
   && cd ROCm \
     && git config --global user.email "marcin.slowik@myrelabs.com" \
     && git config --global user.name  "Marcin Slowik" \
     && repo init -u https://github.com/RadeonOpenCompute/ROCm.git -b roc-5.6.x

RUN cd /source/ROCm && repo sync

COPY env.sh install-dependency.sh cleanup-build.sh /source/rocm-build/
WORKDIR /source/rocm-build/

RUN . env.sh \
 && DEBIAN_FRONTEND=noninteractive ./install-dependency.sh \
 && mkdir -p $ROCM_BUILD_DIR \
 && mkdir -p $ROCM_PATCH_DIR \
 && mkdir -p $ROCM_DIST_DIR

COPY 00.rocm-core.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/00.rocm-core.sh \
 && /source/rocm-build/cleanup-build.sh rocm-core

COPY 11.rocm-llvm.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/11.rocm-llvm.sh \
 && /source/rocm-build/cleanup-build.sh llvm-amdgpu

COPY 12.roct-thunk-interface.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/12.roct-thunk-interface.sh \
 && /source/rocm-build/cleanup-build.sh roct-thunk-interface

COPY 13.rocm-cmake.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/13.rocm-cmake.sh \
 && /source/rocm-build/cleanup-build.sh rocm-cmake

COPY 14.rocm-device-libs.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/14.rocm-device-libs.sh \
 && /source/rocm-build/cleanup-build.sh rocm-device-libs

COPY 15.rocr-runtime.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/15.rocr-runtime.sh \
 && /source/rocm-build/cleanup-build.sh rocr-runtime

COPY 16.rocminfo.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/16.rocminfo.sh \
 && /source/rocm-build/cleanup-build.sh rocminfo

COPY 17.rocm-compilersupport.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/17.rocm-compilersupport.sh \
 && /source/rocm-build/cleanup-build.sh rocm-compilersupport

COPY 18.hipcc.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/18.hipcc.sh

COPY 20.clr.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/20.clr.sh

COPY 21.rocfft.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/21.rocfft.sh

COPY 22.rocblas.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/22.rocblas.sh

COPY 23.rocprim.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/23.rocprim.sh

COPY 24.rocrand.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/24.rocrand.sh

COPY 25.rocsparse.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/25.rocsparse.sh

COPY 26.hipsparse.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/26.hipsparse.sh

COPY 27.rocm_smi_lib.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/27.rocm_smi_lib.sh

COPY 28.rccl.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/28.rccl.sh

COPY 29.hipfft.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/29.hipfft.sh

COPY 31.rocm-opencl-runtime.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/31.rocm-opencl-runtime.sh

COPY 32.clang-ocl.sh /source/rocm-build/
RUN . /source/rocm-build/env.sh \
 ;  /source/rocm-build/32.clang-ocl.sh


# COPY 33.roctracer.sh /source/rocm-build/
# RUN . /source/rocm-build/env.sh \
#  && echo

# COPY 35.miopen.sh /source/rocm-build/
# RUN . /source/rocm-build/env.sh \
#  && echo

# COPY 43.rocgdb.sh /source/rocm-build/
# RUN . /source/rocm-build/env.sh \
#  && echo

# COPY 51.rocsolver.sh /source/rocm-build/
# RUN . /source/rocm-build/env.sh \
#  && echo

# # COPY 62.rock-dkms.sh /source/rocm-build/
# # RUN . /source/rocm-build/env.sh \
# #  && echo

# COPY 73.rocmvalidationutil.sh /source/rocm-build/
# RUN . /source/rocm-build/env.sh \
#  && echo

# COPY 74.rocr_debug_agent.sh /source/rocm-build/
# RUN . /source/rocm-build/env.sh \
#  && echo
