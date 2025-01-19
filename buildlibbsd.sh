#!/bin/bash
export rtems_version=6
export PATH=$HOME/RTEMS_devel/rtems/$rtems_version/bin:$PATH

export arch=aarch64
export bsp=zynqmp_qemu
# export bsp=xilinx_zynq_a9_qemu

# export arch=aarch64
# export bsp=raspberrypi4b
#xilinx_versal_qemu
#xilinx_zynqmp_lp64_qemu xilinx_zynq_a9_qemu


export buildset=everything
# export test_name=media01
export test_name=ipsec01
# export test_name=crypto01

cd ~/RTEMS_devel/src/rtems-libbsd
# ./waf uninstall
./waf distclean
./waf configure --prefix=$HOME/RTEMS_devel/rtems/$rtems_version \
      --rtems-bsps=$arch/$bsp \
      --buildset=buildset/$buildset.ini
      # --enable-auto-regen
./waf
./waf install

if [ "$bsp" = xilinx_zynq_a9_qemu ]; then

# sudo ip tuntap add qtap mode tap user $(whoami)
# sudo ip link set dev qtap up
# sudo ip addr add 169.254.1.1/16 dev qtap
# -S -s
qemu-system-arm  -S -s -serial null -serial mon:stdio -nographic \
  -M xilinx-zynq-a9 -m 256M \
  -net nic,model=cadence_gem \
  -net tap,ifname=qtap,script=no,downscript=no \
  -kernel build/$arm-rtems6-xilinx_zynq_a9_qemu-$buildset/$test_name.exe
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

if [ "$bsp" = zynqmp_qemu ]; then
# sudo ip tuntap add qtap mode tap user $(whoami)
# sudo ip link set dev qtap up
# sudo ip addr add 169.254.1.1/16 dev qtap
qemu-system-aarch64 -no-reboot -nographic  \
    -serial mon:stdio -machine xlnx-zcu102 -m 4096 \
    -net nic,model=cadence_gem \
    -net tap,ifname=qtap,script=no,downscript=no \
    -kernel build/aarch64-rtems$rtems_version-zynqmp_qemu-$buildset/$test_name.exe
fi