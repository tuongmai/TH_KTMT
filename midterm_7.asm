.data
array: .word -1 150 190 -1 -1 140 -1 200 160 150 -1 -1 -1 170 180
array_end: .word
space: .asciiz " "
.text
la $a2,array # Luu dia chi phan tu dau tien cua mang vao a2
la $a3,array_end # Luu dia chi ket thuc mang vao a3

sort_by_height:
L1:
	beq $a2,$a3,end_sort # Kiem tra da ket thuc mang hay chua
	lw $a1,0($a2) # Lay gia tri a[i] luu vao a1
	addi $a2,$a2,4 # Luu dia chi phan tu tiep theo vao a2
	beq $a1,-1,print # Neu a1 = -1, in ra man hinh
	add $t0,$a2,$zero # Luu dia chi phan tu a[i+1] vao t0
L2:
	beq $t0,$a3,print # Kiem tra da ket thuc mang hay chua
	lw $t1,0($t0) # Lay gia tri a[j]
	add $t2,$t0,$zero # Luu lai dia chi save word
	addi $t0,$t0,4 # Luu dia chi phan tu tiep theo vao t0
	beq $t1,-1,L2 # Neu t1 = -1, la cay thi xet phan tu tiep theo
	slt $s1,$t1,$a1
	beqz $s1,L2 # Neu t1 >= a1 hay a[j] > a[i] thi xet phan tu tieo theo
	jal swap # Neu t1 < a1, hoan doi t1, a1
	j L2 # Xet tiep phan tu tiep theo
end_sort:
	li $v0, 10 #exit
	syscall
swap:
	add $s0,$a1,$zero # tmp = a1
	add $a1,$t1,$zero # a1 = t1
	add $t1,$s0,$zero # t1 = tmp
	sw $t1,0($t2) # Luu vao mang
	jr $ra
print:
	li $v0,  1
	add $a0, $0,$a1
	syscall  # In ra gia tri so nguyen to ma ta tim duoc
	
	li $v0, 4
	la $a0, space
	syscall # In ra dau cach
	
	j L1 # Xet phan tu tiep theo



