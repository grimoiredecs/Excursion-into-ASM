#Write a MIPS program that does the following steps:
#1. Request the user to insert 2 numbers.
#2. Request the user to choose a mathematical operation (including addi- tion, subtraction, multiplication, and division).
#3. Perform that selected operation and return the result.

.data
	request: .asciiz "Please enter 2 numbers: "
	age: .word 34	#the age (word - 32 bits) 
	greeting: .asciiz "Hello World"
	decision_branch: .asciiz "Which calculations do you want to execute? \n"
	addition: .asciiz "1. Addition\n"
	decisions: .asciiz "1. Addition\n2. Subtraction\n3. Division\n4. Multiplication\n"
	division: .asciiz "3. Division\n"
	multiplication: .asciiz "4. Multiplication\n"
	wrong_input: .asciiz "WRONG INPUT!!!\n Please enter an integer please!\n"
.text
main:
	
	
	li $v0, 4
	la $a0, request
	syscall

	li $v0, 12
	syscall
	add $s0, $0, $v0
	# branch out to check IF the input is valid (integer) or not!


	li $v0, 12
	syscall
	add $s1, $0, $v0
	# branch out to check IF the input is valid (integer) or not!




	#choosing the calculation
	li $v0, 4
	la $a0, decision_branch
	syscall
	
	li $v0, 4
	la $a0, decisions
	syscall
	





	
	# program's termination
	li $v0, 10
	syscall
	
