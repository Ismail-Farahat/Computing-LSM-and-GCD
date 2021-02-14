
ORG 100H            
include emu8086.inc  ; used to print words and numbers
      
      
JMP START            ; jump over data declaration


N1  DW ?        ; first input
N2  DW ?        ; second input
GCD DW ? 
LSM DW ? 

     
START:  ;; PRINT WELCOME MESSAGE
        PRINTN "Please, Enter Two 8-bit unsigned numbers (from 000 to 255) :" 
        PRINTN "NOTES: 1- ENTER 6  AS 006 ."
        PRINTN "       2- ENTER 20 AS 020 ."
        
        ;; FIRST INPUT
        PRINT  "N1 = "
        
        ; READ THE DATA FROM THE USER (N1) 
        MOV     AH, 1H          ; scan function is 1 (int21).
        MOV     CX, 3           ; number of decimal input digits that user should enter (used in the loop)
        MOV     DI, 1000H        

        
        INPUT1: ; loop to get (hundreds/tenths/units) place of the first number
                INT     21H             ; to begin the scan
                SUB     AL,'0'          ; convert from string to integer
                MOV     [DI],AL         ; load the userinput from AL to location with address DI
                INC     DI              ; increment DI value to move to the second address
                LOOP    INPUT1          ; loop three times to get the whole number from users
                
                    ; to convert the three digits of the user input to one number
                    MOV     DI,1000H        ; hundrents convertion
                    MOV     AL,100
                    MOV     BL,[DI]
                    MUL     BL
                    MOV     DX,AX
                
                    INC     DI              ; tens convertion
                    MOV     AL,10
                    MOV     BL,[DI]
                    MUL     BL
                    ADD     AX,DX
                
                    INC     DI              ; adding hundrents, tens and units to have the first input
                    ADD     AX,[DI]
                
                    INC     DI
                    MOV     N1,AX           ; the first input saved in N1
        
         
        
        
        ;; SECOND INPUT
        PRINTN ""
        PRINT  "N2 = "
        
        ; READ THE DATA FROM THE USER (N1) 
        MOV     AH, 1H          ; scan function is 1 (int21).
        MOV     CX, 3           ; number of decimal input digits that user should enter (used in the loop)
        MOV     DI, 1000H   

        INPUT2: ; loop to get (hundreds/tenths/units) place of the first number
                INT     21H             ; to begin the scan
                SUB     AL,'0'          ; convert from string to integer
                MOV     [DI],AL         ; load the userinput from AL to location with address DI
                INC     DI              ; increment DI value to move to the second address
                LOOP    INPUT2          ; loop three times to get the whole number from users
                
                    ; to convert the three digits of the user input to one number
                    MOV     DI,1000H        ; hundrents convertion
                    MOV     AL,100
                    MOV     BL,[DI]
                    MUL     BL
                    MOV     DX,AX
                
                    INC     DI              ; tens convertion
                    MOV     AL,10
                    MOV     BL,[DI]
                    MUL     BL
                    ADD     AX,DX
                
                    INC     DI              ; adding hundrents, tens and units to have the first input
                    ADD     AX,[DI]
                
                    INC     DI
                    MOV     N2,AX           ; the second input saved in N2
         
         

        

                    
                    
                    
                    
        ;; THE PROGRAM
        MOV     AX,N1
        MOV     BX,N2
        
GCD_:   MOV     DX,0
        MOV     CX,BX           ; CX registeris going to use to update values of BX and CX during the process        
        DIV     BX              ; the goal from this processis to have the reminder ( like 'mod' function in C or python)
        MOV     BX,DX
        
        MOV     AX,CX
        
        CMP     BX,0            ; if the remindier of the divison of N2/N1 is not equal to zero ...
        JNE     GCD_            ; ... jump to to label GCD_ to repeat the process
        
        
        MOV     GCD,AX 
        
        
MUL_:   MOV     AX,N1          
        MOV     BX,N2
        MUL     BL              ; multiply N1 and N2 and use this value to calculate LSM (saved in AX)
        
           
LSM_:   MOV     BX,GCD
        DIV     BX              ; divide the value of N1 and N2 multiplication by GCD value to calculate LSM
        MOV     LSM,AX        
        
        



        ;; PRINT THE RESULTS
        PRINTN ""                ; to print newline
        PRINTN ""                ; to print nweline
        
        ; PRINT LSM
        PRINT "LSM = "
        MOV     AX,LSM
        CALL    PRINT_NUM_UNS    ; function to print the number in register AX
        
        PRINTN ""                ; to print newline
        
        ; PRINT GCD
        PRINT "GCD = "
        MOV     AX,GCD
        CALL    PRINT_NUM_UNS    ; function to print the number in register AX
        ;;                    
            

        
        

RET


DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS  ; required for print_num.







