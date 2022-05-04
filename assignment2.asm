## Read input integer
li $v0, 5
syscall

## Restore input value in $t0
move $t0, $v0

## Load initial prime (=2) devisor
li $t1, 2

## Print 2s that devide $t0
loop1:
	## while(n % 2 == 0)
	div $t0, $t1
	mfhi $t2
	bne $t2, $zero, end1
	mflo $t0
	## Print '2'
	li $v0, 1
	li $a0, 2
	syscall
	## Print space
	li $v0, 11
	li $a0, 32
	syscall
	j loop1

end1:
	## Load start prime devisor
	li $t1, 3

loop2:
	## for(r = 3; r <= n; r += 2)
	bgt $t1, $t0, exit

	loop3:
		## while(n % r == 0)
		div $t0, $t1
		mfhi $t2
		bne $t2, $zero, end3
		mflo $t0
		## Print value in r
		li $v0, 1
		move $a0, $t1
		syscall
		## Print space
		li $v0, 11
		li $a0, 32
		syscall
		j loop3

	end3:
	addi $t1, $t1, 2
	j loop2

exit:
	## Exit
	li $v0, 10
	syscall
