.data 
	first: .asciiz "Nhap so N " 
	second: .asciiz "Nhap so M"
	space_c: .asciiz " "
.text
li $v0, 51
la $a0, first
syscall  # Input Dialog Int
add $t0,$0,$a0 # Save input to $t0

li $v0, 51
la $a0, second
syscall # Input Dialog nt
add $t1,$0,$a0 # Save input to $t1
blt $t1,$t0,Exit
blt $t1,$0,Exit

addi $s0,$t0,-1 # $s0 la thanh ghi luu gia tri so ta dang xet 
addi $s1,$t1,1 # $s1 la thanh ghi luu gia tri so de ta thoat khoi vong lap
li $t2,2
j L1

Print: 
	li $v0,  1
	add $a0, $0,$s0
	syscall  # In ra gia tri so nguyen to ma ta tim duoc
	
	li $v0, 4
	la $a0, space_c
	syscall # In ra dau cach
j L1

L1:
	addi $s0,$s0,1 # Gan s0 = gia tri lan luot trong khoang tu N -> M
	beq $s0,$s1,Exit # Neu ta nhap input N > M --> Exit
	blt $s0,$t2,L1 # Neu s0 < 2 --> So nay khong phai la so nguyen to
	addi $s2,$0,2 # Xet trong khoang tu 2 -> s0/2
	addi $s3,$s0,0 # s3 = s0
	div $s3,$s3,$t2 # s3 = s3/2 = s0/2
L2:	
	blt $s3,$s2,Print # Khi xet het tu 2 -> s0/2 ta check xem day co phai so nguyen to khong nho thanh ghi t5
	div $s0,$s2 # s0 = s0/s2
	mfhi $s5 # Luu phan du vao s5
	add $t5,$0,$s5 # gan t5 = s5
	beq $t5,$0,L1 # Neu t5 = 0 --> So nay khong phai so nguyen to
	addi $s2,$s2,1 # Tang s2 len 1 cho toi khi s2 > s3
	j L2 # Lap lai cho den khi dieu kien dung dat duoc
Exit: 
	li $v0, 10 #exit
	syscall







