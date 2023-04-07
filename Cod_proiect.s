;Proiect masina de spalat 


;Hermenean Vlad-Costin
;Petrea Gabriel-Catalin
;Povar Luminita
;Ursu Florina Oana


;--------------------------------- ORG 1800H ---------------------------------

.org 1800h				;declarare variabile in memoria RAM
DRY_STATUS:
    .db 001H   
AML_CONTOR:
	.db 000h 
IP_PASS_UTIL:
	.DS 006h  ;define space
VP_PASS_STATUS:
	.db 001h

;--------------------------------- ORG 3000H ---------------------------------

.org 3000h
	LD HL, DRY_STATUS       		
	LD (HL), 001H           		
	

LOGIN_MODE_SELECTION:
	LD D, 0							
	ld IX, BLOC_AFIS_ADM_USR_CHOOSE	;incarcam in ix BLOC_AFIS_ADM_USR_CHOOSE pentru afisare

	CALL SCAN						

	CP TASTA_A						
	JP Z, AML_ENTRY					

	CP TASTA_B						
	JP Z, USER_MODE					

	JP LOGIN_MODE_SELECTION			

;--------------------------------- Meniu utilizator ---------------------------------

USER_MODE:
	LD IX, BLOC_AFIS_USER			
	call SCAN1									
	inc D							

	ld A, 0C8H						
	cp D							
	
	JP NZ, USER_MODE				
	JP MODES_DRY					

MODES_DRY:
	LD IX, BLOC_AFIS_UTILIZ			
	LD D, 0							
	LD A, (DRY_STATUS)				
	cp 1							
	JP Z, MODES_DRY1				
	JP MODES_DRY0					

;--------------------------------- Moduri spalare fara stoarcere ---------------------------------

MODES_DRY0:
	CALL SCAN						

	CP 	TASTA_F						
	JP Z, Program_Fast0				

	cp TASTA_C						
	JP Z, Program_Cotton0			

	CP TASTA_E						
	JP Z, Program_Eco0				

	CP TASTA_GO						
	JP Z, LOGIN_MODE_SELECTION		

	JP MODES_DRY0					
Program_Fast0:	;1secunda
	LD IX, BLOC_AFIS_F0				
	CALL SCAN1						
	INC D							

	LD A, 064h						
	CP D							
	JP NZ, Program_Fast0			
	
	LD D, 0							
	JP Done_Screen					
Program_Cotton0: ;2secunde
	LD IX, BLOC_AFIS_C0				
	CALL SCAN1						
	INC D							

	LD A, 0C8H						
	CP D							
	JP NZ, Program_Cotton0		
	LD D, 0				
	JP Done_Screen			
Program_Eco0: ;2secund
	LD IX, BLOC_AFIS_E0			
	CALL SCAN1				
	INC D					

	LD A, 0C8H			
	CP D					
	JP NZ, Program_Eco0			
	LD D, 0					
	JP Done_Screen			

;--------------------------------- Moduri spalare cu stoarcere ---------------------------------

MODES_DRY1:
	CALL SCAN			

	CP 	TASTA_F				
	JP Z, Program_Fast1			

	cp TASTA_C					
	JP Z, Program_Cotton1		

	CP TASTA_E					
	JP Z, Program_Eco1			

	CP TASTA_GO					
	JP Z, LOGIN_MODE_SELECTION	

	JP MODES_DRY1			
Program_Fast1: ;1secunda
	LD IX, BLOC_AFIS_F1            
	CALL SCAN1			
	INC D				

	LD A, 064h			
	CP D				
	JP NZ, Program_Fast1		

	LD D, 0				
	JP Done_Screen			
Program_Cotton1: ;2secunde
	LD IX, BLOC_AFIS_C1 		
	CALL SCAN1			
	INC D				

	LD A, 0C8H			
	CP D				
	JP NZ, Program_Cotton1		

	LD D, 0			
	JP Done_Screen			
Program_Eco1: ;2secunde
	LD IX, BLOC_AFIS_E1			
	CALL SCAN1				
	INC D					

	LD A, 0C8H			
	CP D				
	JP NZ, Program_Eco1		

	LD D, 0			
	JP Done_Screen			

