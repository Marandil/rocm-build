#!/bin/bash

set -e

# Otherwise this is a disaster waiting to happen
[ -z "$ROCM_BUILD_DIR" ] && echo "Missing ROCM_BUILD_DIR" && exit 1
[ -z "$1" ]              && echo "Missing argument (CLEANUP_BUILD_DIR dirname)" && exit 1

CLEANUP_BUILD_DIR="$ROCM_BUILD_DIR/$1"

# Copy deb packages from $CLEANUP_BUILD_DIR to dist dir and remove it
cp "$CLEANUP_BUILD_DIR/*.deb" "$ROCM_DIST_DIR/"
rm -rf "$CLEANUP_BUILD_DIR"
