;
; BouananePeabody_Assembly-Maths.asm
;
; Created: 10/27/2017 3:12:46 PM
; 
;


; Replace with your application code


;-----------------pre-setup----------

.cseg
.def			full =		r16
.def			temp =		r17
.def			num_a =		r18
.def			num_b =		r19
.def			result =	r20
.org			0x0000
rjmp			setup
.org			0x0100


;------------------Setup-------------
setup:
			ldi		full,	0xFF
			ldi		temp,	0x00
			ldi		result, 0x00

			out		DDRB,	full

			out		DDRD,	temp
			out		PORTD,	full

			


;-------------------loop---------------

loop:
			in		num_a,	PIND
			mov		num_b, num_a
			swap	num_a
			andi	num_b, 0b00001111
			andi	num_a, 0b00001111
			ldi		result,	0x00

			rcall	subrout_mulshift

			out		PORTB,		result
			rjmp	loop
				
			



;----------------Subroutines--------------

subrout_add:		add		num_a,	num_b
					mov		result,	num_a
					ret		

subrout_sub:		sub		num_a,	num_b
					mov		result,	num_a
					ret	




subrout_subinv:		eor		num_b,	full
					inc		num_b
					add		num_a,	num_b
					mov		result, num_a
					ret

subrout_mul:		mul		num_a,	num_b
					mov		result,	num_a
					ret

subrout_mulshift:	cpi		num_b,	0x00
					breq	end
					mov		temp,	num_b
					andi	temp,	0x01
					cpi		temp,	0x01
					brne	shift
					add		result,	num_a
shift:				lsl		num_a
					lsr		num_b
					rjmp	subrout_mulshift
end:				nop
					ret
					

