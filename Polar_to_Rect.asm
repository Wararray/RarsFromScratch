# "Convert Polar Coordinates to Rectangular Coorditanates" Program: RISC-V Implementation
# Study based on:
## Patterson and Hennessy,     5th Edition (RISC-V)
## Professor PhD. LAMAR,M.V.,  class notes
## Contact: dias.unb@gmail.com

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                         #
# Sin(Thetha) = SUM: [ [( -1 )^N] / 2*N + 1] * Theta^(2N + 1);            #
# Sin² + Cos² = 1;                                                        #
# x = radius*cos(theta);                                                  #
# y = radius*sin(theta);                                                  #
# Hypotheses: 															  #
#				fa0 = (N) = 10                                            #
#				fa1	= (theta)                                             #
#				fa2 = (radius)											  #
#               fs8 =  X   (return)                                       #
#               fs9 =  Y   (return)                                       #
#                                                                         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

_INIT_POLAR_RET:
		    # Hypothesis and Inputs
		    addi	a0, zero,  10   				# Simulating get N without memory access
			addi	a1, zero,  45					# Simulating get thetha without memory access
			addi	a2,	zero,  2					# Simulating get radius without memory access
			# # # # # # # # # # # #
		
			#Variables and SP management
			addi	sp,     sp, -12					# Can Store: 3 variables
			 fsw	fa0,  8(sp)						# 3rd variable to be stored: fa0
			 fsw	fa1,  4(sp)						# 2nd variable to be stored: fa1
			 fsw	fa2,  0(sp)			     		# 1st variable to be stored: fa2
			# # # # # # # # # # # # # # #		
		
			fcvt.s.w	fa0, a0							# fa0 is charged to be passed as N argument
			fcvt.s.w	fa1, a1							# fa1 is charged to be passed as thetha argument
			fcvt.s.w	fa2, a2							# fa2 is charged to be passed as radius argument
		    call	    _INIT_SIN_THETHA 
			call		_INIT_CALC_Y
			call		_INIT_COS_THETHA
            call		_INIT_CALC_X
_END_POLAR_RET:
			
				#Bye-Bye
				addi	a7, zero, 10
				ecall
			
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                         #
#                             Procedures                                  #
#                                                                         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

_INIT_CALC_X:
			#Variables and SP management
			addi	 sp,     sp, -4					    #  Can Store: 1 variable
			sw	 	 t0,    0(sp)						#  1st variabçe to be stored: t0
			
			li		 t0, 1
			fcvt.s.w fs8, t0
			fmul.s	 fs8, fs8, fa0						# fs8 <= 1*cos() After _INIT_COS_THETHA, fa0 stores cos(thetha) value
			fmul.s	 fs8, fs8, fa2						# fs8 <= cos() * radius

_END_CALC_X:			
			#Variables and SP management
			lw	 	 t0,    0(sp)						# 1st variable to be restored: t0
			addi	 sp,     sp, 4					    # Restore: 1 variable	| 4 bytes of memory		
			ret 										# There is no need to stores in fa0, as is asked to return X in fs8



_INIT_CALC_Y:
			#Variables and SP management
			addi	 sp,     sp, -4					    #  Can Store: 1 variable
			sw	 	 t0,    0(sp)						#  1st variabçe to be stored: t0
			
			li		 t0, 1
			fcvt.s.w fs9, t0
			fmul.s	 fs9, fs9, fa0						# fs9 <= 1*sin() After _INIT_SIN_THETHA, fa0 stores sin(thetha) value
			fmul.s	 fs9, fs9, fa2						# fs9 <= sin() * radius

_END_CALC_Y:			
			#Variables and SP management
			lw	 	 t0,   0(sp)						# 1st variable to be restored: t0
			addi	 sp,     sp, 4					    # Restore: 1 variable	| 4 bytes of memory		
			ret 										# There is no need to stores in fa0, as is asked to return Y in fs9



_INIT_COS_THETHA:				   
			#Variables and SP management
			addi	 sp,     sp, -12					#  Can Store: 3 variables
			sw	 	t0,    8(sp)						#  4th variabçe to be stored: t0
