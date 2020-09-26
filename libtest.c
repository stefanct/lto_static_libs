#include <stdint.h>
#include "libtest.h"

int printf(const char *c, ...) {
  return (uintptr_t)c;
}

int puts(const char *s) {
  return 2;
}

int lib_func(void) {
  return 42;
}
