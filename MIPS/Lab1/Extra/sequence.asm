    .data
    RequestN: .asciiz "Please enter N: "      # Prompt for N
    RequestM: .asciiz "Please enter M: "      # Prompt for M
    RequestX: .asciiz "Please enter X: "      # Prompt for X
    newline:  .asciiz "\n"                    # Newline for formatting

.text
main:
    # Request and read N
    li $v0, 4                                # syscall to print string
    la $a0, RequestN                         # load address of "Please enter N: "
    syscall                                  # make the syscall to print the prompt

    li $v0, 5                                # syscall to read integer
    syscall                                  # read N from the user
    ori $s0, $v0, 0                          # store N in $s0 using ori

    # Request and read M
    li $v0, 4                                # syscall to print string
    la $a0, RequestM                         # load address of "Please enter M: "
    syscall                                  # make the syscall to print the prompt

    li $v0, 5                                # syscall to read integer
    syscall                                  # read M from the user
    ori $s1, $v0, 0                          # store M in $s1 using ori

    # Request and read X
    li $v0, 4                                # syscall to print string
    la $a0, RequestX                         # load address of "Please enter X: "
    syscall                                  # make the syscall to print the prompt

    li $v0, 5                                # syscall to read integer
    syscall                                  # read X from the user
    ori $s2, $v0, 0                          # store X in $s2 using ori

    # Initialize the sequence
    ori $t0, $s0, 0                          # $t0 = N (initial value in the sequence)
    ori $t1, $s1, 0                          # $t1 = M (multiplier)
    ori $t2, $s2, 0                          # $t2 = X (counter for how many times)

    li $t3, 1                                # $t3 = loop counter (starts from 1)

print_sequence:
    # Print the current value of the sequence (N * M^(i-1))
    li $v0, 1                                # syscall to print an integer
    ori $a0, $t0, 0                          # move the current value of the sequence (N * M^(i-1)) using ori
    syscall                                  # print the number

    # Print newline for formatting
    li $v0, 4                                # syscall to print string
    la $a0, newline                          # load address of newline string
    syscall                                  # make syscall to print newline

    # Multiply the current value by M (t0 = t0 * M)
    mult $t0, $t1                            # multiply t0 (current result) by t1 (M)
    mflo $t0                                 # move the result of multiplication back to t0

    # Decrement the loop counter (X--)
    subi $t2, $t2, 1                         # decrement X (remaining iterations)

    # Check if we should continue the loop
    bnez $t2, print_sequence                 # if X is not zero, continue looping

exit_program:
    # Exit the program
    li $v0, 10                               # syscall to exit
    syscall