Done_Screen: ;2secunde
	LD IX, BLOC_AFIS_done	
	CALL SCAN1				
	INC D					

	LD A, 0C8H				
	CP D						
	JP NZ, Done_Screen		

	LD D, 0						
	JP LOGIN_MODE_SELECTION			

;--------------------------------- Meniu admin ---------------------------------

;---------- Logica implementata la laborator ---------- 

AML_ENTRY:
	ld HL , AML_CONTOR
	ld (HL) , 000h				
	
	ld ix, AML_BUFFER_IMPLEMENTARE	
AML_AFISARE_PASS:
	call SCAN					
	cp TASTA_GO						
	jp IP_ENTRY			
	jp nz, AML_AFISARE_PASS			
IP_ENTRY:
	LD C, 00H				
	LD HL, IP_PASS_UTIL 			
IP_LOOP:
	LD (HL), 00H					
	INC C							
	INC HL							
	LD A, C							
	CP 06H							
	JP NZ, IP_LOOP					
	LD IX, IP_BLOC_AFIS				
	LD C, 00H						
IP_LOOP_PASS:
	CALL SCAN								  
	LD HL, IP_PASS_UTIL				
	LD B, 00H					
	ADD HL, BC					
	LD (HL), A					
	INC IX						
	INC C					
	LD A, C						
	CP 06h						
	JP NZ, IP_LOOP_PASS				
IP_LOOP_GO:
	CALL SCAN 					
	CP TASTA_GO					
	JP NZ, IP_LOOP_GO				
	JP VP_ENTRY						
VP_ENTRY:
	LD HL, VP_PASS_STATUS		
	LD (HL), 1					
	LD C, 00H					
VP_LOOP_VERIFPASS:
	LD HL, VP_PASS_STATIC		
	LD B, 00H					
	ADD HL, BC					
	LD A,(HL)					
	
	LD HL, IP_PASS_UTIL			
	LD B, 00H					
	ADD HL, BC					
	LD B,(HL)					
	CP B						
	JP NZ, VP_PASS_ERROR		
	INC C					
	LD A, 06H					
	CP C						
	JP NZ, VP_LOOP_VERIFPASS	
VP_PASS_GOOD:	;parola corecta
	LD HL, VP_PASS_STATUS			
	LD (HL), 00H				
	JP A_ENTRY							
VP_PASS_ERROR:	;parola incorecta
	LD HL, VP_PASS_STATUS			 
	LD (HL), 01H					
	JP A_ENTRY						


A_ENTRY:
    LD A, (VP_PASS_STATUS)			
    CP 00H						
    JP Z, ADM_ENTRY					
    JP VC_ENTRY					
VC_ENTRY:
	ld hl, AML_CONTOR			
	ld a, (hl)					
	inc a						
	cp 3						
	jp z, LOGIN_MODE_SELECTION	
	ld (hl), a					
	jp IP_ENTRY					


ADM_ENTRY:
	ld IX, BLOC_AFIS_ADM			
	call SCAN1							
    INC D							
	
	LD A, 0C8H													
	CP D							
	JP NZ, ADM_ENTRY				

    JP DRY_OP_ENTRY					
DRY_OP_ENTRY:
    ld A, (DRY_STATUS)				
    CP 000H							
    JP Z, Dry0						
    JP Dry1							
Dry0:
    ld ix, BLOC_AFIS_dry0			
    call SCAN						
    
	CP TASTA_1					
    jp Z, ENABLE_DRY				

	CP TASTA_GO						
	JP Z, LOGIN_MODE_SELECTION
	
	JP Dry0							
Dry1:
    ld ix, BLOC_AFIS_dry1				
    call SCAN							
    
	CP TASTA_0							
    jp Z, DISABLE_DRY					
	
	CP TASTA_GO						
	JP Z, LOGIN_MODE_SELECTION			
	
	JP Dry1								
DISABLE_DRY:
	LD HL, DRY_STATUS		
	LD (HL), 00h			
	JP Dry0				
ENABLE_DRY:
	LD HL, DRY_STATUS	
	LD (HL), 1				
	JP Dry1				

;------------------------------- BLOCURI AFISARE---------------------------------

BLOC_AFIS_ADM_USR_CHOOSE:
	.DB 003H     ;"r"
	.DB 0AEH     ;"s"
	.DB 0B5H     ;"U"
	.DB 002H     ;"-"
	.DB 0B3H     ;"d"
	.DB 03FH     ;"A"
