# "Naive Sort" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

.data

D_VECTOR:	.word	9,2,5,1,8,2,4,3,6,7		#Array to Sort

.text
	#Set variabled
		li		a0, 0		#Return adress of Swap
		li		t6, 0		#FLAG of While control
				

	#The program receives the array pointer and its size

		la		a2, D_VECTOR					#a2 has the array pointer   |   float V[] 
		addi	a3, a2,36						#a3 has the array's size    |   int   n
		#addi	a3, a3,-4   					#a3 now is set as the condition to break the "loop"
		
# Marca do Inicio da Lógica do Programa #
		li		s2, 0							# int i
		li		s3, 1							# t = 1				

WHILE:								
		beq		s3, zero, FINAL_DA_CARAIA
		li		s3, 0

		li 		s2, 0							# i = 0		
		add		t0, a2, zero					#Initializing the moving address along array
FOR:		
		## Init For Condition
		#addi	a3, a3,-8						#a3 now is set as the condition to break the "loop"		
		#add		t0, a2, zero					#Initializing the moving address along array
		beq		t0, a3, WHILE					#Check if init position has reach the end of array
		## End For Condition
		
		lw		t2, (t0)						#t2 gets vector[n]
		lw		t3,	4(t0)						#t3 gets vector[n+1]
		beq		t2, t3, For_i
		slt		t1, t2, t3						#t1 gets 0 if vector[n] > vector[n+1]
		beq		t1, zero, SWAP

For_i:  #incremento do for
		addi	t0, t0, 4						#increment the "base" of the array 
		addi	s2, s2, 1
		j		FOR
						
CHK_SWAP:
		slt		t1, zero, a0
		beq		t1, a0, FLAG		
		

FINAL_DA_CARAIA:

		li a7, 10
		ecall

SWAP:	add	a4, t0, zero					# a4     =  V[]
		lw	t4, (a4)						# t4     =  V[n]
		lw	t5, 4(a4) 						# t5     =  V[n+1]
		sw	t5, (a4)						# V[n]   =  t5
		sw	t4, 4(a4)						# V[n+1] =  t4
		li	a0, 1 
		 j	CHK_SWAP 	 
		
FLAG:	li	s3, 1				#Changing Satuts flag to keep inside while
		li  a0, 0				#Creating conditions to a0 one day keep as zero 
		 j	For_i	
		
	
		
		
		
