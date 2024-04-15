
#int squares[100];

#void storeValues(int n) {
#   int i;
#   for (i = 0; i < n; i++)
#      squares[i] = i * i;
#   return;
#}

#int computeSum(int n) {
#   int i, sum;
#   sum = 0;
#   for (i = 0; i < n; i++)
#      sum += squares[i];
#   return sum;  
#}

#int main() {
#   int upTo;
#   scanf("%d", &upTo);
#   storeValues(upTo);
#   printf("The result is %d\n", computeSum(upTo));
#  return 0;
#}

	
	.data
_sqr: 	.word 0:100
_msg1:	.asciiz	"The result is "
_msg2:	.asciiz "\n"

	.text
_main:
	li 	$v0, 5		# chama input upTo
	syscall
	move    $s0, $v0
	move 	$a0, $s0  	# guarda input em a1 (argumento para função)
	jal 	_storeValues
	move 	$a0, $s0  	# guarda input em a0 (argumento para função)
	jal 	_computeSum
	move 	$s4, $v0  	# guarda o resultado do compute?
	li	$v0, 4
	la	$a0, _msg1
	syscall
	li	$v0, 1   	# printar inteiro
	move	$a0, $s4
	syscall
	li	$v0, 4
	la	$a0, _msg2
	syscall
	li	$v0, 10
	syscall


_storeValues: 
	addiu	$sp, $sp, -8
	sw      $s0, 0($sp) 	# guardo s0 
	sw 	$s2, 4($sp)	# guardo s2
	la	$s2, _sqr 	# endereço do início do array
	li	$s0, 0		# int i
_loop:
	bge	$s0, $a0, _back
	mul	$t0, $s0, $s0	# i*i
	sw	$t0, ($s2)	# add i*i na lista
	addiu	$s2, $s2, 4	# passo pro próximo elemento da lista
	addiu	$s0, $s0, 1	# i++
	j	_loop
_back:
	lw      $s0, 0($sp)	# recupero s0
	lw 	$s2, 4($sp)	# recupero s2
	addiu	$sp, $sp, 8	# ajusto sp de volta
	jr	$ra


_computeSum:
	addiu	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s2, 4($sp)
	sw 	$s3, 8($sp)
	li 	$s0, 0		# int i
	li 	$s3, 0 		# int sum
	la	$s2, _sqr 	# endereço do início do array
_loop2:
	bge	$s0, $a0, _back2
	lw	$t0, ($s2)	# passo o numero do array para t0
	add	$s3, $s3, $t0	# add o numero ao sum
	addiu	$s2, $s2, 4	# passo para o proximo elemento
	addiu	$s0, $s0, 1	# i++
	j	_loop2
_back2:
	move 	$v0, $s3 	# guardo o resultado no v0 (return)
	lw	$s0, 0($sp)
	lw	$s2, 4($sp)
	lw 	$s3, 8($sp)
	addiu	$sp, $sp, 12
	jr $ra
	
