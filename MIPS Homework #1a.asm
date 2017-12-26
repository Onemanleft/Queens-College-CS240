# Author: Onemanleft
# Last Modified Date: November 25, 2017 2:14 PM
# Program Name: MIPS Homework #1a
# Purpose: Compute and display 4*int1+int2-3 from the user's integers and a sentinal to exit.
# Pseudo Code
# main: cout << "Enter the first integer in the range [-20, 0]: "
# 		cin >> s0
#		while (s0<=20 || s0>=0) {
#			cout << "ERROR: Enter the first integer in the range [-20, 0] \n
#			Enter the first integer in the range [-20, 0]: "
#		cin >> s0 }
# 		cout << "Enter the second integer in the range [10, 30]: "
# 		cin >> s1
# 		while (s1<=10 || s0>=30) {
#       cout << "ERROR: Enter the first integer in the range [10, 30] \n
#			Enter the first integer in the range [10, 30]: "
#		cin >> s1 }
#		cout << "The value is " << 4*s0+s1-3
								
								# Beginning of the program
.text
.globl main						
								# Main
main:							# Main program
								# Initialize temporary variables for intervals
	li $t0, -20					# Lower limit for prompt1
	li $t1, 10					# Lower limit for prompt2
	li $t2, 30					# Upper limit for prompt2
	li $t9, 99					# Sentinel value that will allow the user to exit the program
								# Loop1						
	loop1:						# The first loop for the first int prompt
		li $v0, 4 				# Load 4 into $v0 for a print string
		la $a0, prompt1			# Load prompt1 to print the text
		syscall					# Print prompt1
		li $v0, 5				# Load 5 into $v0 for a read int
		syscall					# Read the int
		move $s0, $v0			# Create a copy of the input
		beq $s0, $t9, exit		# Sentinel exit if 99
								# Check if the number is valid
		slt $t3, $t0, $s0    	# t0(-20) is the lower limit, compare it to the input
		slt $t4, $s0, $zero    	# zero is the upper limit, compare it to the input
		and $t5, $t4, $t3    	# If either is returned false, t5 will be false
		beqz $t5, errormsg1		# If t5 is false (eqz), it will branch to errormsg1
		
								# Loop2		
	loop2:						# The second loop for the second int prompt
		li $v0, 4 				# Load 4 into $v0 for a print string
		la $a0, prompt2			# Load prompt2 to print the text
		syscall					# Print prompt2
		li $v0, 5				# Load 5 into $v0 for a read int
		syscall					# Read the int
		move $s1, $v0			# Create a copy of the input	
		beq $s1, $t9, exit		# Sentinel exit if 99
								# Check if the number is valid
		slt $t3, $t1, $s1       # t1(10) is the lower limit, compare it to the input
		slt $t4, $s1, $t2       # t2(30) is the upper limit, compare it to the input
		and $t5, $t4, $t3       # If either is returned false, t5 will be false
		beqz $t5, errormsg2     # If t5 is false (eqz), it will branch to errormsg2
		
								# Compute
	compute:					# Compute 4*int1+int2-3
		addi $t0, $s1, -3		# Add -3 to the second int
		sll $t1, $s0, 2			# Multiply the first int by 4 (2^2 from sll)
		add $s2, $t0, $t1		# Add the two results together		
								# Result
		li $v0, 4				# Load 4 into $v0 for a print string
		la $a0, result          # Load result to print the text
		syscall                 # Print the result
		move $a0, $s2           # Create a copy of the result
		li $v0, 1               # Load 1 into $v0 for a print int
		syscall					# Print the result
		
								# Exit
	exit:						# Exit the program
		li $v0, 10				# Load 10 into $v0 for exit
		syscall					# Execute exit
								
								# Errormsg1
	errormsg1:					# Failed inputs from loop1 go here
		li $v0, 4 				# Load 4 into $v0 for a print string
		la $a0, error1			# Load prompt to print the text
		syscall					# Print the prompt
		b loop1					# Branch back to loop1 for another input
		
								# Errormsg2
	errormsg2:					# Failed inputs from loop2 go here
		li $v0, 4 				# Load 4 into $v0 for a print string
		la $a0, error2			# Load prompt to print the text
		syscall					# Print the prompt
		b loop2					# Branch back to loop2 for another input
		
.data
	prompt1: .asciiz "\n Enter 99 to exit. Otherwise, enter the first integer in the range [-20, 0]: "
	prompt2: .asciiz "\n Enter 99 to exit. Otherwise, enter the second integer in the range [10, 30]: "
	error1:  .asciiz "ERROR: Enter the first integer in the range [-20, 0]"
	error2:  .asciiz "ERROR: Enter the second integer in the range [10, 30]"
	result:  .asciiz "The value is "
	

