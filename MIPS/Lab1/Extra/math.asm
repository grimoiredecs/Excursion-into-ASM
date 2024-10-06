.data
    request1: .asciiz "Please enter a: "
    request2: .asciiz "Please enter b: "

.text
main:
    li $v0, 4
    la $a0, request1
    syscall

    li $v0, 5
    syscall
    move $t1, $a0

    li $v0, 4
    la $a0, request2
    syscall
    
    li $v0 5
    syscall
    move $t2, $a0

    li $v0,5
    syscall
    ori $t0, $v0, 0

    li $t3, 1
    beq $t0, $t3, SUM

    li $t3, 2
    beq $t0, $t3, SUB

    li $t3, 3
    

SUM: 

    li $v0, 10
    syscall
    
