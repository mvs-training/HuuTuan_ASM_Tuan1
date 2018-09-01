; ScanNumber luu trong BX
ScanNum MACRO
 LOCAL Nhap, KetThuc
 PUSH AX
 MOV BX, 0
Nhap: 
  MOV AH, 1
  INT 21h
  CMP AL, 13
  JE KetThuc
  PUSH AX
  MOV AX, BX
  MUL ten
  MOV BX, AX
  POP AX
  AND AL, 0fh
  ADD BL, AL
 JMP Nhap
KetThuc:
 POP AX
ENDM
; Macro in text
PrintText MACRO n
 PUSH AX
 PUSH DX
 MOV DL, n
 OR DL, 30h  ; Chuyen so thanh ma ASCII tuong ung
 MOV AH, 2
 INT 21h
 POP DX
 POP AX
ENDM
 
; Chuong tring chinh
.MODEL SMALL
ORG 100H
.DATA
 
 MSG1 DB "Input A= $"
 MSG2 DB 0Ah, 0Dh, "Input B= $"
 MSG3 DB 0Ah, 0Dh, "SUM(A,B)= $"
 num1 DW ?
 num2 DW ?
 ten DW 10
.CODE
 MOV AX, @DATA
 MOV DS, AX
 
 ; Print label 
 MOV AH, 9
 LEA DX, MSG1
 INT 21h
 ; Nhap so 1
ScanNum
 MOV num1, BX

 ; Print label  
 
 MOV AH, 9
 LEA DX, MSG2
 INT 21h
 ; Nhap so 2
ScanNum
 MOV num2, BX
 JE PhepCong
  
  
PhepCong:
  MOV AX, num1
  MOV BX, num2
  ADD AX, BX
  JMP Exit
 
Exit:
  ; Print Label
  PUSH AX
  MOV AH, 9
  LEA DX, MSG3
  INT 21h
  POP AX
  ; Print res
 
 MOV CX, 1   ; Co danh dau
 MOV BX, 10000
Begin_Print: 
  CMP BX, 0
  JE End_Print ; BX = 0
   
  CMP CX, 0
  JE Calc   ; CX = 0
   
  CMP AX, BX
  JB Skip   ; AX < BX
 Calc:
  MOV CX, 0
  MOV DX, 0
  DIV BX   ; AX = DX AX / BX
  PrintText AL ; In AL nhu 1 ky tu binh thuong
  MOV AX, DX
   
 Skip:    ; Giam BX 10 lan
  PUSH AX
  MOV DX, 0
  MOV AX, BX
  DIV ten
  MOV BX, AX
  POP AX 
 JMP Begin_Print
  
 End_Print:
  RET