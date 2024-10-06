.data
   message: .asciiz "Please enter a decimal number (<-=16): "
   res:  .space 4
.text
main:

    li $v0, 12
	syscall
	add $s1, $0, $v0
    addi $s2, $s2, 2
    addi $s3, $s3, '0'
FLAG: 
    beq $s1, $zero, L2
L1:
    div $t0, $s1, $s2
    mfhi $t1
    mflo $t2
    beqz $t1, L2



L2:
    li $
#end the process here
    li $v0, 10
    syscall