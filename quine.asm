;@author Oscar Uribe
;@author Juan Diego Torres
;@author Zuleimi Gonzales

;quine para arduino uno atmega 328p =)



.include "./m328Pdef.inc"

.def lector = r19
.def alto = r18
.def bajo = r17


;========================================

ldi ZH, $0000
ldi ZL, $0000

clr bajo
clr alto

;el numero maximo al que van a llegar
.def maximo  = r23
.def i = r20

ser maximo
clr i

;ciclo ===========================================================================================================
Ciclo:





	lpm lector, Z 

		EEPROM_write:
			; Wait for completion of previous write
			sbic EECR,EEPE
		rjmp EEPROM_write
	; Set up address (alto:bajo) in address register
	out EEARH, alto
	out EEARL, bajo
	; Write data (excretor) to Data Register
	out EEDR,lector
	; Write logical one to EEMPE
	sbi EECR,EEMPE
	; Start eeprom write by setting EEPE
	sbi EECR,EEPE
	
	inc ZL
	inc bajo

	inc i
	cp i,maximo
	brne Ciclo









 Start:
	rjmp Start
