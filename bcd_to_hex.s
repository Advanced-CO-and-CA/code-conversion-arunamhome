/******************************************************************************
* File: bcd_to_hex.s
* Author: ARUN A. M.
* Roll number: CS18M510
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Lab 5: Convert  a  given  eight-digit  packed  binary-coded-decimal  number  
  in  the BCDNUM variable into a 32-bit number in a NUMBER variable..
  */


	@ BSS Section
      .bss

    @DATA Section

.data

BCDNUM: .word 0x92529679
NUMBER: .word 0x00



	@TEXT Section

.text
.global main

main:
	
	LDR r1, =BCDNUM
	LDR r2, [r1]
	MOV r3, #0
	MOV r4, #0
	MOV r6, #10		@Set the Multiplier as 10
	MOV r7, #0

@Convert BCD into HEX digit by digit
HEX:
	ADD r7, r7, r3		@Add the previous result to get the current number
	CMP r4, #8			@Check for 8 digit counter
	BEQ DONE
	AND r3, r2, #0xF	@Get the Least significant digit
	ADD r4, r4, #1		@Increment the counter 
	MOV r5, r4			@Save the counter to multiplication
	LSR r2, #4			@Shift right the input number by one digit to get the next digit

@Loop for multiplication based on the decimal place(r5) for each digit
LOOP:
	CMP r5, #1		@check if we have come to last decimal place and return to HEX for adding the result if done
	BEQ HEX
	MUL r3, r3, r6	@Multiply by 10 to the digit
	SUB r5, r5, #1	@Decrement the counter for the decimal places
	B LOOP 			@Loop until the multiplication for the decimal places is done

@Save the hexadecimal number in r7 to NUMBER 
DONE:
	LDR r1, =NUMBER
	STR r7, [r1]
	SWI 0x11

