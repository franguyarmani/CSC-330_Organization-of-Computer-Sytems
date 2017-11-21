;
; Lab11B.asm
;
; Created: 11/10/2017 2:39:38 PM
; Author : fbpea
;


; Replace with your application code
;; CSC 330 Lab 11 B: Assembly - The hardware timer
; Author: 
; Date: 

.def			io_setup	= r16						; used to set up pins as inputs or outputs
.def			workhorse	= r17						; general-purpose register
.cseg													; start of code segment
.org			0x0000									; reset vector
				rjmp		setup						; jump over interrupt vectors
.org			0x0100									; start of non-reserved program memory

setup:			ser			io_setup					; set all bits in register
				out			DDRD, io_setup				; use all pins in PORTD as outputs

				ldi			workhorse, 0b00000000		; Timer0, normal mode
				out			TCCR0A, workhorse			
				ldi			workhorse, 0b00000100		; ADD FUNCTIONALITY HERE:
				out			TCCR0B,	workhorse			;	[1] configure TCCR0B to:
														;		[a] not worry about force output compare
														;		[b] use a prescaler of 1024

loop:			sbi			PIND, 1					; neat trick: when a pin is used as an output, writing a 1 to
				ldi			workhorse, 0b10111001		;	its corresponding PIN register toggles its output value!
				out			TCNT0, workhorse
				rcall		wait_t0_overflow
				rjmp		loop

wait_t0_overflow:										; ADD FUNCTIONALITY HERE:
				in			workhorse, TIFR0
				andi		workhorse, 0b00000001			;	[1] wait for the correct interrupt flag to be set
				breq		wait_t0_overflow				;	[2] then reset it
				sbi			TIFR0, TOV0
				ret