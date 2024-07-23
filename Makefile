#gerar "warnings" detalhados e infos de depuração
CFLAGS = -o -g 
LDLIBS = 
objs= apiheap.o 

# regra default (primeira regra)
all:	testa_apiheap	
 
# regras de ligacao
testa_apiheap:	$(objs)
 
# regras de 'compilação'
testa_apiheap.o:	testa_apiheap.c
apiheap.o:	apiheap.s
	as -o apiheap.o apiheap.s

#Sem clean e purge dessa vez, amamos os .o
