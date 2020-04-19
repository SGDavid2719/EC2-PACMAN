; =============================================================================
; AGENT MANAGEMENT - CODE FOR PLAYER AND FOR ENEMIES
; =============================================================================

; -----------------------------------------------------------------------------
AGNOBS
; CHECKS OBSTACLES AT MAPDATA. IF 1 BLOCK, ELSE NOTHING OR BALL.
; INPUT    - NOTHING (USES PLRPOSY AND PLRPOSX)
; OUTPUT   - D7 = $FF OBSTACLES, $00 NO OBSTACLES
; MODIFIES - NOTHING
; -----------------------------------------------------------------------------
            MOVEM.L D0-D6/A4,-(A7)          ; STORE REGISTERS

            MOVE.W  (PLRPOSY),D0            ; COLUMN POSITION
            DIVU.W  #32,D0
            MOVE.W  (PLRPOSX),D1            ; ROW POSITION
            DIVU.W  #32,D1
            MOVE.W  #MAPSCRW,D2             ; NUMBER OF COLUMNS
            

            MULU.W  D0,D2                   ; MAPDATA = RP * NC + CP
            ADD.W   D1,D2
            LEA     MAPDATA,A4              ; GET MAPS DATA


            ADD.W   D2,A4
            CLR.B   D4                      ; TEMPORARY OUTPUT

            MOVE.B  (A4),D6                 ; GET MAP CELL

            BTST    #0,D6                   ; IS OBSTACLE?
            BEQ     .END                    ; NO: STATE IT
            MOVE.B  #$FF,D4                 ; YES: PREPARE OUTPUT $FF

.END        MOVE.B  D4,D7                   ; OUTPUT PREPARED VALUE
            MOVEM.L (A7)+,D0-D6/A4          ; RESTORE REGISTERS
            RTS


; -----------------------------------------------------------------------------
BALLFOUND
; CHECKS OBSTACLES AT MAPDATA. IF 2 BLOCK, ELSE NOTHING OR BLOCK.
; INPUT    - NOTHING (USES PLRPOSY AND PLRPOSX)
; OUTPUT   - D7 = $FF OBSTACLES, $00 NO OBSTACLES
; MODIFIES - NOTHING
; -----------------------------------------------------------------------------
            MOVEM.L D0-D6/A4,-(A7)          ; STORE REGISTERS

            MOVE.W  (PLRPOSY),D0            ; COLUMN POSITION
            DIVU.W  #32,D0
            MOVE.W  (PLRPOSX),D1            ; ROW POSITION
            DIVU.W  #32,D1
            MOVE.W  #MAPSCRW,D2             ; NUMBER OF COLUMNS
            

            MULU.W  D0,D2                   ; MAPDATA = RP * NC + CP
            ADD.W   D1,D2
            LEA     MAPDATA,A4              ; GET MAPS DATA


            ADD.W   D2,A4
            CLR.B   D4                      ; TEMPORARY OUTPUT

            MOVE.B  (A4),D6                 ; GET MAP CELL

            BTST    #1,D6                   ; IS OBSTACLE?
            BEQ     .END                    ; NO: STATE IT
            MOVE.B  #$FF,D4                 ; YES: PREPARE OUTPUT $FF
            MOVE.B  #0,(A4)

.END        MOVE.B  D4,D7                   ; OUTPUT PREPARED VALUE
            MOVEM.L (A7)+,D0-D6/A4          ; RESTORE REGISTERS
            RTS

; -----------------------------------------------------------------------------
AGNOBSGHOST
; CHECKS OBSTACLES AT MAPDATA. IF 1 BLOCK, ELSE NOTHING OR BALL.
; INPUT    - NOTHING (USES (A0) AND 2(A0))
; OUTPUT   - D7 = $FF OBSTACLES, $00 NO OBSTACLES
; MODIFIES - NOTHING
; -----------------------------------------------------------------------------
            MOVEM.L D0-D6/A5,-(A7)          ; STORE REGISTERS
            
            MOVE.W  2(A0),D0                ; GHOST POSY
            DIVU.W  #32,D0
            MOVE.W  (A0),D1                 ; GHOST POSX
            DIVU.W  #32,D1
            MOVE.W  #MAPSCRW,D2             ; NUMBER OF COLUMNS
            

            MULU.W  D0,D2                   ; MAPDATA = RP * NC + CP
            ADD.W   D1,D2
            LEA     MAPDATA,A5              ; GET MAPS DATA


            ADD.W   D2,A5
            CLR.B   D4                      ; TEMPORARY OUTPUT

            MOVE.B  (A5),D6                 ; GET MAP CELL

            BTST    #0,D6                   ; IS OBSTACLE?
            BEQ     .END                    ; NO: STATE IT
            MOVE.B  #$FF,D4                 ; YES: PREPARE OUTPUT $FF

.END        MOVE.B  D4,D7                   ; OUTPUT PREPARED VALUE
            MOVEM.L (A7)+,D0-D6/A5          ; RESTORE REGISTERS
            RTS

























*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
