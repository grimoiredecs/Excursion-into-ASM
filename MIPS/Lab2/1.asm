    .data
buffer:  .space 128               # Space to store the user input string (up to 128 characters)
newline: .asciiz "\n"             # Newline for formatting output
comma:   .asciiz ","              # Comma for formatting output
space:   .asciiz " "              # Space for formatting output
prompt:  .asciiz "Enter: "        # Prompt for user input
freq:    .space 256               # Array to store frequency of characters (256 possible ASCII characters)
distinct: .space 128              # To store distinct characters

    .text
    .globl main

main:
    # Prompt the user for input
    li   $v0, 4                   # syscall for print_string
    la   $a0, prompt              # Load the prompt for user input
    syscall

    # Read the user input (string)
    li   $v0, 8                   # syscall for read_string
    la   $a0, buffer              # Address of buffer to store input
    li   $a1, 128                 # Maximum number of characters to read (including null terminator)
    syscall

    # Initialize frequency array to 0 (256 ASCII characters)
    li   $t0, 0                   # Initialize index to 0 for frequency array
    la   $t1, freq
init_freq_loop:
    bge  $t0, 256, process_string  # Exit loop after initializing 256 bytes
    sb   $zero, 0($t1)            # Set freq[i] = 0
    addi $t1, $t1, 1              # Move to the next byte (step by 1, not 4)
    addi $t0, $t0, 1              # Increment counter
    j    init_freq_loop           # Repeat initialization

process_string:
    # Process the string: count frequency of valid characters
    la   $a0, buffer              # Load the address of the user input string
next_char:
    lb   $t1, 0($a0)              # Load the next character from the string
    beq  $t1, $zero, print_results # If null terminator, end of string
    beq  $t1, 10, skip_char       # If newline (ASCII 10), skip it
    beq  $t1, 44, skip_char       # If comma (ASCII 44), skip it
    beq  $t1, 32, skip_char       # If space (ASCII 32), skip it
    
    # Increment frequency for the valid character
    la   $t2, freq                # Load address of frequency array
    add  $t2, $t2, $t1            # Move to the correct index based on character's ASCII value
    lb   $t3, 0($t2)              # Load the current frequency of this character
    addi $t3, $t3, 1              # Increment the frequency
    sb   $t3, 0($t2)              # Store the updated frequency back to the array

    # Move to the next character
skip_char:
    addi $a0, $a0, 1              # Move to the next character in the input string
    j    next_char                # Repeat the process

print_results:
    # Print distinct characters and their frequencies
    li   $t0, 0                   # Initialize index for distinct characters (ASCII range)
print_loop:
    bge  $t0, 256, exitcall        # If we've checked all ASCII characters, exit
    la   $t6, freq                # Load the frequency array base address
    add  $t6, $t6, $t0            # Move to the correct character index (using ASCII value)
    lb   $t1, 0($t6)              # Load the frequency of the current character
    beq  $t1, $zero, next_char_print # If frequency is zero, skip to the next character

    # Print the character
    li   $v0, 11                  # syscall for print_char
    move $a0, $t0                 # Move the current character (ASCII value) to $a0
    syscall

    # Print the frequency
    li   $v0, 1                   # syscall for print integer
    move $a0, $t1                 # Move the frequency to $a0
    syscall

    # Print a comma and space after each character-frequency pair
    li   $v0, 4                   # syscall for print_string
    la   $a0, comma               # Load comma
    syscall
    la   $a0, space               # Load space
    syscall

next_char_print:
    addi $t0, $t0, 1              # Move to the next character in ASCII
    j    print_loop               # Repeat the process for the next character

exitcall:
    li   $v0, 10                  # syscall to exit
    syscall
