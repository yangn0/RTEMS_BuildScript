cd ~/RTEMS_devel/src/rtems-lwip

git submodule init
git submodule update

./waf configure --prefix=$HOME/RTEMS_devel/rtems/6 --rtems-bsps aarch64/zynqmp_qemu
./waf
./waf install

export PATH=$HOME/qemu/build:$PATH
# qemu-system-aarch64 -no-reboot -nographic -serial mon:stdio -machine xlnx-zcu102 -m 4096 -net nic,model=cadence_gem -net tap,ifname=qtap,script=no,downscript=no -kernel networking01.exe 
# -nic user, model=cadence_gem,id=u1,hostfwd=tcp::2000-:23