C = gcc
ifeq '$(findstring ;,$(PATH))' ';'
    detected_OS := Windows
else
    detected_OS := $(shell uname 2>/dev/null || echo Unknown)
    detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
    detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
    detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif
ifeq ($(detected_OS),Darwin)
CFLAGS =
OPENCL = -framework OpenCL
endif
ifeq ($(detected_OS),Linux)
CFLAGS = -Wall -g # debug
#CFLAGS = -Wall -O # release
OPENCL = -lOpenCL
endif

all: mandelbrot

mandelbrot: main.c bmp.o cl_helper.o
	$(C) $(CFLAGS) -o mandelbrot main.c bmp.o cl_helper.o $(OPENCL)

bmp.o: bmp.c bmp.h
	$(C) $(CFLAGS) -c bmp.c

cl_helper.o: cl_helper.c cl_helper.h
	$(C) $(CFLAGS) -c cl_helper.c


clean:
	rm -f mandelbrot output.bmp *.o
