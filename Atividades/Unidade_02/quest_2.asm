# ALUN0: Jedson Jhones Barbosa Alves
# MATRICULA: 20170137740
# QUEST�O 2

.data
       pontoA: .float 2.0
       pontoB: .float 3.0
       TOL: .float 0.1
       saidatab:	.asciiz "\na\t\t\tb\t\t\tmidpt\t\t\tf(a)\t\t\tf(b)\t\t\tf(midpt)"
       espaco:	.asciiz"\t\t\t"	
       novalinha:	.asciiz"\n"	
		.globl main		
.text
	
main:	
        l.s  		$f4, pontoA 		#armazena ponto A em $f4
	
	l.s  		$f5, pontoB 		#armazena ponto B em $f5
	
	l.s  		$f6, TOL 		#armazena a tolerancia em $f6

	
	#imprime tabela
	li	 	$v0, 4				
	la	 	$a0, saidatab		
	syscall					
	
Calcularvalores:		
	
	jal 		pontomedio		#pula para o m�todo pontomedio
	mov.s		$f9,$f0			#salva o valor de retorno de $f0 no registrador tempor�rio $f9
	mov.s		$f12, $f4		#move o valor do ponto a para o $f12 passando o valor
	jal		encontravalor		#salta para o m�todo encontravalor
	mov.s 		$f17, $f0		#salva o valor de f(a) em $f10
	mov.s		$f12, $f5		#move o valor do ponto b para $f12 passando o valor
	jal		encontravalor		#salta para o m�todo encontravalor
	mov.s 		$f11, $f0		#salva o valor de f(b) em $f11
	mov.s		$f12, $f9		#move o valor do ponto m�dio para $f12 passando o valor
	jal		encontravalor		#salta para o m�todo encontravalor
	mov.s 		$f16, $f0		#salva o valor de f(ponto m�dio) em $f16

mostrarimfor:
	li		$v0, 4			#para imprimir string
	la		$a0, novalinha		#vai carrega a novalinha em $a0
	syscall					
	mov.s		$f13, $f4		#salva o ponto a em $f13 para pass�-lo
	jal		imprimivalores		#salta para o m�todo imprimivalores
	mov.s		$f13, $f5		#salva o ponto b em $f13 para pass�-lo
	jal		imprimivalores		#salta para o m�todo imprimivalores
	mov.s		$f13, $f9		#salva o ponto m�dio em $f13 para pass�-lo
	jal		imprimivalores		#salta para o m�todo imprimivalores
	
mostrarvalores:
	mov.s		$f13, $f17		#salva f(a) em $f13 para pass�-lo
	jal		imprimivalores		#salta para o m�todo imprimivalores
	mov.s		$f13, $f11		#salva f(b) em $f13 para pass�-lo
	jal		imprimivalores		#salta para o m�todo imprimivalores
	mov.s		$f13, $f16		#salva f(b) em $f13 para pass�-lo
	jal		imprimivalores		#salta para o m�todo imprimivalores		

        #verifica se fa = 0  ou fb = 0
	li	 	$t0, 0			#carrega o n�mero 0 em $t0
	mtc1 		$t0, $f10		#armazena o n�mero como um float
	cvt.s.w 	$f19, $f10		#converte o n�mero para float e o armazena no registrador $f19	
	
	
	c.eq.s		$f17, $f19		#compara se f(a)= 0
	bc1t		exit			#para o programa se f(a) = 0
	c.eq.s		$f11, $f19		#compara se f(b)= 0
	bc1t		exit			#para o programa se f(b) = 0

calctolerancia:			                # calcualte toler�ncia
	sub.s		$f20, $f5,$f4		# calcula a toler�ncia ba salva em f20
	
	c.lt.s		$f20, $f6		#sets flag true if interval is less than tolerace
	bc1t		finalExit		#si o intervalo for menor, vai para FinalExit
	
	mul.s		$f18, $f16, $f11	
	c.lt.s		$f18, $f19		#0
	bc1t		else			#si true ramifica para else
	
	mov.s		$f5, $f9		#move o f(ponto m�dio) para o valor
	j		Calcularvalores		#salta para o m�todo de calcularvalores
	
else:   #em que raiz = [ponto m�dio,b]
	mov.s		$f4, $f9		#a = novo ponto m�dio
	j		Calcularvalores		#salta para o m�todo de calcularvalores

finalExit:

	li		$v0, 4			
	la		$a0, novalinha		
	syscall						
	li		$v0, 2			
        mov.s		$f12,$f9		
        syscall					
	li		$v0, 10			#c�digo de chamada do sistema para sair do programa
	syscall					 
	
pontomedio:       
						#converte 2 em float
	li	 	$t0, 2			#carrega o n�mero 2 em $t0
	mtc1 		$t0, $f10		#armazena o n�mero como um float
	cvt.s.w 	$f8, $f10		#converte o n�mero para float e o armazena no registrador $f8

        add.s		$f7,$f5,$f4		#soma pontos b+a
        div.s 		$f7,$f7,$f8		#divide a soma por 2 . 0  e -- armazena o ponto m�dio em $f7
        mov.s		$f0,$f7			# retorna a fun��o $f0 = ( $f7 = ponto m�dio)
        jr		$ra			#salta para voltar ao main
        
encontravalor:
	mul.s		$f7, $f12, $f12		#multiplica o valor x valor
	mul.s		$f7, $f7, $f12		#multiplica o valor original pelo valor salvo para  x ^ 3
	
	li	 	$t0, 10			#carrega o n�mero 1 em $t0
	mtc1 		$t0, $f10		#armazena o n�mero como um float
	cvt.s.w 	$f8, $f10		#converte o n�mero para float e o armazena no registrador $f8
	
	sub.s 		$f7, $f7, $f8		#subtrai o novo valor por 1 
	
	mov.s		$f0, $f7		# return valor da fun��o = x^ 3 - 10
	jr		$ra			#volta para o main
	        
imprimivalores:
        #c�digo para imprimir o n�mero float
	li		$v0, 2			
        mov.s		$f12,$f13		
        syscall					
	#syscall c�digo para imprimir string
	li		$v0, 4			
	la		$a0, espaco		
	syscall					
	
	jr		$ra			#retorna ao principal

exit:
	li	 	$v0, 10			#c�digo de chamada do sistema para sair do programa
	syscall					
