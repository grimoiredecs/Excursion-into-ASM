.data
	irequest: .asciiz "Enter your name please: "
	request: .ascii "Hello "
	input_str: .space 100
.text
main:
	
	li $v0, 4
	la $a0, irequest
	syscall
	la $a0, input_str
	addi $a1, $0, 100
	li $v0, 8
	syscall

	li $v0, 4
	la $a0, request
	syscall

	li $v0, 10
	syscall
	
