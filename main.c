#include "libtest.h"

int main(void) {
  printf("hurga\n");
  int ret = 0;
#ifdef LIB_FUNC
  ret = lib_func();
#endif
  return ret;
}
