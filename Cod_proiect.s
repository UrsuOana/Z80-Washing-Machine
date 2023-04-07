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
	LD HL, DRY_STATUS       		;REGISTRUL HL E CA UN POINTER, INCARCAM IN EL ADRESA DE MEMORIE A LUI DRY STATUS
	LD (HL), 001H           		;INITIALIZAM DRY_STATUS
	

LOGIN_MODE_SELECTION:
	LD D, 0							;initializam registrul d cu 0 
	ld IX, BLOC_AFIS_ADM_USR_CHOOSE	;incarcam in ix BLOC_AFIS_ADM_USR_CHOOSE pentru afisare

	CALL SCAN						;apelam functia SCAN pentru citire de la tastatura pana e apasata o tasta

	CP TASTA_A						;verificam daca a fost apasata tasta A
	JP Z, AML_ENTRY					;daca a fost apasata => meniu admin

	CP TASTA_B						;verificam daca a fost apasata tasta A
	JP Z, USER_MODE					;daca a fost apasata => meniu user

	JP LOGIN_MODE_SELECTION			;daca a fost apasata orice alta tasta nu face nimic

;--------------------------------- Meniu utilizator ---------------------------------

USER_MODE:
	LD IX, BLOC_AFIS_USER			;incarcam in ix BLOC_AFIS_USER pentru afisare	
	call SCAN1						;apelam functia SCAN1 pentru a afisa 10ms			
	inc D							;incrementam registrul D (contor)

	ld A, 0C8H						;incarcam in registrul A valoarea 200
	cp D							;comparam registrul A cu D
	
	JP NZ, USER_MODE				;daca nu sunt egale => nu au trecut 2 sec => ne reintoarcem in bucla
	JP MODES_DRY					;daca sunt egale => au trecut 2 secunde => iesim din bucla

MODES_DRY:
	LD IX, BLOC_AFIS_UTILIZ			;incarcam in ix BLOC_AFIS_UTILIZ pentru afisare
	LD D, 0							;initializam registrul D cu 0
	LD A, (DRY_STATUS)				;incarcam in registrul A valoarea din variabila DRY_STATUS
	cp 1							;comparam registrul A cu 1
	JP Z, MODES_DRY1				;daca sunt egale => stoarcerea activa => moduri spalare cu stoarcere
	JP MODES_DRY0					;daca nu sunt egale => stoarcerea inactiva => moduri spalare fara stoarcere

;--------------------------------- Moduri spalare fara stoarcere ---------------------------------

MODES_DRY0:
	CALL SCAN						;apelam functia SCAN pentru citire de la tastatura pana e apasata o tasta

	CP 	TASTA_F						;verificam daca a fost apasata tasta F
	JP Z, Program_Fast0				;daca a fost apasata => programul Fast de spalare	

	cp TASTA_C						;verificam daca a fost apasata tasta C
	JP Z, Program_Cotton0			;daca a fost apasata => programul Cotton de spalare

	CP TASTA_E						;verificam daca a fost apasata tasta E
	JP Z, Program_Eco0				;daca a fost apasata => programul Eco de spalare

	CP TASTA_GO						;verificam daca a fost apasata tasta GO
	JP Z, LOGIN_MODE_SELECTION		;daca a fost apasata => meniu de alegere a tipului de utilizator

	JP MODES_DRY0					;ignoram orice alta tasta
Program_Fast0:	;1secunda
	LD IX, BLOC_AFIS_F0				;incarcam in ix BLOC_AFIS_F0 pentru afisare
	CALL SCAN1						;apelam functia SCAN pentru citire de la tastatura pana e apasata o tasta
	INC D							;incrementam registrul D ce are rol de contor

	LD A, 064h						;incarcam in registrul A valoarea 100
	CP D							;comparam registrul A cu D
	JP NZ, Program_Fast0			;daca nu sunt egale atunci nu am afisat pentru 1 sec => intram iar in bucla
	
	LD D, 0							;daca sunt egale incarcam in contor valoarea 0 (pentru a o utiliza in urmatoarea bucla)
	JP Done_Screen					;si sarim la Done_Screen
Program_Cotton0: ;2secunde
	LD IX, BLOC_AFIS_C0				;incarcam in ix BLOC_AFIS_C0 pentru afisare
	CALL SCAN1						;apelam functia scan1 pentru afisare de 200ms
	INC D							;incrementam registrul D ce are rol de contor

	LD A, 0C8H						;incarcam in registrul A valoarea 200
	CP D							;comparam registrul A cu D
	JP NZ, Program_Cotton0			;daca nu sunt egale atunci nu am afisat pentru 2 sec => intram iar in bucla
	LD D, 0							;daca sunt egale incarcam in contor valoarea 0 (pentru a o utiliza in urmatoarea bucla)
	JP Done_Screen					;si sarim la Done_Screen
