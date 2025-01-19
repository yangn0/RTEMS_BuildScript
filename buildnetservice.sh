export rtems_version=6
export PATH=$HOME/RTEMS_devel/rtems/$rtems_version/bin:$PATH
# export bsp=aarch64/raspberrypi4b
export bsp=aarch64/zynqmp_qemu

cd ~/RTEMS_devel/src/rtems-net-services

git submodule init
git submodule update

# ./waf uninstall
./waf distclean
./waf configure --prefix=$HOME/RTEMS_devel/rtems/$rtems_version --rtems-bsps $bsp --optimization="-O0"
./waf
./waf install

export app=build/aarch64-rtems$rtems_version-zynqmp_qemu/ttcpshell01.exe
#ttcpshell01 telnetd01
# sudo ip tuntap add qtap mode tap user $(whoami)
# sudo ip link set dev qtap up
# sudo ip addr add 169.254.1.1/16 dev qtap
qemu-system-aarch64 -no-reboot -nographic  \
    -serial mon:stdio -machine xlnx-zcu102 -m 4096 \
    -kernel $app \
    -net nic,model=cadence_gem \
    -net tap,ifname=qtap,script=no,downscript=no 
    # -nic user,model=cadence_gem,id=u1,hostfwd=tcp::5001-:5001,hostfwd=udp::5001-:5001



# aarch64-rtems6-objcopy -O binary build/aarch64-rtems6-raspberrypi4b/ttcpshell01.exe kernel8.img
# cp kernel8.img /mnt/c/Users/79230/Desktop/tftp/