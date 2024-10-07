.data 
prompt: .asciiz "Please enter a positive integer less than 16: "
res: .asciiz "Its binary form is: "
endl: .asciiz "\n"
binary: .space 4		# Space for 4 binary digits
too_large: .asciiz "Your input is over 15, try entering again!\n"
too_small: .asciiz "Your input is under 0 (negative), try entering again!\n"
.text 
main:
	li $v0, 4		
	la $a0, prompt
	syscall 
	
	li $v0, 5		
	syscall 
    add $t0, $v0, $zero
validity:
	# Check if input is valid (0 <= input < 16)
	bge $t0, 16, over	
	bltz $t0, under		
	li $v0, 4
	la $a0, res
	syscall 
    la $t1, binary  		
    addi $t1, $t1, 3  		# Point $t1 to the last position in the binary array
    li $t2, 4       		
    li $t3, 2       		
conversion:
    div $t0, $t3
    mflo $t0				
    mfhi $t4				

    addi $t4, $t4, '0'		# Convert remainder to ASCII ('0' or '1')
    sb $t4, 0($t1) 			
    addi $t1, $t1, -1		
    subi $t2, $t2, 1		
    bnez $t2, conversion  	

    addi $t1, $t1, 1
    
    li $t2, 4       		

printloop:
    lb $a0, 0($t1) 		
    li $v0, 11			
    syscall
    addi $t1, $t1, 1		
    subi $t2, $t2, 1		
    bnez $t2, printloop 
exit:
	li $v0, 10			
	syscall

over:
    li $v0, 4
    la $a0, too_large
    syscall
    j main
under:
    li $v0, 4
    la $a0, too_small
    syscall
    j main