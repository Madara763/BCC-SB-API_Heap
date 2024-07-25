#include <stdio.h>
#include <stdlib.h>

#include "apiheap.h" 							

extern int *BRK;

int main(){
  printf("Valor brk: %i\n",BRK ); 
  setup_brk(); 
  printf("Valor brk: %i\n",BRK );
  printf("estraga o brk\n" );

  BRK=178236872;
  printf("Valor brk: %i\n",BRK );
  printf("dismiss_brk \n");
  dismiss_brk();
  printf("Valor brk: %i\n",BRK );
  

  printf("memory_alloc 100 \n");
  
  void *ptr=memory_alloc(100);
  printf("Valor ptr : %i\n",ptr );
  



  return 0;
}
