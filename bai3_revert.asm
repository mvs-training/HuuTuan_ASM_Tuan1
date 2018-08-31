.MODEL SMALL

.STACK 32

.DATA

       STR1 DB 0DH,0AH, 'INPUT STRING: $'
       STR2 DB 0DH,0AH, 'OUPUT STRING: $'
       nl db 0dh,0ah,'$' 

.CODE 

 START:

        MOV AX,@DATA
        MOV DS,AX


 DISP:              
        LEA DX,STR1 ;hien thi input vao
        MOV AH,09H
        INT 21H

        MOV CL,00
        MOV AH,01H

 READ:

        INT 21H


        MOV BL,AL

        PUSH BX
        inc cx
        CMP AL,0DH

        JZ DISPLAY
        
        JMP READ
        
 DISPLAY:
       
        
        LEA DX,STR2   ; hien thi ouput
        MOV AH,09H
        INT 21H
          
        
        lea DX, nl   ;  new line
        mov AH,09h
        int 21h
                        
 ANS:
        MOV AH,02H
        POP BX
        MOV DL,BL
        INT 21H
        LOOP ANS


.EXIT

END  START

