## Init arrays
.data
input: .space 40004
localMax: .space 40004

## Instructions
.text

## Define alias
.eqv $n, $t0
.eqv $i, $t1
.eqv $j, $t2
.eqv $offset0, $t3
.eqv $offset1, $t4
.eqv $tmp0, $t5
.eqv $tmp1, $t6
.eqv $one, $s0
.eqv $result, $s1
.eqv $arg0, $a0
.eqv $arg1, $a1
.eqv word_size, 4	## MIPS word size

## Init alias
li $one, 1
li $result, 0

## Read input integer
li $v0, 5
syscall

## Restore input value in $n
move $n, $v0

## i = 0
li $i, 0

## Load address of array into $j
la $j, input

loop1:
	## Read input at i
	li $v0, 5
	syscall

	## Store input at input[i]
	sw $v0, 0($j)
	addi $i, $i, 1
	addi $j, $j, word_size

	bge $i, $n, loop1end
	j loop1

loop1end:

## b[0] = 1
sw $one, localMax($zero)

## i = 1
li $i, 1

loop2:
	## array offset = i * word size
	mul $offset0, $i, word_size
	sw $one, localMax($offset0)

	## j = i - 1
	subi $j, $i, 1
	loop3:
		## array offset = j * word size
		mul $offset1, $j, word_size

		## input[i]
		lw $tmp0, input($offset0)
		## input[j]
		lw $tmp1, input($offset1)

		## if(input[i] > input[j])
		ble $tmp0, $tmp1, loop3If

		## Call __maxfun [localMax[i] = max(localMax[i], localMax[j] + 1)]
		lw $arg0, localMax($offset0)
		lw $arg1, localMax($offset1)
		addi $arg1, $arg1, 1
		jal __maxfun
		sw $v0, localMax($offset0)

		loop3If:
		subi $j, $j, 1
		blt $j, $zero, loop3end

		j loop3
	loop3end:

	## result = max(result, localMax[i])
	lw $arg0, localMax($offset0)
	move $arg1, $result
	jal __maxfun
	move $result, $v0

	addi $i, $i, 1

	bge $i, $n, loop2end

	j loop2
loop2end:

## Print result
li $v0, 1
move $arg0, $result
syscall

## Finish program
li $v0, 10
syscall

## max(a, b), a = $arg0, b = $arg1
__maxfun:
	## if(a > b): go to '__maxfunIftrue'
	bgt $arg0, $arg1, __maxfunIfTrue

	## else [a <= b]
	__maxfunIfFalse:
		## Return b
		move $v0, $arg1
		j __maxfunIfElseend

	__maxfunIfTrue:
		## Return a
		move $v0, $arg0
		j __maxfunIfElseend

	__maxfunIfElseend:

	## Finish function
	jr $ra
