# "Procedure (PROC) and Simple Sum" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com


_START:	addi	a0, zero, 10		#Numbers to be add
		addi	a1, zero, 5
		call	SUM				    #Call PROC and stores the return value into a0
		add		s1, s1, a0
		j		BYE

SUM:	add		a0, a0, a1			#Get Function parameters (a0 and a1) and add them into return variable (a0)
		ret	

BYE:    #Good Bye and thanks for the Fishes!
		addi	a7, zero, 10   
		ecall		
		#####
