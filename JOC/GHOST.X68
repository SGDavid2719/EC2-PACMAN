; =============================================================================
; GHOST MANAGEMENT. IT IS AN AGENT.
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; +2 WORD Y COORDINATE
; +4 WORD X SPEED
; +6 WORD Y SPEED
; =============================================================================
            
; -----------------------------------------------------------------------------
GHOSTINIT
; INITALIZES A GHOST
; INPUT    - A0 POINTER TO THE LOCAL MEMORY, D1 GHOST POSX, D2 GHOST POSY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            MOVE.W  D1,(A0)                 ; X POSITION
            MOVE.W  D2,2(A0)                ; Y POSITION
            MOVE.W  #$0002,D0               ; X SPEED
            MOVE.W  #$0000,6(A0)            ; Y SPEED
            MOVE.W  (A7)+,D0
            RTS

; -----------------------------------------------------------------------------
GHOSTUPD
; UPDATES A GHOST
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L  D0-D7,-(A7)

            MOVE.W  (A0),D2                 ; LAST X
            MOVE.W  2(A0),D3                ; LAST Y

            JSR     UTLRAND
            CMP     #125,D0                 ; 50% CHANCE R - L
            BLE     .UPDOWN
            
            JSR     UTLRAND
            CMP     #125,D0                 ; 50% CHANCE R - L
            BLE     .RIGHT
            SUB.W   #GHOSTSPEED,(A0)        ; LEFT
            BRA     .FIN
.RIGHT      ADD.W   #GHOSTSPEED,(A0)        ; RIGHT
            BRA     .FIN

.UPDOWN     JSR     UTLRAND
            CMP     #125,D0                 ; 50% CHANCE R - L
            BLE     .DOWN
            SUB.W   #GHOSTSPEED,2(A0)       ; UP
            BRA     .FIN
.DOWN       ADD.W   #GHOSTSPEED,2(A0)       ; DOWN
            BRA     .FIN

.FIN        JSR     AGNOBSGHOST             ; CHECK OBSTACLES
            TST.B   D7
            BEQ     .COLPLAY                ; IF NOT, STORE
            MOVE.W  D2,(A0)                 ; STORES LAST X
            MOVE.W  D3,2(A0)                ; STORES LAST Y

.COLPLAY    MOVE.W  (A0),D0                 ; CHECKS COLISIONS
            MOVE.W  2(A0),D1
            MOVE.W  #GHOSTSIZE,D4
            MOVE.W  D4,D6
            MOVE.W  (PLRPOSX),D2
            MOVE.W  (PLRPOSY),D3
            MOVE.W  #PLRWIDTH,D5
            MOVE.W  #PLRHEIGH,D7
            JSR     UTLCHCOL
            TST.B   D0
            BEQ     .END
            MOVE.B  #PLRUMDMG|PLRPMDMG,(PLRDMG)

.END        MOVEM.L  (A7)+,D0-D7
            RTS

; -----------------------------------------------------------------------------
GHOSTPLOT
; PLOTS A GHOST
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            UTLSPEN #GHOSTPENCL
            UTLSFIL #GHOSTFILCL
            MOVEM.L D1-D4,-(A7)
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #GHOSTSIZE,D3
            ADD.W   #GHOSTSIZE,D4
            MOVE.B  #88,D0
            TRAP    #15
            ADD.W   #GHOSTSIZE/2,D2
            MOVE.B  #87,D0
            TRAP    #15
            MOVEM.L (A7)+,D1-D4
            RTS

























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
