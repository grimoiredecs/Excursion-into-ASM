.data 

name1: .asciiz "Johny"

.text 
main:
li $t1, name1
lw $t2, $t1

li $v0, 10
syscall