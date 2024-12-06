# BCC-SB-API_Heap

Trabalho para a disciplina de Software Basico do curso de Ciencia da Computação - UFPR 24/01

Estruturação do programa;
Arquivos:
apiheap.h - headers em C
apiheap.s - implementacao em Assembly 
apiheap.o - obj

testa_apiheap.c - programa em C para testar as funções
Makefile - arquivo make com as regras de compilação e ligação, gera os .o e o executavel
testa_apiheap - arquivo executavel com rotinas de teste

Decisões de Projeto:

apiheap implementada seguindo a politica worst-fit

Uso de alguns registradores:
%r8 armazeza o parametro (valor)
%r9 armazena o BRK_ORIGINAL (endereco)
%r10 aramzena o maior espaco livre ate o momento (valor)
%r11 endereco do maior valor (endereco)
%r13 e  %r14 sao usados como auxiliar
%r15 eh usado como indice (endereco)
%cL usado usado para desalocar

Variaveis globais:
BRK: Armazena o valor atual de brk
BRK_ORIGINAL: Armazena o primeiro valor de brk

Registros dos blocos de memória de 9 Bytes:
utilizam 1 byte para uso sendo 0 livre e 1 em uso, sendo esse o primeiro dos 9.
e os outros 8 Bytes armazenanam o tamanho do bloco.

Não possui qualquer tipo de alinhamento nos endereços, um bloco se inicia no Byte seguinte ao término do anterior.
