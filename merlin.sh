!/bin/bash

echo "Hi merlin user just wait and watch "

mkdir outM
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
make O=outM ARCH=arm64 merlin_defconfig
export PATH="~/clang-15/aaa/bin:${PATH}"
make -j$(nproc --all) O=outM \
                      ARCH=arm64 \
                      LD=~/clang-15/aaa/bin/ld.lld \
		       OBJCOPY=~/clang-15/aaa/bin/llvm-objcopy \
		       AS=~/clang-15/aaa/bin/llvm-as \
		       NM=~/clang-15/aaa/bin/llvm-nm \
		       STRIP=~/clang-15/aaa/bin/llvm-strip \
		       OBJDUMP=~/clang-15/aaa/bin/llvm-objdump \
		       READELF=~/clang-15/aaa/bin/llvm-readelf \
                      CC=~/clang-15/aaa/bin/clang \
                      CROSS_COMPILE=~/clang-15/aaa/bin/aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=~/clang-15/aaa/bin/arm-linux-gnueabi- 
bp=${PWD}/outM
DATE=$(date "+%Y%m%d-%H%M")
ZIPNAME="Shas-Dream-Merlin-R-vendor"
cd ${PWD}/AnyKernel3-master
rm *.zip *-dtb 
cp $bp/arch/arm64/boot/Image.gz-dtb .
zip -r9 "$ZIPNAME"-"${DATE}".zip *
cd - || exit
