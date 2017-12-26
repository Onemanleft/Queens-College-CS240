# Author: Onemanleft
# Last Modified Date: December 12, 2017 10:39 PM
# Program Name: MIPS Homework #2
# Purpose:  Compute func(n): if (n = 0) return 8
# 			else return 4*func(n-1) + 3n;
# Pseudo Code
# 	int n;
#   cout << "Enter a integer >=0: ";
#   cin >> n;
#   cout << n << func(n) << "\n";
#   return 0;
# 	int func(int n){
#   	if(n == 0)
#       	return 8;
#     	else
#         	return (4 * func(n - 1) + (3*n));
# 	}

.text
.globl main

main:   					# Main
	li $v0, 4               # Load 4 into $v0 for a print string
	la $a0, prompt          # Load prompt
    syscall                 # Print prompt
    li $v0, 5               # Load 5 into $v0 for a read int
    syscall                 # Store the user's input
    move $a0, $v0           # Make a copy of the input $a0 = $v0
							# 3n using sll and add (2n + n)
	sll $t0, $v0, 1			# 2n
	add $t0, $t0, $v0		# 2n + n
    jal check               # Create a $ra and goto check
	add $v0, $v0, $t0		# Answer + 3n
    move $a0, $v0           # Create a copy of the answer
	li $v0, 1               # Load 1 into $v0 for a print int
	syscall                 # Print the answer
	li $v0, 4               # Load 4 into $v0 for a print string
	la $a0, line            # Load line
	syscall                 # Print a new line
	li $v0, 10				# Load 10 into $v0 for exit
	syscall                 # Execute exit
		
check:    					# check
	bne $a0, $zero, func    # If the user's input is not zero, calculate
	li $v0, 8				# Base case if the input is zero
    jr $ra              	# Jump to $ra 
	
func:    					# func
	addi $sp, $sp, -8      	# Load two word size for $ra and $a0
	sw $a0, 0($sp)         	# Save $a0 (n) at stack 0($sp)
    sw $ra, 4($sp)         	# Save $ra at stack 4($sp)
    addi $a0, $a0, -1      	# $a0 = (n-1)
    jal check               # $v0 = check(n-1) - Recursive step
    lw $a0, 0($sp)         	# Restore $a0 (n)
    lw $ra, 4($sp)         	# Restore $ra
    addi $sp, $sp, 8       	# Deallocate stack
	sll $v0, $v0, 2         # Answer=(n-1)*4
    jr $ra                 	# Jump to $ra

.data
	prompt:	.asciiz "Enter a integer >=0: "
	line:	.asciiz "\n"