AML_BUFFER_IMPLEMENTARE:
	.db 000h ; " "
	.db 0AEH ; "S"
	.db 0AEH ; "S"
	.db 03Fh ; "A"
	.db	01Fh ; "P"
	.db 000h ; " "
BLOC_AFIS_ADM:
    .DB 023H    ;n 
    .DB 001H    ;i
    .DB 023H    ;n
    .DB 023H    ;n
    .DB 0B3H    ;d
    .DB 03FH    ;A	
BLOC_AFIS_dry0:
    .DB 00FH     ;"f"
    .DB 0BDH     ;"O"
    .DB 002H     ;"-"
    .DB 0B6H     ;"y"
    .DB 003H     ;"r"
    .DB 0B3H     ;"d"
BLOC_AFIS_dry1:
    .DB 023H     ;"n"
    .DB 0BDH     ;"O"
    .DB 002H     ;"-"
    .DB 0B6H     ;"y"
    .DB 003H     ;"r"
    .DB 0B3H     ;"d"
BLOC_AFIS_UTILIZ:
    .DB 01BH     ;"?"
    .DB 08FH     ;"E"
    .DB 000H     ;" "
    .DB 08DH     ;"C"
    .DB 000H     ;" "
    .DB 00FH     ;"F"
BLOC_AFIS_F1:
    .DB 003H     ;"r"
    .DB 0B3H     ;"d"
    .DB 002H     ;"-"
    .DB 0AEH     ;"s"
    .DB 0BBH     ;"a"
    .DB 00FH     ;"F"
BLOC_AFIS_C1 :
    .DB 003H     ;"r"
    .DB 0B3H     ;"d"
    .DB 002H     ;"-"
    .DB 087H     ;"t"
    .DB 0A3H     ;"o"
    .DB 08DH     ;"C"
BLOC_AFIS_E1:
    .DB 003H     ;"r"
    .DB 0B3H     ;"d"
    .DB 002H     ;"-"
    .DB 0A3H     ;"o"
    .DB 083H     ;"c"
    .DB 08FH     ;"E"
BLOC_AFIS_F0:
    .DB 000H     ;" "
    .DB 000H     ;" "
    .DB 087H     ;"t"
    .DB 0AEH     ;"s"
    .DB 0BBH     ;"a"
    .DB 00FH     ;"F"
BLOC_AFIS_C0:
    .DB 023H     ;"n"
    .DB 0A3H     ;"o"
    .DB 087H     ;"t"
    .DB 087H     ;"t"
    .DB 0A3H     ;"o"
    .DB 08DH     ;"C"
BLOC_AFIS_E0:
    .DB 000H     ;" "
    .DB 000H     ;" "
    .DB 000H     ;" "
    .DB 0A3H     ;"o"
    .DB 083H     ;"c"
    .DB 08FH     ;"E"
BLOC_AFIS_done:
    .DB 000H     ;" "
	.DB 08FH     ;"E"
    .DB 023H     ;"n"
    .DB 0A3H     ;"o"
    .DB 0B3H     ;"d"
    .DB 000H     ;" "
BLOC_AFIS_USER:
	.DB 000H     ;" "
	.DB 003H     ;"r"
    .DB 08FH     ;"E"
    .DB 0AEH     ;"S"
    .DB 0B5H     ;"U"
    .DB 000H     ;" "

IP_BLOC_AFIS:
	.DB 00H
	.DB 00H
	.DB 00H
	.DB 00H
	.DB 00H
	.DB 00H
	.DB 02H
	.DB 02H
	.DB 02H
	.DB 02H
	.DB 02H
	.DB 02H

;------------------------------- PAROLA DEFAULT MENIU ADMIN---------------------------------
VP_PASS_STATIC:
	.DB 0AH
	.DB 0AH
	.DB 03H
	.DB 03H
	.DB 0AH
	.DB 03H

SCAN 			.equ 05FEH	
SCAN1         		.equ 0624H		
TASTA_GO	    	.equ 012h
TASTA_0			.equ 00H
TASTA_1			.equ 01H
TASTA_A 		.equ 0Ah
TASTA_B 		.equ 0BH
TASTA_C 		.equ 0CH
TASTA_E			.equ 0EH
TASTA_F			.equ 0FH

.end

rst 38h
