#!/bin/bash

echo "Hi merlin user just wait and watch "

mkdir outM
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
make O=outM ARCH=arm64 merlin_defconfig
export PATH="~/proton-clang/aaa/bin:${PATH}"
make -j$(nproc --all) O=outM \
                      ARCH=arm64 \
                      LD=~/proton-clang/aaa/bin/ld.lld \
		       OBJCOPY=~/proton-clang/aaa/bin/llvm-objcopy \
		       AS=~/proton-clang/aaa/bin/llvm-as \
		       NM=~/proton-clang/aaa/bin/llvm-nm \
		       STRIP=~/proton-clang/aaa/bin/llvm-strip \
		       OBJDUMP=~/proton-clang/aaa/bin/llvm-objdump \
		       READELF=~/proton-clang/aaa/bin/llvm-readelf \
                      CC=~/proton-clang/aaa/bin/clang \
                      CROSS_COMPILE=~/proton-clang/aaa/bin/aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=~/proton-clang/aaa/bin/arm-linux-gnueabi- 
bp=${PWD}/outM
DATE=$(date "+%Y%m%d-%H%M")
ZIPNAME="Shas-Dream-Merlin-R-vendor"
cd ${PWD}/AnyKernel3-master
rm *.zip *-dtb 
cp $bp/arch/arm64/boot/Image.gz-dtb .
zip -r9 "$ZIPNAME"-"${DATE}".zip *
cd - || exit
