# "Odd or Even?" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

		and			t0, t1, t2
		
		
		li			t0, 100
		fcvt.s.w	ft0, t0
		li			t0, 1
		fcvt.s.w	ft1, t0
		fcvt.s.w	ft2, t0
		
						
loop:	fle.s		t0, ft1, ft0
   		beq			t0, zero, BYE
		
		fdiv.s		ft3, ft0, ft1
		
		fadd.s		ft1, ft1, ft2
		j			loop
		
		
		

BYE:
	li a7, 10
	ecall