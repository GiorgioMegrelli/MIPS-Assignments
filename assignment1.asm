## Read input integer
li $v0, 5
syscall

## Restore input value in $t0
add $t0, $v0, $zero

## Store 100 in $t1
li $t1, 100

## input / 100
div $t0, $t1

## Move result to $t2 (a)
mflo $t2

## Store 10 in $t1
li $t1, 10

## input % 10
div $t0, $t1

## Move result to $t4 (c)
mfhi $t4

## (input / 10) % 10
div $t0, $t1

## Move mid result to $t3 (b)
mflo $t3
div $t3, $t1

## Move final result to $t3 (b)
mfhi $t3

## Count and print = input % a
li $v0, 1
div $t0, $t2
mfhi $a0
syscall

## Print space
li $a0, 32
li $v0, 11
syscall

## Count and print = input % b
li $v0, 1
div $t0, $t3
mfhi $a0
syscall

## Print space
li $a0, 32
li $v0, 11
syscall

## Count and print = input % c
li $v0, 1
div $t0, $t4
mfhi $a0
syscall

## Exit
li $v0, 10
syscall
