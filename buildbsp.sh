#!/bin/bash
export rtems_src=rtems
# export rtems_src=utk-rtems

cd ~/RTEMS_devel/src/$rtems_src
./waf distclean
./waf configure --prefix=$HOME/RTEMS_devel/rtems/6
./waf
./waf install

# export bsp=xilinx_versal_qemu
# export bsp=raspberrypi4b
# app=~/RTEMS_devel/src/rtems/build/aarch64/$bsp/testsuites/samples/hello.exe
# app=~/RTEMS_devel/src/rtems/build/aarch64/$bsp/testsuites/sptests/spconsole01.exe
# cp $app /mnt/c/Users/79230/Desktop/test.exe
# qemu-system-aarch64.exe -no-reboot -nographic -serial mon:stdio -machine virt,gic-version=3 -cpu cortex-a72 -m 4096 -d trace:pl011_baudrate_change -kernel $app

# app=~/RTEMS_devel/src/rtems/build/aarch64/a53_lp64_qemu/testsuites/sptests/spconsole01.exe
# qemu-system-aarch64.exe -no-reboot -nographic -serial mon:stdio  -machine virt,gic-version=3 -cpu cortex-a53 -m 4096 -d trace:pl011_baudrate_change -kernel $app

# qemu-system-aarch64.exe -no-reboot -nographic -serial mon:stdio -machine xlnx-versal-virt -m 4096 -d trace:pl011_baudrate_change -kernel $app
# qemu-system-aarch64 -no-reboot -nographic -serial mon:stdio -machine xlnx-zcu102 -m 4096 -net nic,model=cadence_gem -net tap,ifname=qtap,script=no,downscript=no -kernel example.exe