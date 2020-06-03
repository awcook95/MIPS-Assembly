.data
	prompt1: .asciiz "Enter an integer  x\n"
	prompt2: .asciiz "Enter an integer  y\n"
	out_msg1: .asciiz "The GCD of x and y is "
	out_msg2: .asciiz "\nWould you like to repeat the program? (0 to quit, any number to repeat)\n"
.text

Get_Input: #x and y end in t0 and t1 
	#print prompt for input x
	la $a0, prompt1
	li $v0, 4
	syscall 
	
	#get integer input
	li $v0, 5 
	syscall
	
	#move user input to temp register
	move $t0, $v0
	
	#print prompt for input y
	la $a0, prompt2
	li $v0, 4
	syscall 
	
	#get integer input
	li $v0, 5 
	syscall
	
	#move user input to temp register
	move $t1, $v0
	
Process_Input:
	#find absolute value of x - input and output located in t0
	sra $t3,$t0,31   
	xor $t0,$t0,$t3
	sub $t0,$t0,$t3
	
	#find absolute value of y - input and output located in t1
	sra $t3,$t1,31   
	xor $t1,$t1,$t3   
	sub $t1,$t1,$t3 
	
Loop: #do while loop to calculate the GCD of x and y (t0 and t1) output in register t0

	remu $t3,$t0,$t1 # n = x % y
	move $t0,$t1 # x = y
	move $t1,$t3 # y = n
	bgtz $t1, Loop # while(y > 0)
	

Exit:
	
	
Print_output:
	#print output message
	la $a0, out_msg1
	li $v0, 4
	syscall
	
	#print GCD
	li $v0, 1
	move $a0, $t0
	syscall
	
Repeat_Prompt:
	#print output message
	la $a0, out_msg2
	li $v0, 4
	syscall
	
	#get integer input
	li $v0, 5 
	syscall
	
	#restart program if user entered non zero number
	bnez $v0, Get_Input