Program_Eco0: ;2secunde
	LD IX, BLOC_AFIS_E0				;incarcam in ix BLOC_AFIS_E0 pentru afisare
	CALL SCAN1						;apelam functia scan1 pentru afisare de 200ms
	INC D							;incrementam registrul D ce are rol de contor

	LD A, 0C8H						;incarcam in registrul A valoarea 200
	CP D							;comparam registrul A cu D
	JP NZ, Program_Eco0				;daca nu sunt egale atunci nu am afisat pentru 2 sec => intram iar in bucla
	LD D, 0							;daca sunt egale incarcam in contor valoarea 0 (pentru a o utiliza in urmatoarea bucla)
	JP Done_Screen					;si sarim la Done_Screen

;--------------------------------- Moduri spalare cu stoarcere ---------------------------------

MODES_DRY1:
	CALL SCAN						;apelam functia SCAN pentru citire de la tastatura pana e apasata o tasta

	CP 	TASTA_F						;verificam daca a fost apasata tasta F
	JP Z, Program_Fast1				;daca a fost apasata => programul Fast de spalare

	cp TASTA_C						;verificam daca a fost apasata tasta C
	JP Z, Program_Cotton1			;daca a fost apasata => programul Cotton de spalare

	CP TASTA_E						;verificam daca a fost apasata tasta E
	JP Z, Program_Eco1				;daca a fost apasata => programul Eco de spalare

	CP TASTA_GO						;verificam daca a fost apasata tasta GO
	JP Z, LOGIN_MODE_SELECTION		;daca a fost apasata => meniu de alegere a tipului de utilizator

	JP MODES_DRY1					;ignoram orice alta tasta
Program_Fast1: ;1secunda
	LD IX, BLOC_AFIS_F1             ;incarcam in ix BLOC_AFIS_F1 pentru afisare
	CALL SCAN1						;apelam functia scan1 pentru afisare de 100ms
	INC D							;incrementam registrul D ce are rol de contor

	LD A, 064h						;incarcam in registrul A valoarea 100
	CP D							;comparam registrul A cu D
	JP NZ, Program_Fast1			;daca nu sunt egale atunci nu am afisat pentru 1 sec => intram iar in bucla

	LD D, 0							;daca sunt egale incarcam in contor valoarea 0 (pentru a o utiliza in urmatoarea bucla)
	JP Done_Screen					;si sarim la Done_Screen
Program_Cotton1: ;2secunde
	LD IX, BLOC_AFIS_C1 			;incarcam in ix BLOC_AFIS_C1  pentru afisare
	CALL SCAN1						;apelam functia scan1 pentru afisare de 200ms
	INC D							;incrementam registrul D ce are rol de contor

	LD A, 0C8H						;incarcam in registrul A valoarea 200
	CP D							;comparam registrul A cu D
	JP NZ, Program_Cotton1			;daca nu sunt egale atunci nu am afisat pentru 2 sec => intram iar in bucla

	LD D, 0							;daca sunt egale incarcam in contor valoarea 0 (pentru a o utiliza in urmatoarea bucla)
	JP Done_Screen					;si sarim la Done_Screen
Program_Eco1: ;2secunde
	LD IX, BLOC_AFIS_E1				;incarcam in ix BLOC_AFIS_E1  pentru afisare
	CALL SCAN1						;apelam functia scan1 pentru afisare de 200ms
	INC D							;incrementam registrul D ce are rol de contor

	LD A, 0C8H						;incarcam in registrul A valoarea 200
	CP D							;comparam registrul A cu D
	JP NZ, Program_Eco1				;daca nu sunt egale atunci nu am afisat pentru 2 sec => intram iar in bucla

	LD D, 0							;daca sunt egale incarcam in contor valoarea 0 (pentru a o utiliza in urmatoarea bucla)
	JP Done_Screen					;si sarim la Done_Screen


Done_Screen: ;2secunde
	LD IX, BLOC_AFIS_done			;incarcam in ix BLOC_AFIS_done pentru afisare
	CALL SCAN1						;apelam functia scan1 pentru afisare de 200ms
	INC D							;incrementam registrul D ce are rol de contor

	LD A, 0C8H						;incarcam in registrul A valoarea 200
	CP D							;comparam registrul A cu D
	JP NZ, Done_Screen				;daca nu sunt egale atunci nu am afisat pentru 2 sec => intram iar in bucla	

	LD D, 0							;daca sunt egale incarcam in contor valoarea 0 (pentru a o utiliza in urmatoarea bucla)
	JP LOGIN_MODE_SELECTION			;si ne intoarcem la meniul de selectie a tipului de utilizator	

;--------------------------------- Meniu admin ---------------------------------

