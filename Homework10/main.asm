;
; Homework10.asm
;
; Created: 11/8/2017 11:41:18 AM
; Author : fbpea
;
;Question 2

.def	element	= r14
.def	minVal	= r15
.def	maxVal	= r16
.def	count	= r17
.def	lpcnt	= r18

.

.cseg
.org	0x0100

array:	.db		0x08, 0x02, 0x03, 0x04


setup:	lds		count,	4
		ldi		lpcnt,	0
		ldi		ZL,		low(array) 
		ldi		ZH,		high(array) 
		LPM		element, Z+
		mov		minVal, element
		mov		maxVal, element	

loop:	LPM		element, Z+
		cp		maxVal,	element
		brcc	check_min
		mov		maxVal, element
		rjmp	cont

check_min:	BCLR	SREG_C
			cp		maxVal,	element
			brcs	cont
			mov		minVal, element 
			rjmp	cont

cont:		inc		lpcnt
			cp		lpcnt, count
			breq	div
			rjmp	loop

div:		BCLR	SREG_C
			ADD		minVal, MaxVal
			ROR		minVal
			rjmp	done

done:	nop


		
		