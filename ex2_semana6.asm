#int squares[100];

#int main() {
#   int i, upTo;
#   scanf("%d", &upTo);
#   for (i = 0; i < upTo ; i++)
#      squares[i] = i * i;
#   return 0;
#}
				
				
	.data
_sqr: 	.word 0:100
_msg1:	.asciiz	"The result is "
_msg2:	.asciiz "\n"

	.text
_main:
	li	$s0, 0	# int i
	li 	$v0, 5	# chama input upTo
	syscall
	move 	$s1, $v0  # guarda input em s1
	la	$s2, _sqr # endereço do início do array
	li 	$s3, 0 	 
_loop:
	bge	$s0, $s1, _end
	mul	$t0, $s0, $s0
	sw	$t0, ($s2)
	addiu	$s2, $s2, 4
	addiu	$s0, $s0, 1
	j	_loop
_end:	
	li	$v0, 4
	la	$a0, _msg1
	syscall
	li	$v0, 1
	move	$a0, $s2
	syscall
	li	$v0, 4
	la	$a0, _msg2
	syscall
	li	$v0, 10
	syscall
