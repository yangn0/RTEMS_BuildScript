export bsp=aarch64/zynqmp_qemu

cd ~/RTEMS_devel/src/rtems-lwip

git submodule init
git submodule update

./waf configure --prefix=$HOME/RTEMS_devel/rtems/6 --rtems-bsps $bsp
./waf uninstall
# ./waf distclean
./waf
./waf install

export app=build/aarch64-rtems6-zynqmp_qemu/networking01.exe
# sudo ip tuntap add qtap mode tap user $(whoami)
# sudo ip link set dev qtap up
# sudo ip addr add 169.254.1.1/16 dev qtap
qemu-system-aarch64 -no-reboot -nographic  \
    -serial mon:stdio -machine xlnx-zcu102 -m 4096 \
    -net nic,model=cadence_gem \
    -net tap,ifname=qtap,script=no,downscript=no \
    -kernel $app
    # -nic user,model=cadence_gem,id=u1,hostfwd=tcp::2000-:23 \

# ../source-builder/sb-set-builder --prefix=$HOME/RTEMS_devel/rtems/6 \
#       --log=curl.txt --host=aarch64-rtems6 --with-rtems-bsp=aarch64/zynqmp_qemu --lib=lwip ftp/curl