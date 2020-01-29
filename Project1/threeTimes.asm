# Starter code for threeTimes.asm
# Madison Dockery
# June 30th 2019
#
# The code then prompts the user for 3 integer values.
# The code outputs the summation of these 3 values multiplied by 3.
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz    "This is Madison Dockery presenting threeTimes.\n"
outpPrompt: .asciiz    "Please enter an integer: \n"
	    .align 2   #align next prompt on a word boundary
outpStr:    .asciiz    "The sum of your numbers multiplied by 3 is: \n"
            .align 2   # align users input on a word boundary

# main begins
            .text      # code section begins
            .globl	main 
main:  
###############################################################
# Display author of code
	 la $a0,outpAuth		# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

# Prompt user for input
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
	
# Read users input
	 li $v0, 5 		# system call 5 to read integer 
	 syscall
	 move $s0, $v0		# move into a register

# Prompt user for input
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall

# Read users input
	 li $v0, 5 		# system call 5 to read integer 
	 syscall
	 move $s1, $v0		# move into a register

# Prompt user for input
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall
	 
# Read users input
	 li $v0, 5 		# system call 5 to read integer 
	 syscall
	 move $s2, $v0		# move into a register

# Display "The sum of your numbers multiplied by 3 is: "
	 la $a0,outpStr 		# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  

# Do calculations
	add $t0, $s0, $s1 	# adding first two integers
	add $t0, $t0, $s2	# adding last integer
	add $t1, $t0, $t0	# next two steps are "multiplying by 3"
	add $t1, $t1, $t0
	move $s3, $t1	
	 		 			
# Display calculations
	li $v0,1 		# system call 1 to print integer
	move $a0, $s3
	syscall

# Exit gracefully
         li   $v0, 10           # system call for exit
         syscall                # close file
###############################################################

# I looked back on previous slides in the module to help with coding this project
# I enjoyed cleaning up this code to be my own
# This project helped me learn a lot concerning assebley code