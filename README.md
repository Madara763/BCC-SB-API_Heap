# BCC-SB-API_Heap

Trabalho para a disciplina de Software Basico do curso de Ciencia da Computação - UFPR 24/01

Alunos:
Davi Garcia Lazzarin
Edson ...(ta me ignorando no whats)

Estruturação do programa;
Arquivos:
apiheap.h - headers em C
apiheap.s - implementacao em Assembly 
apiheap.o - obj

testa_apiheap.c - programa em C para testar as funções
Makefile - arquivo make com as regras de compilação e ligação, gera os .o e o executavel
testa_apiheap - arquivo executavel com rotinas de teste

OBS: 
Erro ao alocar memoria em um bloco desalocado criado na alocacao anterior num
bloco maior
aloca 500
desaloca 500
aloca 10
ao alocar alguma coisa nesses 481 que sobra da erro e vai pro fim da heap 
