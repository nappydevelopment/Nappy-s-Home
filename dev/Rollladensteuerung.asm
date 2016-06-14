;----------------------------------
; Nappy's Home
;----------------------------------
CSEG AT 0H
LJMP Rollladenstart
ORG 100H

; Eingabe
SR1Oben		EQU	P0.0
SR1Unten	EQU	P0.1
SR1Hoch		EQU	P0.2
SR1Runter	EQU	P0.3
SR2Oben		EQU	P0.4
SR2Unten	EQU	P0.5
SR2Hoch		EQU	P0.6
SR2Runter	EQU	P0.7

SRHell		EQU	P2.6
SRAutoModus	EQU	P2.7

; Ausgabe
MR1Hoch		EQU	P3.0
MR1Runter	EQU	P3.1
MR2Hoch		EQU	P3.2
MR2Runter	EQU	P3.3

;Logik

RollladenStart: JNB SRAutomodus, R1AutomodusHoch
R1Hoch:		MOV C, SR1Oben
		ANL C, /SR1Hoch
		ANL C, SR1Runter
		CPL C
		MOV MR1Hoch, C
		
R2Hoch:		MOV C, SR2Oben
		ANL C, /SR2Hoch
		ANL C, SR2RUNTER
		CPL C
		MOV MR2Hoch, C

R1Runter:	MOV C, SR1Unten
		ANL C, /SR1Runter
		ANL C, SR1Hoch
		CPL C
		MOV MR1Runter, C

R2Runter:	MOV C, SR2Unten
		ANL C, /SR2Runter
		ANL C, SR2Hoch
		CPL C
		MOV MR2Runter, C
		LJMP Rollladenstart

R1AutomodusHoch:	MOV C, SR1Oben
			ANL C, /SRHell
			CPL C
			MOV MR1Hoch, C
			
R2AutomodusHoch:	MOV C, SR2Oben
			ANL C, /SRHell
			CPL C
			MOV MR2Hoch, C
			
R1AutomodusRunter:	MOV C, SR1Unten
			ANL C, SRHell
			CPL C
			MOV MR1Runter, C
			
R2AutomodusRunter:	MOV C, SR2Unten
			ANL C, SRHell
			CPL C
			MOV MR2Runter, C
			LJMP Rollladenstart
			