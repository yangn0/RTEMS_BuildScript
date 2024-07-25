#!/bin/bash

export bsp=aarch64/raspberrypi4b
#aarch64/raspberrypi4b
#aarch64/xilinx_versal_qemu
#xilinx_zynqmp_lp64_qemu
#arm/xilinx_zynq_a9_qemu
cd ~/RTEMS_devel/src/rtems-libbsd
# ./waf distclean
./waf configure --prefix=$HOME/RTEMS_devel/rtems/6 \
      --rtems-bsps=$bsp \
      --buildset=buildset/default.ini
./waf
./waf install