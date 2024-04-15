      .data
_str:  .asciiz  "abracadabra"
_msg1: .asciiz  "The result is "
_msg2: .asciiz  "\n"
       
       .text
_main:
       la      $a0, _str	
       jal     _proc		
       move    $s0, $v0
       li      $v0, 4
       la      $a0, _msg1
       syscall
       li      $v0, 1
       move    $a0, $s0
       syscall
       li      $v0, 4
       la      $a0, _msg2
       syscall
       li      $v0, 10
       syscall
_proc:
       li      $v0, 0
_loop:
       lb      $t0, 0($a0)
       beqz    $t0, _end
       addiu   $v0, $v0, 1
       addiu   $a0, $a0, 1
       j       _loop
_end:
       jr      $ra