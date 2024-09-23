#Write a MIPS program that does the following steps:
#1. Request the user to insert 2 numbers.
#2. Request the user to choose a mathematical operation (including addi- tion, subtraction, multiplication, and division).
#3. Perform that selected operation and return the result.

.data
	request: .asciiz "Please enter 2 numbers: "
	age: .word 34	#the age (word - 32 bits) 
	greeting: .asciiz "Hello World"
	decision_branch: .asciiz "Which calculations do you want to execute? \n"
.text
main:
	
	
	li $v0, 4
	la $a0, request
	syscall

	li $v0, 5
	syscall
	add $s0, $0, $v0

	li $v0, 5
	syscall
	add $s1, $0, $v0


	
	# program's termination
	li $v0, 10
	syscall
	