;---------- Logica implementata la laborator ---------- 
AML_ENTRY:
	ld HL , AML_CONTOR				;incarcam in registrul HL valoarea din variabila AML_CONTOR
	ld (HL) , 000h					;initializam registrul HL cu valoarea 0
	
	ld ix, AML_BUFFER_IMPLEMENTARE	;incarcam in registrul ix AML_BUFFER_IMPLEMENTARE pentru afisare
AML_AFISARE_PASS:
	call SCAN						;apelam functia SCAN pentru citire de la tastatura pana e apasata o tasta
	cp TASTA_GO						;verificam daca a fost apasata tasta GO
	jp IP_ENTRY						;daca a fost apasata sarim la IP_ENTRY
	jp nz, AML_AFISARE_PASS			;daca a fost apasat altceva ignoram	
IP_ENTRY:
	LD C, 00H						;vom utiliza registrul C drept contor si il initializam cu 0
	LD HL, IP_PASS_UTIL 			;in registrul HL incarcam IP_PASS_UTIL
IP_LOOP:
	LD (HL), 00H					;initializam registrul HL cu valoarea 0  
	INC C							;incrementam contorul
	INC HL							;incrementam valoarea din registrul HL (IP_PASS_UTIL) 
	LD A, C							;incarcam in registrul A valoarea din contor
	CP 06H							;verificam daca valoarea din registrul A (contorul) e egala cu 6
	JP NZ, IP_LOOP					;daca nu e egala => nu s-au introdus toate cifrele parolei => reluam bucla
	LD IX, IP_BLOC_AFIS				;incarcam in registrul IX IP_BLOC_AFIS pentru afisare
	LD C, 00H						;incarcam in registrul C 0 
IP_LOOP_PASS:
	CALL SCAN						;apelam functia scan			  
	LD HL, IP_PASS_UTIL				;incarcam in HL IP_PASS_UTIL
	LD B, 00H						;incarcam in B valoarea 0
	ADD HL, BC						;adaugam in registrul HL BC (0)
	LD (HL), A						;in HL incarcam A 
	INC IX							;incrementam registrul IX (pentru afisare -)
	INC C							;incrementam C (contorul)
	LD A, C							;incarcam in registrul A C(contorul)
	CP 06h							;comparam A (contorul) cu 6
	JP NZ, IP_LOOP_PASS				;daca e diferit => nu au fost introdusa toata parola =>reluam bucla
IP_LOOP_GO:
	CALL SCAN 						;apelam functia scan pentru citire de la tastatura
	CP TASTA_GO						;verificam daca tasta apasata e GO
	JP NZ, IP_LOOP_GO				;daca nu a fost apasat GO => ne intoarcem in IP_LOOP_GO
	JP VP_ENTRY						;daca a fost apasat => parola introdusa => VP_ENTRY
VP_ENTRY:
	LD HL, VP_PASS_STATUS		;incarcam in HL VP_PASS_STATUS
	LD (HL), 1					;incarcam 1 in HL (VP_PASS_STATUS)
	LD C, 00H					;initializam cu 0 registrul C pe care il vom folosi ca si contor
VP_LOOP_VERIFPASS:
	LD HL, VP_PASS_STATIC		;incarcam in HL VP_PASS_STATIC 
	LD B, 00H					;initializam cu 0 registrul B
	ADD HL, BC					;adaugam la HL BC 
	LD A,(HL)					;incarcam in registrul A HL (VP_PASS_STATIC )
	
	LD HL, IP_PASS_UTIL			;incarcam in HL IP_PASS_UTIL
	LD B, 00H					;initializam cu 0 registrul B
	ADD HL, BC					;adaugam la HL BC 
	LD B,(HL)					;incarcam in registrul B HL (VP_PASS_UTIL )
	CP B						;comparam A (VP_PASS_STATIC) cu B (VP_PASS_UTIL)
	JP NZ, VP_PASS_ERROR		;daca nu sunt egale => parola gresita
	INC C						;daca sunt egale incrementam C (contor)
	LD A, 06H					;incarcam in registrul A valoarea 6
	CP C						;comparam registrul A cu C (contor)
	JP NZ, VP_LOOP_VERIFPASS	;daca nu sunt egale => nu s-au introdus toate cifrele => ne intoarcem in bucla de verificare a parolei
VP_PASS_GOOD:	;parola corecta
	LD HL, VP_PASS_STATUS			;incarcam in registrul HL VP_PASS_STATUS
	LD (HL), 00H					;incarcam in HL (VP_PASS_STATUS) valoarea 0
	JP A_ENTRY						;sarim in A_ENTRY	
VP_PASS_ERROR:	;parola incorecta
	LD HL, VP_PASS_STATUS			;incarcam in registrul HL VP_PASS_STATUS 
	LD (HL), 01H					;incarcam in HL (VP_PASS_STATUS) valoarea 1
	JP A_ENTRY						;sarim in A_ENTRY


