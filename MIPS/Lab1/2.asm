.data
    prompt1: .asciiz "Insert a: "
    prompt2: .asciiz "Insert b: "
    prompt3: .asciiz "a + b = "
    prompt4: .asciiz "a - b = "
    newline: .asciiz "\n"
.text
main:
    li $v0, 4
    la $a0, prompt1
    syscall
    li $v0, 5
    syscall
    or $t1, $v0, $zero
    li $v0, 4
    la $a0, prompt2
    syscall
    li $v0, 5
    syscall
    or $t2, $v0, $zero
    add $s1, $t1, $t2
    sub $s2, $t1, $t2
    li $v0, 4
    la $a0, prompt3
    syscall
    add $a0, $zero, $s1
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, prompt4
    syscall 
    add $a0, $zero, $s2
    li $v0, 1
    syscall
    li $v0, 10
    syscall