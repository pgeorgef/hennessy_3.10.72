#
# Copyright © 2016, Kunal Kene "kunalkene1797" <kunalkene1797@gmail.com>
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

# Init Script
KERNEL_DIR=$PWD
IMAGE=$KERNEL_DIR/arch/arm64/boot/Image
BUILD_START=$(date +"%s")

# Color Code Script
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
nocol='\033[0m'         # Default

# Tweakable Options Below
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="smosia"
export KBUILD_BUILD_HOST="smosia"
export CROSS_COMPILE="/home/android/aarch64-linux-android-4.9/bin/aarch64-linux-android-"

# Compilation Scripts Are Below
compile_kernel ()
{
echo -e "$White***********************************************"
echo "         Compiling Hennessy Kernel            "
echo -e "***********************************************$nocol"
make clean && make mrproper
make hennessy_defconfig
make -j3 CONFIG_NO_ERROR_ON_MISMATCH=y

}

# Finalizing Script Below
case $1 in
clean)
make  CONFIG_NO_ERROR_ON_MISMATCH=y ARCH=arm64 -j6 clean mrproper
rm -rf include/linux/autoconf.h
;;
*)
compile_kernel
;;
esac
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
