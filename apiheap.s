.section .text
#definicao dos rotulos 
.global setup_br, dismiss_brk, memory_alloc, memory_free

#implementacao dos procedimentos

#obtem o endereco de brk
setup_brk:
  pushq %rbp
  movq %rsp, %rbp
  popq %rbp
  ret

#restuara o endereco de brk
dismiss_brk:
  pushq %rbp
  movq %rsp, %rbp
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

