.data
.float 32.0
.align 2 	# align the next string on a word boundary
.space 100

outpAuth: 	.asciiz "Madison Dockery, Project3, Average\n"
prompt: 		.asciiz "How many numbers would you like to average?\n"
promptData: 	.asciiz "Please enter a 3 digit decimal d.dd:\n"
outAverage: 	.asciiz "The average is:\n"

zero: 		.float 0.0
count: 		.float 1.0

.text
.globl main

main:
# system call to print author
		la $a0, outpAuth
		li $v0, 4
		syscall
		

# system call to prompt user
		la $a0,prompt		# system call 4 for print string needs address of string in $a0
		li $v0,4			# system call 4 for print string needs 4 in $v0
		syscall	


# system call to store user input of an integer into register $f0
		li $v0,6		     # system call 6 for reading an integer
		syscall	             # the user's input is placed in register $f0
		mov.s $f1, $f0 	     # moving to a float

# system call to prompt user to enter integers
		la $a0, promptData
		li $v0, 4
		syscall

		lwc1 $f4, zero
		lwc1 $f2, zero
		lwc1 $f3, zero
		lwc1 $f5, count
	
# the loop is below
	loop:   c.le.s $f1, $f4
		bc1t exit
		la $a0, promptData	# prompt user to enter data
		li $v0, 4
		syscall
		
		li $v0, 6
		syscall
		
		add.s $f2, $f2, $f0 	# adding the numbers
		add.s $f4, $f4, $f5
		j loop

	exit:   div.s $f2, $f2, $f1
		
		la $a0, outAverage 	# output average
		li $v0, 4
		syscall
		
		li $v0, 2
		add.s $f12, $f2, $f3
		syscall


# Exit gracefully
        		li $v0, 10       # system call for exit
         	syscall          # close file
         	

# I didn't enjoy this project as much as project 2 but I still found it interesting
# This project made me appriciate high level language code because
# I had a hard time with the syntax for what I wanted to write
# This project took me a while to complete in assembly language which was
# frustating, because I could have written this program in high level language
# in a fraction of the time.However, I learned a lot from this project.
