/******************************************************************************
* File: ascii_to_hex.s
* Author: ARUN A. M.
* Roll number: CS18M510
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Lab 5: Convert Given ASCII digit to Hexadecimal.
  */


	@ BSS Section
      .bss

    @DATA Section

.data

A_DIGIT: .word 0x43	
H_DIGIT: .word 0x00


	@TEXT Section

.text
.global main

main:
	
	LDR r1, =A_DIGIT
	
	LDR r2, [r1]

	@Check if  its a number 0-9 (0x30-0x39)
	CMP r2, #0x30
	BLT INVALID
	CMP r2, #0x39
	BGT CHECK_SMALLALPHA

	@Get the number
	AND r2, r2, #0x0F
	B SAVE

CHECK_SMALLALPHA:
	@Check if its a Large alphabets A-F (0x41-0x46)
	CMP r2, #0x41 
	BLT INVALID
	CMP r2, #0x46 
	BGT CHECK_LARGEALPHA

	@Get the alphabets
	ADD r2, r2, #0x09
	AND r2, r2, #0x0F
	B SAVE

CHECK_LARGEALPHA:
	@Check if its a small alphabets a-f (0x61-0x66)
	CMP r2, #0x61 
	BLT INVALID
	CMP r2, #0x66 
	BGT INVALID

	@Get the alphabets
	ADD r2, r2, #0x09
	AND r2, r2, #0x0F
	B SAVE

INVALID:
	MOV r2, #0xFF

SAVE:
	LDR r1, =H_DIGIT
	STR r2, [r1]
	SWI 0x11

