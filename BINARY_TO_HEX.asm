TITLE BINARY_TO_HEX 

;   CONVERT 8BIT BINARY NUMBER TO HEXADECIMAL NUMBER
;   INPUT AND OUTPUT WITH FUNCTIONS
;   THE PROGRAM RUNS UNTIL THE USER PRESSES DOT 
;   CHARACTERS INSERTED FROM KEYBOARD APPEAR AFTER CHECK (0-1)
;   OTHERWISE THEY ARE IGNORED 
 
DATA SEGMENT
    FLAG DW ? 
    BIN_NUMBER_MSG DB 10,13, "GIVE AN 8 BIT BINARY NUMBER: ","$"
    HEX_NUMBER_MSG DB 10,13, "THE HEX NUMBER IS: ","$"
    
DATA ENDS    


CODE SEGMENT

    START:
        MOV AX, DATA
        MOV DS, AX
 
        CALL DISPLAY_MSG
        CALL INPUT_BIN 
        CALL DISPLAYHEX
        CALL BINARYTOHEX

    EXIT: 
        MOV AH, 4Ch
        INT 21h 
   
DISPLAY_MSG PROC
       
    LEA DX, BIN_NUMBER_MSG   
    MOV AH, 9 
    INT 21h
    RET    
    
DISPLAY_MSG ENDP 

INPUT_BIN PROC
    MOV AX,0 
    MOV BX,0
    MOV CX,8
    MOV DX,0

    INPUT_BIN2:     
        CMP CX,0
        JE DISPLAYHEX 
    
        MOV AH, 8H 
        INT 21h   
    
        CMP AL,"."  
        JE EXIT 
    
        CMP AL,"0"  
        JB INPUT_BIN2 
    
        CMP AL,"1"
        JA INPUT_BIN2
 
        MOV DL,AL
        MOV AH,02
        INT 21H
    
        DEC CX
           
    BINARY_CONTINUE: 
        SUB AL,48 
        SHL BX,1
        OR BL,AL
        JMP INPUT_BIN2  

INPUT_BIN ENDP  

BINARYTOHEX PROC   
    
    DISPLAYHEX:
        LEA DX, HEX_NUMBER_MSG   
        MOV AH, 9 
        INT 21h   

        MOV CH,0
        MOV CL,1
        MOV DX,0   

    OUTPUT_HEXA1:     
        CMP CH,4
        JE START
        INC CH
   
        MOV DL,BH
        SHR DL,4
   
        CMP DL,0AH
        JL HEXA_DIGIT
   
        ADD DL,37H
        MOV AH,2
        INT 21H
        ROL BX,4
   
        JMP OUTPUT_HEXA1
   
   HEXA_DIGIT:
        ADD DL,30H
        MOV AH,2
        INT 21H
        ROL BX,4
   
        JMP OUTPUT_HEXA1  
    
BINARYTOHEX ENDP       

CODE ENDS
END START       