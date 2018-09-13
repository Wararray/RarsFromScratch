# "Basic I/O keyboard" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

# Basic programming layout for input and output from keyboard

.data
D_HELLO:	.string "Hello, how can I help you? \nType here:  "
D_READY: 		.string	"Ready for Next entry:\n Type here:  "

.text
_start: 						#LABEL to mark _start procedure
	li		a7,4				#Prepare a7 as argument to call Print String Service
	la		t0,D_HELLO		    #Get Adress of the message set in .data
	add		a0,t0,zero		    #String to be printed
	ecall						#Call the System Function (Service)
	
_read:
	li		a7,8				#Prepare a7 as argument to call Read String Service
	li		a1,100				#Maximum number of characters from console
	ecall
	
	# Print Service
	li		a7,4
	ecall
	
	# Say that it ready for next entry:
	li		a7,4
	la		a0,D_READY
	ecall
	
	la		a0,D_READY
	j		_read
	
	
	li		a7,10				#Exit service
	ecall						#Call the System Function (Service)
