; =============================================================================
; SPAWNER MANAGEMENT.
; =============================================================================

; -----------------------------------------------------------------------------
SPWUPD
; UPDATES THE SPAWNER. CREATES JUST 3 GHOSTS
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D2/A1-A3,-(A7)                      
            
            MOVE.W  #GHOSTONEX,D1
            MOVE.W  #GHOSTONEY,D2            
            LEA     GHOSTINIT,A1        ; GHOST ONE
            LEA     GHOSTUPD,A2
            LEA     GHOSTPLOT,A3
            MOVE.W  #GHOSTTYPE,D0
            JSR     AGLADD

            MOVE.W  #GHOSTTWOX,D1
            MOVE.W  #GHOSTTWOY,D2 
            LEA     GHOSTINIT,A1        ; GHOST TWO
            LEA     GHOSTUPD,A2
            LEA     GHOSTPLOT,A3
            MOVE.W  #GHOSTTYPE,D0
            JSR     AGLADD

            MOVE.W  #GHOSTTHREEX,D1
            MOVE.W  #GHOSTTHREEY,D2
            LEA     GHOSTINIT,A1        ; GHOST THREE
            LEA     GHOSTUPD,A2
            LEA     GHOSTPLOT,A3
            MOVE.W  #GHOSTTYPE,D0
            JSR     AGLADD

.END        MOVEM.L (A7)+,D0-D2/A1-A3

            RTS












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
