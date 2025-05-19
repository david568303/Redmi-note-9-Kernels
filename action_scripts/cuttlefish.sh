#!/bin/bash

# Toolchain paths
export CLANG_PATH=~/toolchain/clang-r383902
export GCC_PATH=~/toolchain/aarch64-linux-android-4.9

# Kernel build settings
export ARCH=arm64
export SUBARCH=arm64
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=aarch64-linux-android-
export PATH=$CLANG_PATH/bin:$GCC_PATH/bin:$PATH

# Optional: Suppress section mismatch warnings (use carefully)
export KCFLAGS=-w
export CONFIG_SECTION_MISMATCH_WARN_ONLY=y

# Clean old output (optional)
# rm -rf out

# Configure the kernel
make O=out cuttlefish_defconfig

# Build the kernel
make -j$(nproc --all) \
    O=out \
    ARCH=$ARCH \
    SUBARCH=$SUBARCH \
    CC=clang \
    CLANG_TRIPLE=$CLANG_TRIPLE \
    CROSS_COMPILE=$CROSS_COMPILE \
    LLVM=1 \
    KCFLAGS="$KCFLAGS" \

# Copy the output image
cp out/arch/arm64/boot/Image arch/arm64/boot/Image
