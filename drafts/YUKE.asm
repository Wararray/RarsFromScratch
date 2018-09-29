# Number to Calculate
li 			t0, -1
fcvt.s.w	fs0, t0

li 			t0, 1
fcvt.s.w	ft0, t0		# Store the result: Result = Result * thetha
fcvt.s.w	ft1, t0     # Incrementer
fcvt.s.w	ft2, t0		# Fixed Pass

# Stop Control ft. Power()
li			t0, 16
fcvt.s.w	ft3, t0
				  
init_loop1: #Compare the loop control (ft1) with set power (fa2)
		   fle.s	t0,  ft1, ft3
		     beq    t0,  zero, end_loop1			
		  fmul.s	ft0, ft0, fs0					# Result = Result * thetha
		  fadd.s 	ft1, ft1, ft2					# increment ft1 in 1 unit
		  	   j	init_loop1
end_loop1: