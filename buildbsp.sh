#!/bin/bash
export rtems_src=rtems
# export rtems_src=rtems

cd /home/yangn0/devel/RTEMS_devel/src/$rtems_src
# ./waf distclean
./waf configure --prefix=$HOME/devel/RTEMS_devel/rtems/6
./waf
./waf install