/******************************************************************************
* File: asciistring_to_bin.s
* Author: ARUN A. M.
* Roll number: CS18M510
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Lab 5: Convert Given ASCII String to 8bit Binary if its 1 or 0, otherwise output NUMBER=0 and ERROR=0xFF.
  */


	@ BSS Section
      .bss

    @DATA Section

.data

STRING: .word 0x31,0x31,0x30,0x31,0x30,0x30,0x31,0x30
NUMBER: .word 0x00
ERROR: .word 0x00


	@TEXT Section

.text
.global main

main:
	
	LDR r1, =STRING

	MOV r3, #0
	MOV r4, #0
	MOV r5, #0
	@Loop the list of 8 ascii characters
LOOP:
	CMP r3, #0x8		@Check if the count is 8
	BEQ SAVE 			@If count =8 save the output
	
	LDR r2, [r1]		@Load the string into r2
	
	@Check if its a binary 0(0x30) or 1(0x31) 	
	CMP r2, #0x30
	BLT SAVE_ERROR		@If not number then output error
	CMP r2, #0x31
	BGT SAVE_ERROR 		@If not binary number 0 or 1, output error
	
	LSL r4, #1			@Left shift the output to save the current bit
	AND r2, r2, #0x01	@Get the LSB which is the binary number 
	ORR r4, r4, r2		@OR the binary number to output to get the current
	ADD r3, r3, #0x1   	@Increment the counter
	ADD r1, r1, #4 		@Move to the next ascii char in the array
	B LOOP

@If found error, save the NUMBER in r4 as 0x00 and ERROR in r5 as 0xFF
SAVE_ERROR:
	MOV r4, #0x00
	MOV r5, #0xFF

@Store the final output to NUMBER and ERROR
SAVE:
	LDR r1, =NUMBER
	STR r4, [r1]
	LDR r1, =ERROR
	STR r5, [r1]
	SWI 0x11