#			fsw	 	fa0,   4(sp)						#  3rd variable to be stored: fa0
			fsw	 	ft0,   0(sp)			     		#  1st variable to be stored: ft0
			# # # # # # # # # # # # # # #
		
			# Pre set for calculus
			addi		t0, zero, 1
			fcvt.s.w	ft0,t0							# "1" of the formula
			
			# Calculating termns		
			fmul.s		fa0, fa0, fa0					# fa0 <= sin²()
			fsub.s		fa0, ft0, fa0					# fa0 <= cos²() = 1 - sin²()
			fsqrt.s		fa0, fa0						# fa0 <= sqrt(cos²()
_END_COS_THETHA:
			ret


_INIT_SIN_THETHA:		
			#Variables and SP management
			addi	 sp,     sp, -48					# Can Store: 11 variables
			fsw 	fa2,  44(sp)						# 12th variable to be stored: fa2
			fsw 	fs1,  40(sp)						# 11th variable to be stored: fs1
			fsw 	fs0,  36(sp)						# 10th variable to be stored: fs0
			fsw 	ft6,  32(sp)						#  9th variable to be stored: ft6
			fsw 	ft5,  28(sp)						#  8th variable to be stored: ft5
			fsw 	ft4,  24(sp)						#  7th variable to be stored: ft4
			fsw		ft2,  20(sp)						#  6th variable to be stored: ft2
			fsw		ft1,  16(sp)			     		#  5th variable to be stored: ft1
			sw	 	t0,   12(sp)						#  4th variabçe to be stored: t0
#			fsw	 	fa0,   8(sp)						#  3rd variable to be stored: fa0
			fsw	 	fa1,   4(sp)						#  2nd variable to be stored: fa1
			fsw	 	ft0,   0(sp)			     		#  1st variable to be stored: ft0
			# # # # # # # # # # # # # # #

			#Prepare to enter loop:
            addi    	t0,	zero, 2
	   		fcvt.s.w    ft2, t0							# store result of (2N + 1)
			addi    	t0,	zero, 1
	   		fcvt.s.w    ft0, t0							# Control flag that will reach N	
	   		fcvt.s.w    ft1, t0							# Fixed pass to increment
			fcvt.s.w    ft4, t0							# store parcial result: Pow
			fcvt.s.w    ft5, t0							# store parcial result: Factorial
			fcvt.s.w    ft6, t0							# store parcial result: Numerator
			fcvt.s.w	fs0, t0							# store parcial result: ALMOST_FINAL VALUE
			addi    	t0,	zero, 0
			fcvt.s.w	fs1, t0							# store parcial result: NOW_IS_THE_FINAL VALUE
			addi    	t0,	zero, -1
			fcvt.s.w	fa2, t0							# NUMERATOR CONSTANT. UNFURTUNELLY, BY DESTINY, WE MUST USE fa2 #Sorry
						
