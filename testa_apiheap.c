#include <stdio.h>
#include <stdlib.h>

#include "apiheap.h" 							

extern int *BRK;

int main(){
  printf("Valor brk: %i\n",BRK ); 
  setup_brk(); 
  printf("Valor brk: %i\n",BRK );
  return 0;
}
