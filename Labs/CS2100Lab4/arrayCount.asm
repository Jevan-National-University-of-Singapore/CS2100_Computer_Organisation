# arrayCount.asm
	.data 
arrayA: .word 1, 12, 10, 5, 16, 4, 0, 34   # arrayA has 5 + 3 values
count:  .word 0             # dummy value

	.text
main:
	# code to setup the variable mappings
	la $t0, arrayA
	lw $t8, count

	# code for reading in the user value X
	li $v0, 5      # system call code for read_int into $a0
	syscall        # ask for input

	# code for counting multiples of X in arrayA
	
	addi $t1, $v0, -1         #get mask of X
	addi $t2, $t0, 0 	  #initial array element
	addi $t3, $t0, 32	  #final array element

	loop: bge $t2, $t3, end   #while iterator != 8
	lw $t5, 0($t2)		  #load array[iterator] into $t5
	and $t4, $t5, $t1         #Find remainder
	bne $t4, $zero, skip      #if remainder != 0, then go to skip
	addi $t8, $t8, 1	  #else count++
	skip: addi $t2, $t2, 4    #iterator ++
	j loop                    #go back to loop
	end:
	sw $t8, count
	
	# code for printing result

	li   $v0, 1    # system call code for print_int
	move $a0, $t8  # integer to print
	syscall        # print the integer

	# code for terminating program
	li  $v0, 10
	syscall
