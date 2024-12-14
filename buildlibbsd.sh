#!/bin/bash

export PATH=$HOME/RTEMS_devel/rtems/6/bin:$PATH

export arch=arm
export bsp=xilinx_zynq_a9_qemu

# export arch=aarch64
# export bsp=raspberrypi4b
#xilinx_versal_qemu
#xilinx_zynqmp_lp64_qemu

export buildset=everything

cd ~/RTEMS_devel/src/rtems-libbsd
# ./waf uninstall
# ./waf distclean
./waf configure --prefix=$HOME/RTEMS_devel/rtems/6 \
      --rtems-bsps=$arch/$bsp \
      --buildset=buildset/$buildset.ini \
      # --enable-auto-regen
./waf
./waf install

if [ "$bsp" = xilinx_zynq_a9_qemu ]; then

# sudo ip tuntap add qtap mode tap user $(whoami)
# sudo ip link set dev qtap up
# sudo ip addr add 169.254.1.1/16 dev qtap

qemu-system-arm -serial null -serial mon:stdio -nographic \
  -M xilinx-zynq-a9 -m 256M \
  -net nic,model=cadence_gem \
  -net tap,ifname=qtap,script=no,downscript=no \
  -kernel build/arm-rtems6-xilinx_zynq_a9_qemu-$buildset/media01.exe
fi

if [ "$bsp" = raspberrypi4b ]; then

cd ~/RTEMS_devel
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/media01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/telnetd01.exe kernel8.img
$arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/ftpd01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/netshell01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/ping01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/init01.exe kernel8.img
# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/src/rtems-libbsd/build/aarch64-rtems6-raspberrypi4b-$buildset/ipsec01.exe kernel8.img

# $arch-rtems6-objcopy -O binary $HOME/RTEMS_devel/rtems/6/bin/ttcpshell01.exe kernel8.img
cp kernel8.img /mnt/c/Users/79230/Desktop/tftp/

# qemu-system-aarch64 -M raspi4b -serial mon:stdio -nographic -kernel /mnt/c/Users/79230/Desktop/tftp/kernel8.img

fi