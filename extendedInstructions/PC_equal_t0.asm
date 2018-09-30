# "Extended Instructions Series" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

# Pseudo: jr   t0    Must return:    PC = t0


	la		t0, LABEL			# Suppose an address to t0
	
	jalr	zero, t0, 0			# Pseudo

	LABEL:						# Suppose an address to t0