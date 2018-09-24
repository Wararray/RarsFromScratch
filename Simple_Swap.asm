# "Swap" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com


.data

D_VECTOR:	.word	9,2,5,1,8,2,4,3,6,7		#Vector 

.text
		
SWAP:	slli	t0, a1, 2				#K*4
		add		t0, t0, a0				#V[k]
		flw		ft0, 0(t0)
		flw		ft1, 4(t0)
		fsw		ft0, 4(t0)
		fsw		ft1, 0(t0)
		ret
		
		
		lw	t0, (a2)						# t0     =  V[n]
		lw	t1, 4(a2) 						# t1     =  V[n+1]
		sw	t1, (a2)						# V[n]   =  t1
		sw	t0, 4(a2)						# V[n+1] =  t0
		ret 