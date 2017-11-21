;
; Week12LabA.asm
;
; Created: 11/14/2017 2:53:51 PM
; Author : Pol Ajazi, Francis Peabody
;

/* 1. Using all the knowledge and skills you’ve acquired thus far this semester, design, 
 build, code, and test a device which will accomplish the same tasks as last lab - this time utilizing Timer0 in overflow interrupt mode. */
 
 

.def			io_setup	= r16						; used to set up pins as inputs or outputs
.def			workhorse	= r17						; general-purpose register
.cseg													; start of code segment
.org			0x0000									; reset vector
				rjmp		setup						; jump over interrupt vectors
.org			0x0020
				rjmp		wait_t0_overflow
.org			0x0100									; start of non-reserved program memory

setup:			ser			io_setup					; set all bits in register
				out			DDRD, io_setup				; use all pins in PORTD as outputs

				ldi			workhorse, 0b00000000		; Timer0, normal mode
				out			TCCR0A, workhorse
					
														; ADD FUNCTIONALITY HERE:
				ldi			workhorse, 0b00000101		; 0b100 for presacler of 256, 0b101 for 1024
				out			TCCR0B, workhorse			; [1] configure TCCR0B to:
														; [a] not worry about force output compare
														;		[b] use a prescaler of 1024

				ldi			workhorse, 0b00000001
				sts			TIMSK0, workhorse	

				sei							
				 
loop:			rjmp		loop

wait_t0_overflow:			
				in			r25, sreg			
									
				sbi			PIND, 0		
						
				//sbi			TIFR0, TOV0 

				out			sreg, r25
				reti

*/
/* Change the code again to utilize OCR0A as an an interrupt, and initialize the Clear Timer on Compare Match mode. 
Use this setup to create a square wave of 1kHz. Check your wave form, and submit this code and a 
screenshot of your wave (with a measurement tab on it showing its frequency) as your lab writeup. */

/* */

.def			io_setup	= r16						; used to set up pins as inputs or outputs
.def			workhorse	= r17						; general-purpose register
.cseg													; start of code segment
.org			0x0000									; reset vector
				rjmp		setup						; jump over interrupt vectors
.org			0x001C
				rjmp		wait_t0_overflow
.org			0x0100									; start of non-reserved program memory

setup:			ser			io_setup					; set all bits in register
				out			DDRD, io_setup				; use all pins in PORTD as outputs

				//ldi			workhorse, 140
				//out			TCNT0, workhorse

				ldi			workhorse, 0b00000010		; Timer0, normal mode
				out			TCCR0A, workhorse
					
														; ADD FUNCTIONALITY HERE:
				ldi			workhorse, 0b00000011		; 0b100 for presacler of 256, 0b101 for 1024
				out			TCCR0B, workhorse			;	[1] configure TCCR0B to:

			
				ldi			workhorse, 0b00000010
				sts			TIMSK0, workhorse

				ldi			workhorse, 0b01111100										
				out			OCR0A, workhorse
				
				sei							
				 
loop:			
				
				rjmp		loop

wait_t0_overflow:			
				in			r25, sreg			
									
				sbi			PIND, 0		
				
				//sbi		TIFR0, TOV0 

				out			sreg, r25
				reti