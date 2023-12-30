#!/bin/bash

#aarch64/raspberrypi4b
#aarch64/xilinx_versal_qemu
#xilinx_zynqmp_lp64_qemu
cd /home/yangn0/devel/rtems-aarch64/src/rtems-libbsd
./waf distclean
./waf configure --prefix=$HOME/devel/rtems-aarch64/rtems/6 \
      --rtems-bsps=aarch64/raspberrypi4b \
      --buildset=buildset/default.ini
./waf
./waf install