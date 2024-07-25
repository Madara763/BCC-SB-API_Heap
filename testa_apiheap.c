#include <stdio.h>
#include <stdlib.h>

#include "apiheap.h" 							

extern int *BRK;

int main(){
  printf("Valor brk: %i\n",BRK ); 
  setup_brk(); 
  printf("Valor brk: %i\n",BRK );
  

  printf("ALLOCA 100 \n");  
  void *ptr=memory_alloc(100);
  printf("Valor ptr : %i\n",ptr );
  printf("Valor brk: %i\n",BRK );
  
  memory_free(ptr);
  printf("Valor brk: %i\n",BRK );

  printf("ALLOCA 10 \n");
  ptr=memory_alloc(10);
  printf("Valor ptr : %i\n",ptr );
  printf("Valor brk: %i\n",BRK );
  
  printf("Valor do byte: %i\n", *((char *)ptr +10 ));
  printf("Valor do byte: %i\n", *((long long *)ptr +11 ));
  
  printf("ALLOCA 30 \n");
  ptr=memory_alloc(30);
  printf("Valor ptr : %i\n",ptr );
  printf("Valor brk: %i\n",BRK );


  return 0;
}
