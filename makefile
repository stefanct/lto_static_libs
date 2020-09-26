GCC_VERSION := $(shell gcc -dumpversion)
$(info Using GCC $(GCC_VERSION))
VERSION := 10.0.0

CC := gcc
AR := gcc-ar
NM := gcc-nm

ifneq ($(nolto),y)
  LTO_FLAGS := -flto -ffat-lto-objects 
endif

ifeq ($(nostdlib),y)
  NO_STDLIB := -nostdlib
endif

ifeq ($(libfunc),y)
  LIB_FUNC := -D LIB_FUNC
endif

CFLAGS += -Wall -Wextra -Wno-unused-parameter $(LTO_FLAGS) $(LIB_FUNC)

SRC_MAIN := main.c
OBJS_MAIN := $(SRC_MAIN:%.c=%.o)

all: exe

libtest.a: libtest.o
ifneq ($(nolto),y)
ifeq ($(VERSION),$(firstword $(sort $(GCC_VERSION) $(VERSION))))
	lto-dump -list libtest.o
endif
endif
	$(NM) libtest.o
	rm -f libtest.a
	$(AR) -cvq libtest.a $^

exe: libtest.a $(OBJS_MAIN)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MAIN) -L. -ltest $(NO_STDLIB)

clean:
	rm -f libtest.a *.o exe

.PHONY: exe clean
