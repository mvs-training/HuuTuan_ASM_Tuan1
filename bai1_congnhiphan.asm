.MODEL SMALL
.STACK 100H

.DATA
   PROMPT_1  DB  0DH,0AH,'first binary number ( max 16-digits ) : $'
   PROMPT_2  DB  0DH,0AH,'second binary number( max 16-digits ) : $'
   PROMPT_3  DB  0DH,0AH,'                                  SUM= $'
   a DW ?
   b DW ?

.CODE
MAIN PROC
    MOV AX, DATA                ; AX chua dia chi dau vao DATA
    MOV DS, AX

START_2:                    
    XOR BX, BX                   ; BX=0
    
    LEA DX, PROMPT_1             ; String 1
    MOV AH, 9
    INT 21H
    
    MOV CX, 16                   ; lap 16 lan
    MOV AH, 1                    ; con tro
    
LOOP_1:                   

    INT 21H                      ; doc vao 1 ky tu 
    CMP AL, 0DH                  ; so sanh AL voi CR
    JNE SKIP_1                  ; Nhay toi nhan SKIP_1 neu AL khac 0DH
    JMP EXIT_LOOP_1             ; Nhay toi nhan EXIT_LOOP_1 vo dieu kien

SKIP_1:                 
   AND AL, 0FH                   ; chuyen ascii sang thap phan
   SHL BX, 1                     ; Dich trai BX 1 vi tri
   OR BL, AL                     ; set the LSB of BL with LASB of AL   
   MOV a, BX
   LOOP LOOP_1                  ; Neu CX!=0 nhay toi nhan LOOP1

EXIT_LOOP_1:              

    LEA DX, PROMPT_2             ; String 2
    MOV AH, 9
    INT 21H  
    
    
    MOV CX, 16                   ; lap 16 lan 
    MOV AH, 1                    ; con tro 

             
LOOP_2:                   
     INT 21H                     ; doc vao ky tu
     CMP AL, 0DH                 ; so sanh AL va 0DH
     JNE SKIP_2                 ; neu AL!=0DH nhay toi nhan SKIP_2
     JMP EXIT_LOOP_2            ; Nhay vo dieu kien toi nhan EXIT_LOOP_2
    
 SKIP_2:                       
   AND AL, 0FH                   ; convert ascii sang thap phan
   SHL BX, 1                     ; Dich BX sang trai 1 vi tri
   OR BH, AL                    
   MOV b, BX                     ; b=BX
   LOOP LOOP_2                  ; Nhay toi nhan LOOP_2 neu CX!=0

       

EXIT_LOOP_2:              
    
    LEA DX, PROMPT_3             ; String 3
    MOV AH, 9
    INT 21H
           
    MOV AX,a
    MOV BX,b
    ADD BX,AX                    ; BX= AX + BX = a + b
                   
    JNC SKIP                    ; Nhay toi nhan SKIP neu CF=1
    MOV AH, 2                    ; in chu so 1 
    MOV DL, 31H
    INT 21H

SKIP:                     

    MOV CX, 16                   ; lap 16 lan 
    MOV AH, 2                    ; chuc nang ra
    
LOOP_3:                   
     SHL BX, 1                   ; Dich BX sang trai 1 bit
     JC ONE                     ; nhay toi ONE neu CF=1
     MOV DL, 30H                 ; DL=0
     JMP DISPLAY                ; nhay toi nhan DISPLAY

ONE:                    
    MOV DL, 31H                  ; DL=1

DISPLAY:                     
    INT 21H                      ; in ra cac ky tu
    LOOP LOOP_3                 ; Nhay toi nhan LOOP_3 neu CX!=0
    MOV AH, 4CH                  ;  DOS
    INT 21H
MAIN ENDP

END MAIN