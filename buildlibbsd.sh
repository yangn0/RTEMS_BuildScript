#!/bin/bash

export arch=arm
export bsp=arm/xilinx_zynq_a9_qemu
export PATH=$HOME/RTEMS_devel/rtems/6/bin:$PATH
#aarch64/raspberrypi4b
#aarch64/xilinx_versal_qemu
#xilinx_zynqmp_lp64_qemu
#arm/xilinx_zynq_a9_qemu
cd ~/RTEMS_devel/src/rtems-libbsd
# ./waf distclean
./waf configure --prefix=$HOME/RTEMS_devel/rtems/6 \
      --rtems-bsps=$bsp \
      --buildset=buildset/everything.ini
./waf
./waf install

export buildset=everything
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/media01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/telnetd01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/ftpd01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/netshell01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/ping01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/init01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/ipsec01.exe kernel8.img

# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/rtems/6/bin/ttcpshell01.exe kernel8.img
# cp kernel8.img /mnt/c/Users/79230/Desktop/tftp/