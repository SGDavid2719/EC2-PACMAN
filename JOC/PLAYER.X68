; =============================================================================
; PLAYER MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
PLRINIT
; INITIALIZES THE PLAYER. PLOTS THE PLAYER AT THE CENTER ADDING 6.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #MAPTILEW+6,(PLRPOSX)
            MOVE.W  #MAPTILEH+6,(PLRPOSY)
            MOVE.W  #PLRLIFE,(PLRTLIFE)
            CLR.W   (PLRSCORE)
            CLR.W   (PLRDMG)
            RTS

; -----------------------------------------------------------------------------
PLRUPD
; UPDATES THE PLAYER MOTION. UPDATES MUSIC OF GAME OVER, VICTORY AND EATING BALL.
; INPUT    - NONE (ACCESSES KBDVAL AND KBDEDGE)
; OUTPUT   - NONE (MODIFIES PLAYER DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BCLR.B  #PLRUBDMG,(PLRDMG)
            BEQ     .NODMG
            SUB.W   #GHOSTDMG,(PLRTLIFE)
            
            
            MOVE.L  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDMU2ID,D1
            JSR     AUDPLAY                 ; PLAY GAME OVER MUSIC
            MOVE.L  (A7)+,D1          
            
.GOVER      MOVE.W  #STAGOVR,(STANEXT)      ; IF LIFE IS 0, GAME OVER
            
.NODMG      CMPI.W  #142,(PLRSCORE)
            BNE     .NOVICT
            MOVE.L  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDMU3ID,D1
            JSR     AUDPLAY                 ; PLAY VICTORY MUSIC
            MOVE.L  (A7)+,D1
            MOVE.W  #STAVICT,(STANEXT)      ; IF SCORE EQUAL 142, VICTORY
            
.NOVICT     MOVEM.L  D1-D7,-(A7)

            MOVE.W  (PLRPOSX),D2
            MOVE.W  (PLRPOSY),D3
            MOVE.B  (KBDVAL),D1             ; PERFORM MOTION AND CHECK BOUNDS.
            ROR.B   #1,D1
            BCC     .CHKUP                  
            SUB.W   #PLRSPEED,(PLRPOSX)     ; LEFT
            JSR     AGNOBS                  ; CHECK OBSTACLES
            TST.B   D7
            BEQ     .STOR1                  ; IF NOT, STORE  
            MOVE.W  D2,(PLRPOSX)
            BRA     .STOR11
.STOR1      JSR     BALLFOUND
            TST.B   D7
            BEQ     .STOR11                 ; IF NOT, STORE  
            MOVE.L  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDSN1ID,D1
            JSR     AUDPLAY                 ; PLAY EATING BALL MUSIC
            MOVE.L  (A7)+,D1
            ADD.W   #BALLSCORE,(PLRSCORE)   ; INCREASE SCORE
.STOR11     TST.W   (PLRPOSX)            
            BGE     .CHKUP                  
            CLR.W   (PLRPOSX)
.CHKUP      ROR.B   #1,D1
            BCC     .CHKRT                  
            SUB.W   #PLRSPEED,(PLRPOSY)     ; UP
            JSR     AGNOBS                  ; CHECK OBSTACLES
            TST.B   D7 
            BEQ     .STOR2                  ; IF NOT, STORE
            MOVE.W  D3,(PLRPOSY)
            BRA     .STOR21 
.STOR2      JSR     BALLFOUND
            TST.B   D7
            BEQ     .STOR21                 ; IF NOT, STORE  
            MOVE.L  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDSN1ID,D1
            JSR     AUDPLAY                 ; PLAY EATING BALL MUSIC
            MOVE.L  (A7)+,D1
            ADD.W   #BALLSCORE,(PLRSCORE)   ; INCREASE SCORE
.STOR21     TST.W   (PLRPOSY)
            BGE     .CHKRT                  
            CLR.W   (PLRPOSY)
.CHKRT      ROR.B   #1,D1
            BCC     .CHKDN
            ADD.W   #PLRSPEED,(PLRPOSX)     ; RIGHT
            JSR     AGNOBS                  ; CHECK OBSTACLES
            TST.B   D7
            BEQ     .STOR3                  ; IF NOT, STORE
            MOVE.W  D2,(PLRPOSX)
            BRA     .STOR31
.STOR3      JSR     BALLFOUND
            TST.B   D7
            BEQ     .STOR31                 ; IF NOT, STORE
            MOVE.L  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDSN1ID,D1
            JSR     AUDPLAY                 ; PLAY EATING BALL MUSIC
            MOVE.L  (A7)+,D1  
            ADD.W   #BALLSCORE,(PLRSCORE)   ; INCREASE SCORE 
.STOR31     CMP.W   #SCRWIDTH-PLRWIDTH,(PLRPOSX)
            BLE     .CHKDN
            MOVE.W  #SCRWIDTH-PLRWIDTH,(PLRPOSX)
.CHKDN      ROR.B   #1,D1
            BCC     .MDONE
            ADD.W   #PLRSPEED,(PLRPOSY)     ; DOWN
            JSR     AGNOBS                  ; CHECK OBSTACLES
            TST.B   D7
            BEQ     .STOR4                  ; IF NOT, STORE  
            MOVE.W  D3,(PLRPOSY)
            BRA     .STOR41
.STOR4      JSR     BALLFOUND
            TST.B   D7
            BEQ     .STOR41                 ; IF NOT, STORE 
            MOVE.L  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDSN1ID,D1
            JSR     AUDPLAY                 ; PLAY EATING BALL MUSIC
            MOVE.L  (A7)+,D1 
            ADD.W   #BALLSCORE,(PLRSCORE)   ; INCREASE SCORE 
.STOR41     CMP.W   #SCRHEIGH-PLRHEIGH,(PLRPOSY)
            BLE     .MDONE
            MOVE.W  #SCRHEIGH-PLRHEIGH,(PLRPOSY)            
.MDONE      
            BTST.B  #KBDBITF1,(KBDEDGE)
            
            MOVEM.L  (A7)+,D1-D7
            RTS


; -----------------------------------------------------------------------------
PLRPLOT
; PLOTS THE PLAYER ITS LIFE AND THE SCORE. PLOTS PLAYER'S MOUTH AND EYE.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            MOVE.L  #PLRNRMCL,D1            ; DECIDE COLOR
            BCLR.B  #PLRPBDMG,(PLRDMG)
            BEQ     .NODMG
.NODMG      MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            MOVE.W  (PLRPOSX),D1            ; PLOT THE PLAYER
            MOVE.W  (PLRPOSY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #PLRWIDTH,D3
            ADD.W   #PLRHEIGH,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVE.L  #EYECOLOR,D1            ; DECIDE COLOR
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            
            MOVE.W  (PLRPOSX),D1            ; PLOT THE EYE
            MOVE.W  (PLRPOSY),D2
            ADD.W   #EYEPOS,D1
            ADD.W   #EYEHEIGH,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #EYEWIDTH,D3
            ADD.W   #EYEHEIGH,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            ADD.W   #MOUTHPOS,D2            ; PLOT THE MOUTH
            MOVE.W  D2,D4
            ADD.W   #MOUTHWIDTH,D3
            ADD.W   #MOUTHHEIGH,D4
            MOVE.B  #87,D0
            TRAP    #15         

            UTLSPEN #PLRTXTCL               ; PLOT THE SCORE TEXT
            UTLSFIL #$00000000
            UTLLOCT PLRTXTX,PLRTXTY
            LEA     .SCORESTR,A1
            CLR.L   D1
            MOVE.W  (PLRSCORE),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            RTS
.SCORESTR   DC.W    'SCORE: ',0

















































*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
