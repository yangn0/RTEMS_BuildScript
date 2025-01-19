# use in gdb with "source <scriptname>.py"

class MallocBreakpoint(gdb.Breakpoint):
    def stop(self):
        myframe = gdb.newest_frame()
        if (myframe.older().older().older().name() == "rtems_bsd_program_call_main_with_data_restore"):
            return False
        if (myframe.older().older().older().name() == "rtems_bsd_program_call"):
            return False
        while myframe is not None:
            myname = myframe.name()
            myframe = myframe.older()
            if ((myname == "rtems_bsd_program_alloc")
              or (myname == "rtems_bsd_program_fopen")
              or (myname == "rtems_bsd_program_open")
              or (myname == "rtems_bsd_program_socket")
              or (myname == "fgetln")
              or (myname == "devfs_imfs_ioctl")
              or (myname == "lgetc")
              or (myname == "getifaddrs")
              or (myname == "feature_present")
              ):
                return False
        print("Not in one of the expected functions.")
        return True

class CloseBreakpoint(gdb.Breakpoint):
    def stop(self):
        myframe = gdb.newest_frame()
        while myframe is not None:
            myname = myframe.name()
            myframe = myframe.older()
            if (myname == "rtems_bsd_program_close"):
                return False
        print("Not in one of the expected functions.")
        return True

MallocBreakpoint("rtems_heap_allocate_aligned_with_boundary")
CloseBreakpoint("close")
