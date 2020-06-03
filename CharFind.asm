.data
	prompt1: .asciiz "Enter a string of at most 100 characters\n"
	prompt2: .asciiz "Enter a character to search for\n"
	prompt3: .asciiz "\nThe number of occurrences for that character is: "
	userInput: .space 101 # string of at most 100 characters (+1 for null character)
.text
	main:
	
	# print prompt1
	li $v0, 4
	la $a0, prompt1
	syscall
	
	# read user text
	li $v0, 8
	la $a0, userInput # where the string will be stored
	li $a1, 100 # how long the string may be
	syscall
	
	# print prompt2
	li $v0, 4
	la $a0, prompt2
	syscall
	
	# read user char
	li $v0, 12
	syscall
	move $t0, $v0 # transfer char to temp register
	
	# Loop to count number of occurences
	la $t1, userInput # input string
	li $t3, 0 # number of occurences count
	loop:
		lb $t2, 0($t1) # load first char (byte) of input string
		beqz $t2, exit # if end of string, exit loop
		addi $t1, $t1, 1 #increment index in string
		bne $t0, $t2, skip # if character doesn't match, skip increment
		addi $t3, $t3, 1 # increment count
		skip:
		j loop
		
	exit:
	
	# print prompt3
	li $v0, 4
	la $a0, prompt3
	syscall
	
	# print number of occurences of character
	li $v0, 1
	move $a0, $t3
	syscall
	
	# end of program
	li $v0, 10
	syscall