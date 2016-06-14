;----------------------------------
; Nappy's Home
;----------------------------------
CSEG AT 0H
LJMP PROGRAMMSTART
ORG 100H

; Eingabe -------------------------
SR1Oben		EQU	P0.0
SR1Unten	EQU	P0.1
SR1Hoch		EQU	P0.2
SR1Runter	EQU	P0.3
SR2Oben		EQU	P0.4
SR2Unten	EQU	P0.5
SR2Hoch		EQU	P0.6
SR2Runter	EQU	P0.7

Bewegungssensor	EQU	P1.0
Lichtschalter	EQU	P1.1

MANUELL 	EQU 	P2.0
SENSOR 		EQU 	P2.1
TEMPARATURE 	EQU 	P2.2
SRHell		EQU	P2.6
SRAutoModus	EQU	P2.7

; Ausgabe -------------------------
MR1Hoch		EQU	P3.0
MR1Runter	EQU	P3.1
MR2Hoch		EQU	P3.2
MR2Runter	EQU	P3.3
MR3HEIZUNG 	EQU 	P3.4
MR4LICHT	EQU	P3.5

; Rolladen ------------------------
PROGRAMMSTART: JNB SRAutomodus, R1AutomodusHoch
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
		LJMP HEIZUNG

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

; Heizung -------------------------
HEIZUNG:
	MOV C, SENSOR
	CPL C
	ANL C, /TEMPARATURE
	ORL C, /MANUELL
	JNC HEIZUNG_AUS
	JMP HEIZUNG_AN

HEIZUNG_AUS:
	SETB MR3HEIZUNG
	JMP LICHT

HEIZUNG_AN:
	CLR MR3HEIZUNG

; Licht --------------------------
LICHT:
	MOV C, Bewegungssensor
	CPL C
	ANL C, /Lichtschalter
	JNC LICHT_AUS
	JMP LICHT_AN
	
LICHT_AN:
	CLR MR4LICHT
	JMP PROGRAMMSTART
	
LICHT_AUS:
	SETB MR4LICHT
	JMP PROGRAMMSTART
	