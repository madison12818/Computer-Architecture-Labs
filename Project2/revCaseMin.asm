# Code for reversing the case of a 30 character input.
# Madison Dockery
# July 2019
# 
# I enjoyed writing the psuedocode for this project 
# but I had a hard time writing it to assembly code
# I feel like this was helpful to see how to apply the assembly functions we learned in lecuture
# such as add, addi, sb, etc.
# 
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is Madison Dockery presenting revCaseMin.\n"
outpPrompt: .asciiz  "Please enter 30 characters (upper/lower case mixed):\n"
	    .align 2   #align next prompt on a word boundary 
outpStr:    .asciiz  "You entered the string: "
            .align 2   # align users input on a word boundary
varStr:     .space 32  # will hold the user's input string thestring of 20 bytes 
                       # last two chars are \n\0  (a new line and null char)
                       # If user enters 31 characters then clicks "enter" or hits the
                       # enter key, the \n will not be inserted into the 21st element
                       # (the actual users character is placed in 31st element).  the 
                       # 32nd element will hold the \0 character.
                       # .byte 32 will also work instead of .space 32
            .align 2   # align next prompt on word boundary
outpStrRev: .asciiz   "Your string in reverse case is: "
            .align 2   # align the output on word boundary
varStrRev:  .space 32  # reserve 32 characters for the reverse case string
	    .align 2   # align  on a word boundary
outpStrMin: .asciiz    "The min ASCII character after reversal is: "
result:	    .byte 1    # this variable is for storing the the MinRev
#
            .text      # code section begins
            .globl	main 
main:  

# system call to display the author of this code

	 la $a0,outpAuth		# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

# system call to prompt user for input

	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

# system call to store user input into string thestring

	li $v0,8			# system call 8 for read string needs its call number 8 in $v0
        				# get return values
	la $a0,varStr    	# put the address of the string buffer in $t0
	li $a1,32 	        # maximum length of string to load, null char always at end
				# but note, the \n is also included providing total len < 22
        syscall
        move $t0,$v0		# save string to address in $t0; i.e. into "the string"

# system call to display "You entered the string: "

	 la $a0,outpStr 		# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	

# system call to display user input that is saved in "varStr" buffer

	 la $a0,varStr  		# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

# Your code to invoke revCase goes next	 

	jal revCase

# Exit gracefully from main()

         li   $v0, 10       # system call for exit
         syscall            # close file
         
         
################################################################
# revCase() procedure can go next
################################################################
#  Write code to reverse the case of the string.  The base address of the
# string should be in $a0 and placed there by main().  main() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that main() will use in its jal 
# instruction to invoke revCase, perhaps revCase:
#
revCase:
	#declaring variables
	addi $t0, $zero, 0
	la $s1, varStr
	la $s2, varStrRev
	
	#start loop
	while:
	#checking user doesn't go over 30 variables
	bgt $t0, 30, exit
	#load bit
	lbu $t3, ($s1)
	#check if upper or lower
	slti $t4, $t3, 96
	#if upper, change to lower
	beq $t4, 1, L1
	#if lower, change to upper
	bne $t4, 1, L2
	#make L1
	L1:
	addi $t1, $t3, 32
	sb $t1, ($s2)
	addi $t0, $t0, 1
	addi $s1, $s1, 0x01 #varStr
	addi $s2, $s2, 0x01 #revStrVar
	j while
	#make L2
	L2:
	addi $t1, $t3, -32
	sb $t1, ($s2)
	addi $t0, $t0, 1
	addi $s1, $s1, 0x01 #varStr
	addi $s2, $s2, 0x01 #revStrVar
	j while
	
	exit: 
	
	
	
# This is the system call to display "Your string in reverse case is: "

	 la $a0,outpStrRev 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
	 
# system call to display the user input that is in reverse case saved in the varRevStr buffer

	 la $a0,varStrRev  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

# Your code to invoke findMin() can go next
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	
	jal findMin
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
# Your code to return to the caller main() can go next
	jr $ra


################################################################
# findMin() function can go next
################################################################
#  Write code to find the minimum character in the string.  The base address of the
# string should be in $a0 and placed there by revCase.  revCase() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that revCase() will use in its jal 
# instruction to invoke revCase, perhaps findMin:
#
# 
findMin:
# write use a loop and find the minimum character
	#initialize registers
	addi $t0, $zero, 0
	la $t1, varStrRev
	lbu $t2, ($t1) #$t2 is going to be the "min character"
	#start loop
	loop:
	beq $t0, 29, end
	addi $t1, $t1, 0x01
	lbu $t3, ($t1)
	slti $t4, $t2, 41
	beq $t4, 1, end
	bne $t4, 1, Label1
	#load bit
	#check if bit is greater than another bit
	#keep smallest bit
	#load another bit
	Label1:
	slt $t4, $t2, $t3
	beq $t4, 1, Label3
	bne $t4, 1, Label2
	Label2:
	add $t2, $t3, 0
	add $t0, $t0, 1
	j loop
	Label3:
	add $t0, $t0, 1
	j loop
	end: 
	
# system call to display "The min ASCII character after reversal is:  "

	 la $a0,outpStrMin 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	

# write code for the system call to print the the minimum character
	
	sb $t2, result
	la $a0, result
	li $v0, 4
	syscall

# write code to return to the caller revCase() can go next
	
	jr $ra
