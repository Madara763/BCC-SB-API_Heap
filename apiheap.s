.section .data

  #define as variaveis globais
  .global BRK
  BRK: .quad 0
  .global BRK_ORIGINAL
  BRK_ORIGINAL: .quad 0 


.section .text
#definicao dos rotulos 
.global setup_brk, dismiss_brk, memory_alloc, memory_free

#Procedimentos auxiliares



#implementacao dos procedimentos

#obtem o endereco de brk
setup_brk:
  pushq %rbp
  movq %rsp, %rbp
  
  #pega o brk via syscall
  movq $12, %rax
  movq $0, %rdi
  syscall 
 
  #seta o brk e salva o primeiro bkp 'heap zerada'
  movq %rax, BRK
  movq %rax, BRK_ORIGINAL

  popq %rbp
  ret

#restuara o endereco de brk
dismiss_brk:
  pushq %rbp
  movq %rsp, %rbp
  
  #seta o BRK com o valor original 'limpa a heap' 
  movq $12, %rax
  movq $BRK_ORIGINAL, %rdi
  syscall  
  movq %rax, BRK  

  popq %rbp
  ret

#aloca seguindo a politica worst-fit
#recebe a quantidade de bytes como unico parametro
#devolve um endereco para o inicio do bloco alocado
memory_alloc:
  pushq %rbp
  movq %rsp, %rbp
  popq %rbp
  ret

#libera a memoria seguindo politica wrost-fit
#recebe um endereco para o inicio do bloco
#marca o bloco como desocupado
memory_free:
  pushq %rbp
  movq %rsp, %rbp
  popq %rbp
  ret

