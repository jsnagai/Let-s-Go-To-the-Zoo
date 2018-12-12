.kdata
	.align 0
	#Vetor para leitura do dado
	theString: .space 20
	# Respostas
	cor1: .asciiz "yellow\n"
	cor2: .asciiz "red\n"
	cor3: .asciiz "blue\n"
	cor4: .asciiz "green\n"
	cor5: .asciiz "brown\n"
	quit1: .asciiz "9\n"

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
	move $t8,$s2
loop:    
	lb $t3,($t1)  #load a byte from each string
	lb $t4,($t8)
	beqz $t3,checkt2 #str1 end
	beqz $t4,mismatch
	slt $t5,$t3,$t4  #compare two bytes
	bnez $t5,mismatch
	sgt $t5,$t3,$t4  #compare two bytes
	bnez $t5,mismatch
	addi $t1,$t1,1  #t1 points to the next byte of str1
	addi $t8,$t8,1
	j loop
	
mismatch: 
	li $s0,1
	j endfunction
checkt2:
	bnez $t4,missmatch
	li $s0,0
endfunction:
	jr $ra
##################################################################################################
                
# Função de escolha do menu inicial do jogo
Inicial:
	#Som
	li $v0,37
	li $a0,0
	li $a1,0
	li $a2,0
	syscall
	#Inserir o desenho da tela aqui
	jal Tela01
	# Lendo a entrada do teclado
	li $v0, 5
    	syscall
  	beq $v0,1,Start
	beq $v0,2,Level
	beq $v0,3,Quit

Start: 
	jal Tela03
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall
	j Colors


# Função de escolha do menu de levels do jogo
Level:
	#Inserir o desenho da tela aqui
	jal Tela02
	# Lendo a entrada do teclado
	li $v0, 5
    	syscall
  	beq $v0,1,Colors


Colors:
	li $v0,37
	li $a0,0
	li $a1,2
	li $a2,0
	syscall
	
	li $v0,37
	li $a0,1
	li $a1,0
	li $a2,0
	syscall
	jal Tela03
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	
	#Yellow
	jal Tela04
	#Desenha
	jal Resposta		# Lê a resposta 
	la $s1,theString
	la $s2,quit1		# Armazena o resultado do gabarito
	jal Compara		# Compara o resultado
	beqz $s0,Quit 	# Analisa se a entrada é igual ao gabarito, Se não for vai para nCorreto
	la $s1,theString
	la $s2,cor1		# Armazena o resultado do gabarito
	jal Compara		# Compara o resultado
	bnez $s0,nCorretoc1 	# Analisa se a entrada é igual ao gabarito, Se não for vai para nCorreto
	jal Tela05
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall

	
col2:	
	#Red
	jal Tela07
	#Desenha
	jal Resposta
	la $s1,theString
	la $s2,quit1		# Armazena o resultado do gabarito
	jal Compara		# Compara o resultado
	beqz $s0,Quit 	# Analisa se a entrada é igual ao gabarito, Se não for vai para nCorreto
	la $s1,theString
	la $s2,cor2		# Armazena o resultado do gabarito
	jal Compara
	bnez $s0,nCorretoc2
	jal Tela08
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall
	
col3:
	#Blue
	jal Tela10
	#Desenha
	jal Resposta
	la $s1,theString
	la $s2,quit1		# Armazena o resultado do gabarito
	jal Compara		# Compara o resultado
	beqz $s0,Quit 	# Analisa se a entrada é igual ao gabarito, Se não for vai para nCorreto

	la $s1,theString
	la $s2,cor3		# Armazena o resultado do gabarito
	jal Compara
	bnez $s0,nCorretoc3
	jal Tela11
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall

col4:	
	#Green
	jal Tela13
	#Desenha
	jal Resposta
	la $s1,theString
	la $s2,quit1		# Armazena o resultado do gabarito
	jal Compara		# Compara o resultado
	beqz $s0,Quit 	# Analisa se a entrada é igual ao gabarito, Se não for vai para nCorreto

	la $s1,theString
	la $s2,cor4		# Armazena o resultado do gabarito
	jal Compara
	bnez $s0,nCorretoc4
	jal Tela14
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall
col5:	
	#Brown
	jal Tela16
	#Desenha
	jal Resposta
	la $s1,theString
	la $s2,quit1		# Armazena o resultado do gabarito
	jal Compara		# Compara o resultado
	beqz $s0,Quit 	# Analisa se a entrada é igual ao gabarito, Se não for vai para nCorreto

	la $s1,theString
	la $s2,cor5		# Armazena o resultado do gabarito
	jal Compara
	bnez $s0,nCorretoc5
	jal Tela17
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall
	j Quit	


nCorretoc1: # Erro: 'Fazer para cada caso'
	jal Tela06
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall 
	j Colors

nCorretoc2: # Erro: 'Fazer para cada caso'
	jal Tela09
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall 
	j col2
nCorretoc3: # Erro: 'Fazer para cada caso'
	jal Tela12
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall 
	j col3
nCorretoc4: # Erro: 'Fazer para cada caso'
	jal Tela15
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall 
	j col4
	
nCorretoc5: # Erro: 'Fazer para cada caso'
	jal Tela18
	li $v0, 32	
	li $a0, 1000	#1000 = 1 seg
	syscall
	j col5 
	
Quit: # Função final do jogo
	jal Tela86
	li $v0, 32	
	li $a0, 1000000	#1000 = 1 seg
	syscall