A_ENTRY:
    LD A, (VP_PASS_STATUS)			;incarcam in registrul A valoarea din VP_PASS_STATUS
    CP 00H							;comparam registrul A (VP_PASS_STATUS) cu 0
    JP Z, ADM_ENTRY					;daca sunt egale => parola corecta => intram in meniul de admin
    JP VC_ENTRY						;daca nu sunt egale => parola incorecta => sarim la VC_ENTRY care verifica de cate ori a fost introdusa parola gresita
VC_ENTRY:
	ld hl, AML_CONTOR				;incarcam in registrul HL AML_CONTOR
	ld a, (hl)						;valoarea din registrul HL o incarcam in A
	inc a							;incrementam valoarea din registrul A
	cp 3							;comparam valoarea din registrul A cu 3
	jp z, LOGIN_MODE_SELECTION		;daca sunt egale => a fost introdusa parola gresita de 3 ori => sarim la selectarea tipului de utilizator
	ld (hl), a						;daca nu sunt egale => introducem valoarea din registrul A in HL (incrementam AML_CONTOR)
	jp IP_ENTRY						;ne intoarcem la introducerea de parola


ADM_ENTRY:
	ld IX, BLOC_AFIS_ADM				;incarcam in registrul ix BLOC_AFIS_ADM	pentru afisare	
	call SCAN1							;apelam functia SCAN1 pentru a afisa 10ms 
    INC D								;incrementam D (contorul)
	
	LD A, 0C8H							;incarcam in registrul A valoarea 200							
	CP D								;comparam valoarea din D (contor) cu valoarea din A
	JP NZ, ADM_ENTRY					;daca nu sunt egale => nu au trecut 2 sec => repetam bucla

    JP DRY_OP_ENTRY						;daca sunt egale => au trecut 2 sec => iesim din bucla
DRY_OP_ENTRY:
    ld A, (DRY_STATUS)					;incarcam in registrul A valoarea din variabila DRY_STATUS
    CP 000H								;comparam cu 0 valoarea din A
    JP Z, Dry0							;daca sunt egale => stoarcerea e dezactivata => intram in Dry0
    JP Dry1								;daca nu sunt egale => stoarcerea e activata => intram in Dry1
Dry0:
    ld ix, BLOC_AFIS_dry0				;incarcam in registrul ix BLOC_AFIS_dry0 pentru afisare
    call SCAN							;apelam functia SCAN pentru citire de la tastatura pana e apasata o tasta
    
	CP TASTA_1							;comparam tasta apasata cu tasta 1
    jp Z, ENABLE_DRY					;daca s-a apasat 1 => activam stoarcerea

	CP TASTA_GO							;comparam tasta apasata cu tasta GO
	JP Z, LOGIN_MODE_SELECTION			;daca s-a apasat GO => iesim in meniul de selectare a tipului de utilizator
	
	JP Dry0								;daca nici una din cele 2 taste nu a fost apasata ignoram
Dry1:
    ld ix, BLOC_AFIS_dry1				;incarcam in registrul ix BLOC_AFIS_dry1 pentru afisare
    call SCAN							;apelam functia SCAN pentru citire de la tastatura pana e apasata o tasta
    
	CP TASTA_0							;comparam tasta apasata cu tasta 0
    jp Z, DISABLE_DRY					;daca s-a apasat 0 => dezactivam stoarcerea
	
	CP TASTA_GO							;comparam tasta apasata cu tasta GO
	JP Z, LOGIN_MODE_SELECTION			;daca s-a apasat GO => iesim in meniul de selectare a tipului de utilizator
	
	JP Dry1								;daca nici una din cele 2 taste nu a fost apasata ignoram
DISABLE_DRY:
	LD HL, DRY_STATUS		;incarcam in registrul HL DRY_STATUS
	LD (HL), 00h			;setam valoarea din DRY_STATUS 0 => stoarcere dezactivata
	JP Dry0					;sarim la eticheta de stoarcere dezactivata
ENABLE_DRY:
	LD HL, DRY_STATUS		;incarcam in registrul HL DRY_STATUS	
	LD (HL), 1				;setam valoarea din DRY_STATUS 1 => stoarcere activata
	JP Dry1					;sarim la eticheta de stoarcere activata

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
SCAN1           .equ 0624H		
TASTA_GO	    .equ 012h
TASTA_0			.equ 00H
TASTA_1			.equ 01H
TASTA_A 		.equ 0Ah
TASTA_B 		.equ 0BH
TASTA_C 		.equ 0CH
TASTA_E			.equ 0EH
TASTA_F			.equ 0FH

.end
	rst 38h