# ALUN0: Jedson Jhones Barbosa Alves
# MATRICULA: 20170137740
# QUESTÃO 1

.data
        #Variaveis que contarão a contidade de acertos e erros
	Acertos: .asciiz "\nAcertos: " 
	Erros: .asciiz "Erros: "
	#Referencia aos blocos e declaração da cache
	Blocos:  .word 2, 3, 11, 16, 21, 13, 64, 48, 19, 11, 3, 22, 4, 27, 6, 11 
	Cache: .word -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 
.text
	li  		$t0, 0                          #Inicia o loop
	li  		$s0, 16 
	#registradores utilizados para contar os acertos e erros
	li  		$t1, 0  	                #registrador da contagem de acertos
	li  		$t2, 0			 	#registrador da contagem de erros
	li  		$t3, 4			 	#Multiplica e encontra o valor da cache
        #laço	
for:
	beq  		$t0, $s0, finalFor
	mul  		$t4, $t0, $t3 		 	#ira armazenar no registrador t4 a multiplicação dos valores nos registradores t0 e t3
	lw  		$t6, Blocos($t4) 		#carregara a word da cache onde t4 foi armazenado
	div  		$t6, $s0 		        #Armazara no registrador t6 o resultado da divisão
	mfhi  		$t8 		         	#ira pegar o valor do resto da divisão do registrador hi
	mul  		$t8, $t8, $t3 		 	#realizara a multiplicação do valor do registrador para si transformar em bytes
	lw  		$t5, Cache($t8) 		#o registrador t5 estara carregando o valor da cache
	beq  		$t6, $t5, contAcertos 	 	#compara o valor de referencia da cache e o valor carregado do bloco
	#implementacao da contagem de erro armazenado no registrador t2
	sw  		$t6, Cache($t8)		 	#carrega
	addi  		$t2, $t2, 1 		 	#incrementaçãi do registrado de contagem de erros
	addi  		$t0, $t0, 1 		 	#incrementação do indice
	j   for			         	 	#salta para o laço
	
contAcertos:	 		         		#função que incrementa a contagem de acertos
	addi  		$t0, $t0, 1		 	#incrementa o índice
	addi  		$t1, $t1, 1		 	#incrementa o acerto
	j for			         		#salta para o laço
			
finalFor:
	#imprime as falhas
	li  		$v0, 4
	la  		$a0, Erros 			#chama a mensagem de Erro
	syscall
	li  		$v0, 1
	move  		$a0, $t2 			#move a quantidade de falhas e imprime
	syscall
	#imprime os acertos
	li  		$v0, 4
	la  		$a0, Acertos 		 	#chamada da mensagem de acertos
	syscall
	li  		$v0, 1
	move 		$a0, $t1 			#move e imprime a quantidade de acertos
	syscall
		
	li  		$v0, 10  		 	#código de chamada do sistema para sair do programa
	syscall
