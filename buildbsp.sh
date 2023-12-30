#!/bin/bash
export rtems_src=rtems-utk
# export rtems_src=rtems

cd /home/yangn0/devel/rtems-aarch64/src/$rtems_src
# ./waf distclean
./waf configure --prefix=$HOME/devel/rtems-aarch64/rtems/6
./waf
./waf install