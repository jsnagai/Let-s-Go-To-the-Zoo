.data
	#Vetor para leitura do dado
	theString: .space 20
	
	# Respostas
	.align 3
	cor1: .asciiz "yellow\n"
	.align 3
	cor2: .asciiz "red\n"
	.align 3
	cor3: .asciiz "blue\n"
	.align 3
	cor4: .asciiz "green\n"
	.align 3
	cor5: .asciiz "brown\n"

.text

j Inicial

###################################################################### Metodos para as respostas 
#Le Resposta em um registrador específico
Resposta:
	# Lendo a entrada do teclado
	li $v0, 8 
    	la $a0, theString # Array definido no inicio
	addi $a1,$zero,20
    	syscall
        jr $ra

Compara:
	add $t0,$zero,$zero
	move $t1,$s1
	move $t2,$s2
loop:  
	lb $t3($t1)  #load a byte from each string
	lb $t4($t2)
	beqz $t3,checkt2 #str1 end
	beqz $t4,missmatch
	slt $t5,$t3,$t4  #compare two bytes
	bnez $t5,missmatch
	addi $t1,$t1,1  #t1 points to the next byte of str1
	addi $t2,$t2,1
	j loop
	
missmatch: 
	li $v0,1
	j endfunction
checkt2:
	bnez $t4,missmatch
	li $v0,0
endfunction:
	jr $ra
##################################################################################################

Inicial:
Colors:
	#Yellow
	#jal Tela04
	#Desenha
	jal Resposta		# Lê a resposta 
	la $s1,theString
	la $s2,cor1		# Armazena o resultado do gabarito
	li $v0, 4
	la $a0,cor1
	syscall
	jal Compara		# Compara o resultado
	bnez $v0,nCorretoc1 	# Analisa se a entrada é igual ao gabarito, Se não for vai para nCorreto
	#jal Tela05
	li $v0, 32	
	li $a0, 5000	#1000 = 1 seg
	syscall


nCorretoc1: # Erro: 'Fazer para cada caso'
	#jal Tela06
	li $v0, 32	
	li $a0, 5000	#1000 = 1 seg
	syscall 
	j Colors

nCorretoc2: # Erro: 'Fazer para cada caso'
	#jal Tela09
	li $v0, 32	
	li $a0, 5000	#1000 = 1 seg
	syscall 
	#j col3
nCorretoc3: # Erro: 'Fazer para cada caso'
	#jal Tela12
	li $v0, 32	
	li $a0, 5000	#1000 = 1 seg
	syscall 
	#j col4
nCorretoc4: # Erro: 'Fazer para cada caso'
	#jal Tela15
	li $v0, 32	
	li $a0, 5000	#1000 = 1 seg
	syscall 
	#j col5
	
nCorretoc5: # Erro: 'Fazer para cada caso'
	#jal Tela18
	li $v0, 32	
	li $a0, 5000	#1000 = 1 seg
	syscall 
	j Quit
	
Quit: # Função final do jogo
	#jal Tela86
	li $v0, 32	
	li $a0, 5000	#1000 = 1 seg
	syscall





