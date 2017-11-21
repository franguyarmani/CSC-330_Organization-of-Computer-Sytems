;
; ADC_UsingInterrupts.asm
;
; Created: 11/15/2017 11:34:25 AM
; Author : fbpea
;


.cseg													; start of code segment
.def			io_set			= r16					; used to set up the outputs on ports B and D
.def			workhorse		= r17					; multi-purpose register used to move bytes to/from ADCSRA and ADMUX
.def			adc_value_low	= r18					; used to manipulate the low byte of the result of the ADC conversion
.def			adc_value_high	= r19					; used to manipulate the high byte of the result of the ADC conversion
.org			0x0000									; begin storing program at location 0x0100
				rjmp		setup
.org			0x002A
				rjmp		show						; 
.org			0x0100
; ---------------- setup sequence ----------------
setup:			ldi			io_set, 0xFF				; load all 1s into io_set
				out			DDRB, io_set				; use io_set to set all pins in ports B and D to outputs
				out			DDRD, io_set
														; use workhorse to store values into ADMUX by:
				ldi			workhorse, 0b01000010		;	[1] using ADC2 (MUX3 through MUX0)
				sts			ADMUX, workhorse			;	[2] using the voltage ref of AVCC (REFS1 and REFS0)
				sei

; ---------------- loop sequence -----------------
	loop:													; ADD THE FOLLOWING FUNCTIONALITY HERE:
				out			PORTD,	adc_value_low		;	use workhorse to store values into ADCSRA by:
				out			PORTB,	adc_value_high			;		[1] enabling the ADC (ADEN)
				rjmp		loop						;		[2] starting the conversion (ADSC)
														;		[3] using a prescalar of 128 (ADPS	1 and ADPS0)

	
	; -------------- Interrupt --------------
	show:												; ADD THE FOLLOWING FUNCTIONALITY HERE:
				lds			adc_value_low, ADCL			;	load the ADCed values into general purpose registers:
				lds			adc_value_high, ADCH		;		[1] ADCL into adc_value_low
				ldi			workhorse, 0b11101111										;		[2] ADCH into adc_value_high
				sts			ADCSRA,	workhorse										; 	output the values to their respective ports
				reti
