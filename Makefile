CC = gcc
AS = as
CFLAGS = -g -no-pie
LFLAGS = -lm -z noexecstack

testa_apiheap: testa_apiheap.o apiheap.o
	$(CC) $(CFLAGS) -o testa_apiheap testa_apiheap.o apiheap.o $(LFLAGS)

apiheap.o: apiheap.s
	$(AS) $(CFLAGS) -c apiheap.s -o apiheap.o

testa_apiheap.o: testa_apiheap.c apiheap.h
	$(CC) $(CFLAGS) -c testa_apiheap.c -o testa_apiheap.o

