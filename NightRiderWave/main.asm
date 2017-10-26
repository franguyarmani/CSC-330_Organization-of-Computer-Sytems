;
; Created: 10/25/2017 6:38 PM
; Author : Francis Peabody
;


; Replace with your application code
;---------------------Pre-setup section----------------------
.cseg	


.def				leds_d		= r17
.def				leds_b		= r18
.def				left		= r19
.def				right		= r23
.def				io_setupD	= r24
.def				io_setupB	= r25
.def				off			= r26
.org				0x0000
rjmp				setup
.org				0x0100

;-----------------------Setup section------------------------
setup:
; one-time actions go here
					ldi		off,		0x00
					ldi		io_setupD,	0xFF
					ldi		io_setupB,	0x03	
					ldi		left,		0x80
					ldi		right,		0x01		
					
					ldi		leds_d,		0x01
					ldi		leds_b,		0x01
					out		DDRB,		io_setupB
					out		DDRD,		io_setupD

;------------------------Loop section------------------------

;Dear Grader,
;This is the ten bit wave, for extra credit. The eight bit variant 
;can be achieved by replacing 'carry' with 'loop2' in the loop1 code. 
loop1:
					LSL		leds_d
					out		PORTD,		leds_d
					rcall	delay_100ms
					
					cp		leds_d,		left
					breq	carry
					;breq	loop2     <== substitute this for the line above to achieve the 8bit wave
					rjmp	loop1
					

carry:
					out		PORTD,		off
					mov		leds_d,		left
					out		PORTB,		leds_b
					rcall	delay_100ms
					LSL		leds_b
					out		PORTB,		leds_b
					rcall	delay_100ms
					LSR		leds_b	
					out		PORTB,		leds_b
					rcall	delay_100ms
					out		PORTB,		off
					out		PORTD,		leds_d
					
loop2:
					LSR		leds_d
					out		PORTD,		leds_d
					rcall	delay_100ms
					cp		leds_d,		right
					breq	loop1
					rjmp	loop2
			

;--------------------------1s delay--------------------------
delay_1s:			ldi		R20, 0x53
delay_1s_1:			ldi		R21, 0xFB
delay_1s_2:			ldi		R22, 0xFF
delay_1s_3:			dec		R22
					brne	delay_1s_3
					dec		R21
					brne	delay_1s_2
					dec		R20
					brne	delay_1s_1
					ldi		R20, 0x02
delay_1s_4:			dec		R20
					brne	delay_1s_4
					nop
					ret

;------------------------100ms delay-------------------------
delay_100ms:		ldi		r20, 9
					ldi		r21, 30
					ldi		r22, 229
delay_100ms_1:		dec		r22
					brne	delay_100ms_1
					dec		r21
					brne	delay_100ms_1
					dec		r20
					brne	delay_100ms_1
					ret
;------------------------10ms delay--------------------------
delay_10ms:			ldi		r20, 208
					ldi		r21, 202
delay_10ms_1:		dec		r21
					brne	delay_10ms_1
					dec		r20
					brne	delay_10ms_1
					ret