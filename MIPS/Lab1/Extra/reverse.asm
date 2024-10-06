.data
    mess: .asciiz "Please enter the array"
    arr:    .space 80
    size:   .word 20
.text
main:
    li $v0, 4
    la $a0, mess
    syscall
    li $t1,20 
    la $t0, arr
    li $t3, 1
L1: beqz $t1, CONT
    li $v0, 5
    syscall
    or $t2, $v0, $zero
    sw $t2, $t0
    addi $t0, $t0, 4
    sub $t1, $t1, $t3
    j L1

CONT:
    la $t0, arr
    addi $t1, $t0, 76
    li $t2, 9
L2:
    beqz $t2, EXIT 

EXIT:


