	.data
input_prompt:	.asciiz	"Enter a value greater than 1: "
exit_statement:	.asciiz "Exiting program."
new_line:		.asciiz	"\n"
plus:			.asciiz "+"
equals:			.asciiz "="
the_number:		.asciiz "The number "
is_perfect:		.asciiz " is perfect!\n"
is_not_perfect:	.asciiz	" is not perfect.\n"
prime:			.asciiz	" is not perfect and prime.\n"
i:				.asciiz "i = "
testVal:		.asciiz "testVal = "

	.text
	


		

	.globl INPUT_VAL
INPUT_VAL:
		# Print "Enter a value greater than 1: "
		li		$v0, 4
		la		$a0, input_prompt
		syscall

		# Read in the value from the user
		li		$v0, 5
		syscall

		# Return to main
		jr		$ra

	.globl	CHECK_VAL
CHECK_VAL:
		# Check if userValue is greater than 1
		slti	$t0, $a0, 2								# if (userVal < 2) {$t0 = 1}		
		
		# Return to main
		jr		$ra

PRINT_SUM_OF_FACTORS:
		# Print the first factor, it's always 1 
		li		$v0, 1
		li		$a0, 1
		syscall

		# Set up Loop2
		li		$t1, 2									# testVal = 2
		li		$t2, 1									# factorSum = 1

		Loop2:
		# Set up IS_A_FACTOR
		move	$a0, $s0								# a0 = userVal
		move	$a1, $t1								# a1 = testVal

		jal		IS_A_FACTOR

		beq		$v0, $zero, skip						# if (not a factor) {skip}

		# Print plus sign and testVal 
		li		$v0, 4
		la		$a0, plus
		syscall

		li		$v0, 1
		move	$a0, $t1
		syscall

		# Increment factorSum (factorSum = testVal + factorSum)
		add		$t2, $t1, $t2

		skip:
		# increment testVal	
		addiu	$t1, $t1, 1

		bge		$t1, $s0, out_Loop2						# if (testVal >= userVal) {out_Loop2}	FIXME: This doesn't work and it never breaks out of the loop even though I did print tests along with QTSPim debugging to keep track of the registers and the program just acts like this statement isn't there.  
		j		Loop2

		out_Loop2:
		# Print "=[factorSum]\n"
		li		$v0, 4
		la		$a0, equals
		syscall

		li		$v0, 1
		move	$a0, $t2
		syscall

		li		$v0, 4
		la		$a0, new_line
		syscall

		# Check if factorSum == userVal
		beq		$t2, $s0, perfectNum

		# Check if userNum is prime ---> if (factorSum == 1) {cout << "The number [userNum] is not perfect and prime."}
		li		$t3, 1
		bne		$t2, $t3, not_perfect_not_prime

		li		$v0, 4
		la		$a0, the_number
		syscall

		li		$v0, 1
		move	$a0, $s0
		syscall

		li		$v0, 4
		la		$a0, prime
		syscall

		j		GoToThis

		not_perfect_not_prime:
		# "The number [userNum] is not perfect.\n"
		li		$v0, 4
		la		$a0, the_number
		syscall

		li		$v0, 1
		move	$a0, $s0
		syscall

		li		$v0, 4
		la		$a0, is_not_perfect
		syscall

		j		GoToThis

		perfectNum:
		# "The number [userNum] is perfect!\n"
		li		$v0, 4
		la		$a0, the_number
		syscall

		li		$v0, 1
		move	$a0, $s0
		syscall

		li		$v0, 4
		la		$a0, is_perfect
		syscall

		j		GoToThis

		.globl IS_A_FACTOR
IS_A_FACTOR:
		# Accepts userValue through $a0 and the potential factor through $a1.  If testVal is a factor, it returns a value of 1 through $v0 and 0 if not a factor 

		div		$a0, $a1									# Divide $a0 (user number) by $a1 (potential factors)
		mfhi	$v1	                                        # Move remainder to $v1
		bnez    $v1, not_a_factor							# If not a factor, {not_a_factor}
		li      $v0,1										# If it is a factor, $v0 = 1
		j       out											# goto out

not_a_factor:
        li      $v0,0										# If not a factor, $v0 = 0

out:
        jr      $ra

		.globl main
main:
		# The program will run as long as the user's value is > 1
		Loop1:

		jal		INPUT_VAL
		move	$a0, $v0								# setting up CHECK_VAL function
		move	$s0, $v0								# save userVal
		jal		CHECK_VAL
		bne		$t0, $zero,	exit_Loop1						# if ($t0 != 0) {exit}

		jal PRINT_SUM_OF_FACTORS
		GoToThis:
		j	Loop1
		

		exit_Loop1:	
		# Print exit message and exit program. exit is last function because we can't use syscall to end the program
		li		$v0, 4
		la		$a0, exit_statement
		syscall