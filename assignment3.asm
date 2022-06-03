## Array
.data
array: .space 10001

## Instructions
.text

## i = 0
li $t1, 0
li $t2, 10001

loop1:
	sb $zero, array($t1)
	addi $t1, $t1, 1
	bge $t1, $t2, loop1end
	j loop1

loop1end:

## Read input integer
li $v0, 5
syscall

## Restore input value in $t0
move $t0, $v0

## i = 2
li $t1, 2

## for (i = 2; i <= n; i++)
loop2:
	bgt $t1, $t0, loop2end
	lb $t2, array($t1)

	li $t3, 1

	if1:
		## if (num[i] != 1)
		beq $t2, $t3, if1end

		## cout << i << endl
		move $a0, $t1
		li $v0, 1
		syscall
		li $a0, 10
		li $v0, 11
		syscall

		## for (j = i * i; j <= n; j = j + i)
		mul $t4, $t1, $t1
		loop3:
			bgt $t4, $t0, loop3end
			## num[j] = 1
			sb $t3, array($t4)
			add $t4, $t4, $t1
			j loop3
		loop3end:

	if1end:

	addi $t1, $t1, 1
	j loop2

loop2end:
