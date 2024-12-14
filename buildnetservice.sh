export PATH=$HOME/RTEMS_devel/rtems/6/bin:$PATH
# export bsp=aarch64/raspberrypi4b
export bsp=aarch64/zynqmp_qemu

cd ~/RTEMS_devel/src/rtems-net-services

git submodule init
git submodule update

./waf uninstall
# ./waf distclean
./waf configure --prefix=$HOME/RTEMS_devel/rtems/6 --rtems-bsps $bsp
./waf
./waf install

export app=build/aarch64-rtems6-zynqmp_qemu/ttcpshell01.exe
# sudo ip tuntap add qtap mode tap user $(whoami)
# sudo ip link set dev qtap up
# sudo ip addr add 169.254.1.1/16 dev qtap
qemu-system-aarch64 -no-reboot -nographic  \
    -serial mon:stdio -machine xlnx-zcu102 -m 4096 \
    -net nic,model=cadence_gem \
    -net tap,ifname=qtap,script=no,downscript=no \
    -kernel $app
    # -nic user,model=cadence_gem,id=u1,hostfwd=tcp::5001-:5001,hostfwd=udp::5001-:5001

# aarch64-rtems6-objcopy -O binary build/aarch64-rtems6-raspberrypi4b/ttcpshell01.exe kernel8.img
# cp kernel8.img /mnt/c/Users/79230/Desktop/tftp/