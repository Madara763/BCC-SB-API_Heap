#ifndef _APIHEAP_
#define _APIHEAP_

/*
  Arquivo contém os cabeçalhos das funcoes da API
  A implementacao será em assembly
  Deverá ser ligado posteriormente
*/


//Obtém o endereço de brk
void setup_brk(); 

//Restaura o endereço de brk
void dismiss_brk();

//1. Procura bloco livre com tamanho igual ou maior que arequisição
//2. Se encontrar, marca ocupação, utiliza os bytes necessários do bloco, retornando o endereço correspondente
//3. Se não encontrar, abre espaço para um novo bloco
void* memory_alloc(unsigned long int bytes);

//Marca um bloco ocupado como livre
int memory_free(void *pointer); 

#endif
