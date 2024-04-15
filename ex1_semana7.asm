
#int fib (int n) { 
#   if (n < 2)
#      return n;
#   else
#      return fib(n - 1) + fib(n - 2);
#}

#int main() {
#   int i;
#   scanf("%d", &i);
#   printf("fib(%d) = %d\n", i, fib(i));
#   return 0;
#}


  	.data
_msg1:	.asciiz	"fib("
_msg2: 	.asciiz ") = "
_msg3:	.asciiz "\n"

	.text
_main:
	li 	$v0, 5		# chama input i
	syscall
	move    $s0, $v0	# guarda i em s0
	move 	$a0, $s0  	# guarda input em a0 (argumento para função)
	jal 	_fib
	move	$s1, $v0	# guarda o resultado de fib
	
	li	$v0, 4
	la	$a0, _msg1
	syscall
	li	$v0, 1   	# printar inteiro i
	move	$a0, $s0	
	syscall
	li	$v0, 4
	la	$a0, _msg2
	syscall
	li	$v0, 1   	# printar inteiro resultado 
	move	$a0, $s1	
	syscall
	li	$v0, 4
	la	$a0, _msg3
	syscall
	li	$v0, 10
	syscall
	
	
_fib:
	addiu 	$sp, $sp, -20	# ajustar sp
	sw	$s1, 0($sp)
	sw	$s2, 4($sp)
	sw	$s3, 8($sp)
	sw	$s4, 12($sp)
	sw	$ra, 16($sp)
	blt	$a0, 2, _casobase # if n<2, caso base
	addiu	$s1, $a0, -1	# s1 = n-1
	addiu 	$s2, $a0, -2	# s2 = n-2
	move 	$a0, $s1	# a0 guarda n-1 como argumento
	jal 	_fib
	move	$s3, $v0	# guarda fib(n-1) em s3
	move 	$a0, $s2	# a0 guarda n-2 como argumento
	jal 	_fib
	move	$s4, $v0	# guarda fib(n-2) em s4
	add	$v0, $s3, $s4	# retorna fib(n-1) + fib(n-2)
	
	lw	$s1, 0($sp)
	lw	$s2, 4($sp)
	lw	$s3, 8($sp)
	lw	$s4, 12($sp)
	lw	$ra, 16($sp)
	addiu 	$sp, $sp, 20	# reajustar sp
	jr	$ra
_casobase:
	move 	$v0, $a0	# return n
	lw	$s1, 0($sp)
	lw	$s2, 4($sp)
	lw	$s3, 8($sp)
	lw	$s4, 12($sp)
	lw	$ra, 16($sp)
	addiu 	$sp, $sp, 20	# reajustar sp
	jr	$ra	
