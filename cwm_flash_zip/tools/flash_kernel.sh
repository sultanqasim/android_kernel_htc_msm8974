#!/sbin/sh
#
# Live ramdisk patching script
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

cd /tmp/
/sbin/busybox dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=./boot.img
./unpackbootimg -i /tmp/boot.img
./mkbootimg --kernel /tmp/zImage --ramdisk /tmp/boot.img-ramdisk.gz --cmdline "console=none androidboot.hardware=qcom user_debug=31 ehci-hcd.park=3 zcache" --base 0x00000000 --pagesize 2048 --kernel_offset 0x00008000 --ramdisk_offset 0x02008000 --tags_offset 0x01e00000 --dt /tmp/dt.img -o /tmp/newboot.img
/sbin/busybox dd if=/tmp/newboot.img of=/dev/block/platform/msm_sdcc.1/by-name/boot
