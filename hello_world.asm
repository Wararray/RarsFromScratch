# "Hello, World!" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

.data
D_HELLO:	.string	"Hello, World!"			#D_HELLO it's a LABEL to the string "Hello, World!"

.text
_start: 						#LABEL to mark _start procedure
	li		a7,4				#Prepare a7 as argument to call Print String Service
	la		t0,D_HELLO		    #Get Adress of the message set in .data
	add		a0,t0,zero		    #String to be printed
	ecall						#Call the System Function (Service)
	
	li		a7,10				#Exit service
	ecall						#Call the System Function (Service)