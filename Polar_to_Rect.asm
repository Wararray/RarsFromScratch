# "Calculate the x^(2*y+1) power" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

# Hypotheses: 
#				  N	= 10
#				fa0	= (radius)
#				fa1 = (thetha)

_INIT_POLAR_RET:
		    # Hypothesis and Inputs
		    addi	a0, zero,  5					# Simulating get radius without memory access
			addi	a1, zero,  5					# Simulating get thetha without memory access
			addi	a2,	zero,  10					# This is N value
			# # # # # # # # # # # #
		
			#Variables and SP management
			addi	sp,     sp, -12					# Can Store: 3 variables
			 fsw	fa0,  8(sp)						# 3rd variable to be stored: fa0
			 fsw	fa1,  4(sp)						# 2nd variable to be stored: fa1
			 fsw	fa2,  0(sp)			     		# 1st variable to be stored: fa2
			# # # # # # # # # # # # # # #		
		
			fcvt.s.w	fa0, a0							# fa0 is charged to be passed as radius argument
			fcvt.s.w	fa1, a1							# fa1 is charged to be passed as thetha argument
			fcvt.s.w	fa2, a2							# fa2 is charged to be passed as N argument
		    call	    INIT_SIN_THETHA 

_END_POLAR_RET:
			
				#Bye-Bye
				addi	a7, zero, 10
				ecall
			
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                         #
#                             Procedures                                  #
#                                                                         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

INIT_SIN_THETHA:
			#Variables and SP management
#			addi	sp,     sp, -4					# Can Store: 1 variable1
#			  sw	t0,  0(sp)			     		# 1st variable to be stored: t0
			# # # # # # # # # # # # # # #		

	        call	INIT_CALC_THETHA
#	        addi    t0,	zero, 1						# t0 gets 1
	      fadd.s	fs0, fs0, fa0					# fs0 = Thetha        #REMBER TO SAVE PREVEUS STATUS OF fs0 #########!!!!!!!!
#	    fcvt.s.w	
			call	INIT_CALC_DENM					#Calls procedure to calculate the Denominator
		  
			call	_END_POLAR_RET
			#ret
END_SIN_THETHA:


INIT_CALC_DENM: #Gets fa2, the N argument
				#Variables and SP management
 				addi	 sp,    sp, -12					# Can Store: 1 variable1
 			  	 fsw	ft0,  8(sp)		     	    	# 3rd variable to be stored: ft0
 			  	  sw     t0,  4(sp)						# 2nd variable to be stored: t0
 			  	 fsw	fa2,  0(sp)		     	    	# 1st variable to be stored: fa2
				# # # # # # # # # # # # # # #	
		
				addi	t0, zero, 2
			fcvt.s.w	ft0, t0
			  fmul.s    fa2, fa2, ft0

				addi	t0, zero, 1
			fcvt.s.w	ft0, t0
			  fadd.s    fa2, fa2, ft0

END_CALC_DENM:



INIT_CALC_THETHA:
			#Variables and SP management
			addi	sp,     sp, -20					# Can Store: 5 variables
			 fsw	fa2, 16(sp)						# 5th variable to be stored: fa2
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
			 flw	fa2, 16(sp)						# 5th variable to be stored: fa2
		     flw	ft2, 12(sp)						# 4th variable to be recovered: ft2
		     flw	ft1,  8(sp)						# 3rd variable to be recovered: ft1
		      lw	t0,   4(sp)						# 2nd variable to be recovered: t0
		     flw	ft0,  0(sp)						# 1st variable to be recovered: ft0
		    addi	sp,     sp, 16				    # Giving back the space of 4 variables	        
			 ret
END_CALC_THETHA: