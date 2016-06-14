;----------------------------------
; Nappy's Home
;----------------------------------
CSEG AT 0H
LJMP LICHT
ORG 100H


LICHT:
	MOV C, P1.0
	ANL C, P1.1
	JNC LICHT_AUS
	JMP LICHT_AN
	
LICHT_AN:
	CLR P3.5
	JMP LICHT
	
LICHT_AUS:
	SETB P3.5
	JMP LICHT
	