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
	bge $t0, 16, over	# If $t0 >= 16, re-prompt user
	bltz $t0, under		# If $t0 < 0, re-prompt user
	# Print output header
	li $v0, 4
	la $a0, res
	syscall 
    la $t1, binary  		# Load address of the binary string
    addi $t1, $t1, 3  		# Point $t1 to the last position in the binary array
    li $t2, 4       		# 4 binary digits to process
    li $t3, 2       		# $t3 = 2 for division
conversion:
	# Divide $t0 (decimal number) by 2, quotient in $t0, remainder in $t4
    div $t0, $t3
    mflo $t0				# Store quotient back in $t0
    mfhi $t4				# Store remainder in $t4

    addi $t4, $t4, '0'		# Convert remainder to ASCII ('0' or '1')
    sb $t4, 0($t1) 			# Store the binary digit in memory at $t1
    addi $t1, $t1, -1		# Move the pointer backwards for the next digit
    subi $t2, $t2, 1		# Decrement counter
    bnez $t2, conversion  	# Continue until all 4 digits are processed

    # Move pointer back to the start of the binary string
    addi $t1, $t1, 1
    
    # Reset counter to print 4 digits
    li $t2, 4       		

printloop:
    lb $a0, 0($t1) 		# Load binary digit into $a0
    li $v0, 11			# Print character syscall
    syscall
    addi $t1, $t1, 1		# Move pointer to the next binary digit
    subi $t2, $t2, 1		# Decrement counter
    bnez $t2, printloop 	# Loop until all digits are printed


exit:
	li $v0, 10			# Exit program
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