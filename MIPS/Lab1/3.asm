.data
    request1: .asciiz "Please input the integers"
    inputa: .asciiz "a = "
    newline: .asciiz "\n"
    inputb: .asciiz "b = "
    inputc: .asciiz "c = "
    inputd: .asciiz "d = " 
    res1: .asciiz "F = "
    res2: .asciiz ", remainder "
    printing: .space 100
    error_mess: .asciiz "The denominator is zero, please enter the numbers again!\n"
.text

Entering:
    li $v0, 4
    la $a0, request1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, inputa
    syscall

    li $v0, 5
    syscall
    add $s1, $v0, $zero

    li $v0, 4
    la $a0, inputb
    syscall

    li $v0, 5
    syscall
    add $s2, $v0, $zero

    li $v0, 4
    la $a0, inputc
    syscall

    li $v0, 5
    syscall
    add $s3, $v0, $zero

    li $v0, 4
    la $a0, inputd
    syscall

    li $v0, 5
    syscall
    add $s4, $v0, $zero


    #t1 for (a-10)
    li $t0, 10
    sub $t1, $s1, 10
    
    #t2 for (b+d)
    add $t2, $s2, $s4

    #t3 for (c-2*a)
    li $t0, 2
    mul $t3, $t0, $s1
    sub $t3, $s3, $t3

    #t5 for the numerator
    mul $t5, $t1, $t2
    mul $t5, $t5, $t3


    #t4 for a+b+c
    add $t4, $s1, $s2
    add $t4, $t4, $s3
    #IF t4 ==0 then we cannot perform the division 
    #(MIPS ASM cannot detect /0 so we need to process that manually)

    beqz $t4, ERROR

    div $t6, $t5, $t4
    mflo $s5
    mfhi $s6

    ##printing from here

    li $v0, 4
    la $a0, res1
    syscall

    li $v0, 1
    move $a0, $s5
    syscall

    li $v0, 4
    la $a0, res2
    syscall
    li $v0, 1
    move $a0, $s6
    syscall

    li $v0, 10
    syscall



ERROR:
    li $v0, 4
    la $a0, error_mess
    syscall
    j Entering


    



