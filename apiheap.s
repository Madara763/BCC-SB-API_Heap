.section .data

# define as variaveis globais
  .global BRK
  BRK: .quad 0
  .global BRK_ORIGINAL
  BRK_ORIGINAL: .quad 0 


.section .text
# definicao dos rotulos 
.global setup_brk, dismiss_brk, memory_alloc, memory_free

# implementacao dos procedimentos

# obtem o endereco de brk
setup_brk:
  pushq %rbp
  movq %rsp, %rbp
  
  # pega o brk via syscall
  movq $12, %rax
  movq $0, %rdi
  syscall 
 
  # seta o brk e salva o primeiro bkp 'heap zerada'
  movq %rax, BRK
  movq %rax, BRK_ORIGINAL

  popq %rbp
  ret

# restuara o endereco de brk
dismiss_brk:
  pushq %rbp
  movq %rsp, %rbp
  
  # seta o BRK com o valor original 'limpa a heap' 
  movq $12, %rax
  movq $BRK_ORIGINAL, %rdi
  syscall  
  movq %rax, BRK  

  popq %rbp
  ret

# aloca seguindo a politica worst-fit
# recebe a quantidade de bytes como unico parametro
# devolve um endereco para o inicio do bloco alocado
# %r8 armazeza o parametro (valor)
# %r9 armazena o BRK_ORIGINAL (endereco)
# %r10 aramzena o maior espaco livre ate o momento (valor)
# %r11 endereco do maior valor (endereco)
# %r13 e  %r14 sao usados como auxiliar
# %r15 eh usado como indice (endereco)
memory_alloc:
  pushq %rbp
  movq %rsp, %rbp
  
  # recebe o numero de bytes a ser alocado em %r8
  movq %rdi, %r8
  # %r15 aramazena o endereco atual
  movq BRK_ORIGINAL, %r15
  # inicializa %r10, que armazenara o maior espaco livre 
  #sera inicializado com o maior valor possivel em um .quad
  movq $999999999, %r10
  
  # PERCORRE A HEAP	
  # compara o endereco atual com  brk
  _compara_brk:
    cmpq BRK, %r15
    # se o endereco ainda nao tiver em brk 
    jl _busca_proximo_bloco
    # se ja tiver chego no fim da heap pula pras verificacoes
    jmp _fim_busca
  
  _busca_proximo_bloco: 
    # verifica se esta em uso
    cmpb $1, (%r15)
    # se tiver em uso avanca para o proximo
    je _avanca_indice
	# se tiver livre, verifica o tamanho necessario, e salva ele se for o maior
    # ajusta %r14 para apontar para o tamanho
    movq %r15, %r14
    addq $1, %r14
    # verifica o tamanho do bloco
    cmpq %r8, (%r14)
    jl _avanca_indice
    # verifica se o tamanho eh o maior ate agr
    #COMPARACAO  WORST / BEST FIT
    cmpq %r10, (%r14)
    jg _avanca_indice
    
    # se chegar aqui o bloco esta livre e com espaco suficiente
    # e eh o maior ate o momento
    # salva o valor em r10 e o endereco em r11
    movq (%r14), %r10
    movq %r15, %r11
    jmp _avanca_indice

  _avanca_indice:
    movq %r15, %r14
    # ajusta %r14 para apontar para os 8 bytes do tamanho
    addq $1, %r14
    # armazena em %r13 o tamanho
    movq (%r14), %r13
    addq $9, %r13
    # desloca o indice 
    addq %r13, %r15
    
    jmp _compara_brk

  # aqui decidimos onde sera o espaco alocado
  _fim_busca:    
    cmpq $999999999, %r10  
    je _abre_novo_bloco
    
    # verificamos se da pra dividir o bloco atual
    movq %r10, %r13
    subq %r8, %r13
    subq $10, %r13
    cmpq %r13, %r10
    jl _reaproveita_bloco
    
    # aqui dividimos o maior bloco em 2
    movq %r11, %r14

    # desloca r14 pro inicio do bloco
    # desloca r14 pro fim do bloco
    addq $9, %r14
    addq %r8, %r14
    
    # r13 fica com o tamanho do bloco que sobra
    movq %r10, %r13
    subq %r8, %r13
    subq $9, %r13
    # com r14 apontando pro fim do bloco, criamos o novo bloco 
    movb $0, (%r14)
    addq $1, %r14
    movq %r13, (%r14)

    # modifica o registro do bloco
    movq %r11, %r14
    movb $1, (%r14)
    addq $1, %r14
    movq %r8, (%r14)
    
    jmp _finaliza_alocacao    

  _reaproveita_bloco: 
    movq %r11, %r14
    movb $1, (%r14)
    addq $1, %r14
    
    jmp _finaliza_alocacao

  _abre_novo_bloco:
    movq BRK, %r14
    movq BRK, %r13
    addq $9, %r13
    addq %r8, %r13
	
    # atualiza o brk
    movq $12, %rax
    movq %r13, %rdi
    syscall
    movq $12, %rax
    movq $0, %rdi
    syscall
    movq %rax, BRK
    
    # seta registro do novo bloco
    movb $1, (%r14)
    addq $1, %r14
    movq %r8, (%r14)  
 
    jmp _finaliza_alocacao
  
  _finaliza_alocacao:
  
  #chegando aqui r14 aponta pro registro do novo bloco pro tamanho
  #rax aponta pro inicio do novo espaco de memoria
  movq %r14, %rax
  addq $8, %rax
  
  popq %rbp
  ret


#libera a memoria seguindo politica wrost-fit
#recebe um endereco para o inicio do bloco
#marca o bloco como desocupado
memory_free:
  pushq %rbp
  movq %rsp, %rbp
    
  # recebe o endereco a ser desalocado 
  movq %rdi, %r13
  
  # testa se esta antes de brk 
  cmpq BRK, %r13
  jge _erro
  
  subq $9, %r13
  movb (%r13), %cL
  cmpb $1, %cL
  jne _erro
  
  #inicia desalocacao
  movq %rdi, %r13

  subq $9, %r13
  movb $0, (%r13) 
  # encerra com sucesso
  movq $1, %rax 
  popq %rbp
  ret
  
  _erro:
    movq $0, %rax
    popq %rbp
    ret


