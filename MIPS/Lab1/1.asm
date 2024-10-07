.data
	irequest: .asciiz "Enter your name please: "
	request: .asciiz "Hello "
	input_str: .space 100
	exclam: .asciiz "!"
.text
main:
	li $v0, 4
	la $a0, irequest
	syscall
	
	la $a0, input_str
	addi $a1, $0, 100
	li $v0, 8
	syscall
	
	la $t0, input_str
check:
#since newline is 0xA in hexa, we just check
#if there's a newline in our string then remove them
	lb $t1, 0($t0)
	beq $t1, 10, sanitize
	addi $t0, $t0, 1
	j check
sanitize:
	sb $zero, 0($t0)
output:
	li $v0, 4
	la $a0, request
	syscall
	
	li $v0, 4
	la $a0, input_str
	syscall
	li $v0, 4
	la $a0, exclam
	syscall
	li $v0, 10
	syscall
