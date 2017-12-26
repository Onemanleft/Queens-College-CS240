# Author: Onemanleft
# Last Modified Date: November 25, 2017 2:14 PM
# Program Name: MIPS Homework #1b
# Purpose:  Prompt the user to enter a constant value. for(int j = 0; j < 10; j++){A[j] = j + constant;}
# 			Displays the elements of the array A[ ], in a one row format
# Pseudo Code
# int t1=10, t6=0, int t2
# cout << "Enter your value: "
# cin >> t5
# for(int t0 = 0; t0 < 10; t0++) {
# A[t0] = 0
# for(int t0 = 0; t0 < 10; t0++) {
# A[t0] = t0 + t5
# cout << " " << t0 }
								
								# Beginning of the program
.text
.globl main						

								# Main
main:							# Main program
    li $t0, 0					# Counter
    move $t1, $a1               # Address of array into t1
    addi $t2, $a1, 40           # Length of array
	li $v0, 4 					# Load 4 into $v0 for a print string
	la $a0, prompt				# Load prompt to print the text
	syscall						# Print prompt
	li $v0, 5					# Load 5 into $v0 for a read int
	syscall						# Read the user's int
	move $t5, $v0				# Create a copy of the input to t5
								
								# Loop1
loop1:                          # Loop1 to fill array
    sw $t0, ($t1)				# Content of t0(counter) to t1(address of the array)
    addi $t0, $t0, 1			# Add 1 to counter
	addi $t1, $t1, 4            # Next array value
    slti $t3, $t0, 11			# Is the counter(t0) less than size(11)?
	beq $t3, 1, loop1			# If the counter is less, continue loop1
	move $t1, $a1               # Reinitialize address of the array
	
                                # Loop2
loop2:                          # Loop2 to print the result
    lw $t0, ($t1)               # Load the array address
	add $t0, $t0, $t5			# Add the contents of the array(t0) to the user's input(t5)
	li $v0, 4					# Load 4 into $v0 for a print string
	la $a0, result          	# Load result to print the text
	syscall						# Print result(just a space for formatting)
    li $v0, 1                   # Load 1 into $v0 for a print int
    move $a0, $t0               # Create a copy of the result(t0) to a0
    syscall                     # Print the numerical result
    addi $t1, $t1, 4            # Next array location
    slt $t3, $t1, $t2			# Is the array address(t1) less than the max array address size(t2)?
	beq $t3, 1, loop2			# If the array address(t1) is less, continue loop2
	
	                            # Exit
exit:                           # Exit the program
	li $v0, 10					# Load 10 into $v0 for exit
	syscall                     # Execute exit
	
.data 							
	prompt: .asciiz "Enter a constant value: "
	result: .asciiz " "