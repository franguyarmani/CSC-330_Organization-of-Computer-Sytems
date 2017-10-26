;
; Created: 10/24/2017 3:19:04 PM
; Author : Francis Peabody
;


; Replace with your application code
;---------------------Pre-setup section----------------------
.cseg	
.def				io_setup	= r16
.def				leds_d		= r17
.def				leds_b		= r18
.org				0x0000
rjmp				setup
.org				0x0100

;-----------------------Setup section------------------------
setup:
; one-time actions go here

					ldi		io_setup,	0xFF	
					
					ldi		leds_d,		0x00
					ldi		leds_b,		0x00
					out		DDRB,		io_setup
					out		DDRD,		io_setup

;------------------------Loop section------------------------
loop:
					inc		leds_d
					out		PORTD,	leds_d
					


					breq	carry
					rcall	delay_10ms
					rjmp	loop

carry:
					inc		leds_b
					out		PORTB,	leds_b
					rcall	delay_10ms
					rjmp	loop
	

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