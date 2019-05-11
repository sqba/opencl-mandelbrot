#ifndef _CL_HELPER_H
#define _CL_HELPER_H

#ifdef __APPLE__
    #include <OpenCL/cl.hpp>
#else
    #include <CL/cl.h>
#endif

char* load_program_source(const char *filename);
cl_kernel load_kernel_from_file(cl_context context, const char *filename);
cl_context create_context(cl_uint* num_devices, int platform_index);
void print_debug_info(cl_context context);
void check_succeeded(char* message, cl_int err);

#endif
