# "Calculate the x^(2*y+1) power" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

# Hypotheses: 
#				  N	= 10
#				fa0	= (radius)
#				fa1 = (thetha)

_Start:
		    addi	t0, zero,  5					# Simulating get radius without memory access
			addi	t1, zero,  5					# Simulating get thetha without memory access
			addi	t2,	zero,  10					# This is N value
		fcvt.s.w	fa0, t0							# fa0 is charged to be passed as radius argument
		fcvt.s.w	fa1, t1							# fa1 is charged to be passed as thetha argument
		fcvt.s.w	fa2, t2							# fa2 is charged to be passed as N argument
		    call	_POWER 							
		
_END:		#Bye-Bye
			addi	a7, zero, 10
			ecall


_POWER:
			#Variables and SP management
			addi	sp,     sp, -16					# Can Store: 4 variables
			 fsw	ft2, 12(sp)						# 4th variable to be stored: ft2
			 fsw	ft1,  8(sp)						# 3rd variable to be stored: ft1
			  sw	t0,   4(sp)						# 2nd variable to be stored: t0
			 fsw	ft0,  0(sp)						# 1st variable to be stored: ft0
    	    ############################
			
	
		#Calculating the Power and storing in fa2	
			addi	t0, zero, 2						# (2) integer
		fcvt.s.w	ft0, t0							# (2) float			
		  fmul.s	fa2, fa2, ft0					# N*2
		  
		    addi	t0, zero, 1						# (1) integer
		fcvt.s.w	ft0, t0							# (1) float
		  fadd.s	fa2, fa2, ft0					# (N + 1)

		# Setting the flags and control of loop		  
		fcvt.s.w	ft0, t0							# init ft0 as one. It gonna store the (Thetha)^N
		fcvt.s.w	ft1, t0							# init ft1 as one. It gonna be the counter
		fcvt.s.w	ft2, t0							# init ft2 as one. It gonna be the decrementer pass
				  
init_loop: #Compare the loop control (ft1) with set power (fa2)
		   fle.s	t0,  ft1, fa2
		     beq    t0,  zero, end_loop			
		  fmul.s	ft0, ft0, fa1					# Result = Result * thetha
		  fadd.s 	ft1, ft1, ft2					# increment ft1 in 1 unit
		  	   j	init_loop
end_loop:

		  #Preparing to leave Procedure
		  fmul.s    fa0, ft0, ft2		   			#Storing spected values on right registers
		     flw	ft2, 12(sp)						# 4th variable to be recovered: ft2
		     flw	ft1,  8(sp)						# 3rd variable to be recovered: ft1
		      lw	t0,   4(sp)						# 2nd variable to be recovered: t0
		      lw	ft0,  0(sp)						# 1st variable to be recovered: ft0
		    addi	sp,     sp, 16				    # Giving back the space of 4 variables
		        
			   j	_END