init_loop1: # Loop gets SUM until reaches N
			fle.s 		t0, ft0, fa0					# When ft0 equal or greater
			beq			t0, zero, end_loop1				# it breaks to end_loop1
			
			#calculate (2*N + 1)
			fmul.s		ft2, ft2, ft0					# 2 * N
			fadd.s		ft2, ft2, ft1					# 2 + 1						
			
			# Init set to enter Loop_Pow
			addi    	t0,	zero, 1
			fcvt.s.w	ft3, t0							# Flago to control loops of ! and pow( )
         Loop_Pow:# Initi calculus of pow(theta) 
 				  fle.s		t0, ft3, ft2				# When ft3 equals or greater
 				  beq		t0, zero, endL_Pow      	# it breaks the loop
 				  
 				  fmul.s	ft4, ft4, fa1				# Result = Result * Theta
 				  
 				  #increment
 				  fadd.s	ft3, ft3, ft1				# ft3 = ft3 + 1
 				  j			Loop_Pow
        endL_Pow:
        	
        	# Init set to enter Loop_fcatorial
        	addi    	t0,	zero, 1
			fcvt.s.w	ft3, t0							# Flag to control loops of ! and pow( )
			fmul.s		ft5, ft3, ft2					# Resultado = 1 * Maior_valor_da_Sequencia # This is not sure to reader
  loop_factorial: # Initi calculus of fatorial 
 				  flt.s		t0, ft3, ft2				# When ft3 equals 
 				  beq		t0, zero, endL_factorial	# it breaks the loop
 				  
 				  fmul.s	ft5, ft5, ft3				# Result = Result * Increment
 				  
 				  #increment
 				  fadd.s	ft3, ft3, ft1				# ft3 = ft3 + 1
 				  j			loop_factorial
  endL_factorial:
  
            # Init set to enter Loop_Num: It calculates the numerator (-1)^N
			addi    	t0,	zero, 1
			fcvt.s.w	ft3, t0							# Flago to control loops of ! and pow( )
         Loop_Num:# Initi calculus of pow(theta) 
 				  fle.s		t0, ft3, ft2				# When ft3 equals or greater
 				  beq		t0, zero, endL_Num      	# it breaks the loop
 				  
 				  fmul.s	ft6, ft6, fa2				# [in first call em N=1]:>  1 = 1*(-1) 
 				  
 				  #increment
 				  fadd.s	ft3, ft3, ft1				# ft3 = ft3 + 1
 				  j			Loop_Num
        endL_Num:         
 			
 			# Calculates Partial Value. fs0: Sum or add depending of its actual value (thanks, -1^n)
 			fmul.s   fs0, fs0, ft6					# answer = answer * Numerator
 			fmul.s	 fs0, fs0, ft4					# answer = answer * Thetha  
 			fdiv.s   fs0, fs0, ft5					# answer = answer / Denominator
 			
 			fadd.s	 fs1, fs1, fs0					# THE FUNCKING FINAL MOTHERFUCKER VALUE
 			
 			#increment
 			fadd.s   ft0, ft0, ft1					# ft0 = ft0 + 1;
 			addi     t0, zero, 2
	   		fcvt.s.w ft2, t0						# Refresh to new store result of (2N + 1)
	   		addi     t0, zero, 1
	   		fcvt.s.w fs0, t0						# Refresh to new store result of: ALMOST_FINAL VALUE
	   		fcvt.s.w ft4, t0						# Refresh to new store result of: Pow
			fcvt.s.w ft5, t0						# Refresh to new store result of: Factorial
			fcvt.s.w ft6, t0						# Refresh to new store result of: Numerator
 			j        init_loop1  
end_loop1:  
			addi     t0, zero, 1
			fcvt.s.w fa0, t0						# Prepare fa0 to receive return value (as it should be: in fa0)
			fmul.s	 fa0, fa0, fs1					# Upload done in fa0
  
   			# FREE Variables and SP management

			fsw 	fa2,  44(sp)						# 12th variable to be stored: fa2
			flw 	fs1,  40(sp)						# 11th variable to be restored: fs1
			flw 	fs0,  36(sp)						# 10th variable to be restored: fs0
			flw 	ft6,  32(sp)						#  9th variable to be restored: ft6
			flw 	ft5,  28(sp)						#  8th variable to be restored: ft5
			flw 	ft4,  24(sp)						#  7th variable to be restored: ft4
			flw		ft2,  20(sp)						#  6th variable to be restored: ft2
			flw		ft1,  16(sp)			     		#  5th variable to be restored: ft1
			lw	 	t0,   12(sp)						#  4th variabçe to be restored: t0
			#flw	 	fa0,   8(sp)						#  3rd variable to be restored: fa0
			flw	 	fa1,   4(sp)						#  2nd variable to be restored: fa1
			flw	 	ft0,   0(sp)			     		#  1st variable to be restored: ft0
			
			addi	 sp,     sp, 48					    # FREE: 11 variables; 44bytes of Memory
			# # # # # # # # # # # # # # #
			#Bye-Bye
			ret
