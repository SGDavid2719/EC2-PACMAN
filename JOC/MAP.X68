; =============================================================================
; MAP MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
MAPPLOT
; PLOTS THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D7/A0,-(A7)
            LEA     MAPDATA,A0              ; GET MAPS DATA
            
            MOVE.L  #MAPBLCOL,D1            ; DECIDE COLOR
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            
            MOVE.W  #MAPSCRH-1,D5           ; ROW ITERATOR
            MOVE.W  #MAPINIY,D2             ; INITIAL Y
.LOOPY      MOVE.W  #MAPINIX,D1             ; INITIAL X (REINIT AFTER EACH ROW)
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #MAPTILEH,D4            ; ADD 32 TO Y
            MOVE.W  #MAPSCRW-1,D6           ; COLUMN ITERATOR
.LOOPX      ADD.W   #MAPTILEW,D3            ; ADD 32 TO X
            MOVE.B  (A0)+,D7                ; GET MAP CELL                      
            BTST    #0,D7                   ; CHECKS IF IS A 0
            BEQ     .SKIP
            MOVE.B  #87,D0
            TRAP    #15
.SKIP       MOVE.W  D3,D1
            DBRA.W  D6,.LOOPX               ; LOOP FOR ALL COLUMNS
            MOVE.W  D4,D2
            DBRA.W  D5,.LOOPY               ; LOOP FOR ALL ROWS
            
            LEA     MAPDATA,A0              ; GET MAPS DATA
            
            MOVE.L  #BALLPENCL,D1           ; DECIDE COLOR
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            
            MOVE.W  #MAPSCRH-1,D5           ; ROW ITERATOR
            MOVE.W  #MAPINIY,D2             ; INITIAL Y
.LOOPY2     MOVE.W  #MAPINIX,D1             ; INITIAL X (REINIT AFTER EACH ROW)
            MOVE.W  D1,D3
            MOVE.W  D2,D4           
            ADD.W   #MAPTILEH,D4            ; ADD 32 TO Y
            MOVE.W  #MAPSCRW-1,D6           ; COLUMN ITERATOR
.LOOPX2     ADD.W   #MAPTILEW,D3            ; ADD 32 TO X
            MOVE.B  (A0)+,D7                ; GET MAP CELL                      
            BTST    #1,D7                   ; CHECKS IF IS A 0
            BEQ     .SKIP2
            ADD.W   #BALLSIZE,D1            ; UPPER CORNER
            ADD.W   #BALLSIZE,D2
            SUB.W   #BALLSIZE,D3            ; DOWN CORNER
            SUB.W   #BALLSIZE,D4
            MOVE.B  #88,D0
            TRAP    #15
            SUB.W   #BALLSIZE,D1            ; UPPER CORNER
            SUB.W   #BALLSIZE,D2
            ADD.W   #BALLSIZE,D3            ; DOWN CORNER
            ADD.W   #BALLSIZE,D4
.SKIP2      MOVE.W  D3,D1
            DBRA.W  D6,.LOOPX2              ; LOOP FOR ALL COLUMNS
            MOVE.W  D4,D2
            DBRA.W  D5,.LOOPY2              ; LOOP FOR ALL ROWS
            
            MOVEM.L (A7)+,D0-D7/A0
            
            RTS

; -----------------------------------------------------------------------------
MAPUPD
; PLOTS THE MAP. IF PACMAN EATS A BALL UPDATES THAT CELL.
; INPUT    - NONE (USES (PLRPOSX) AND (PLRPOSY))
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVEM.L D0-D7/A0,-(A7)
            
            MOVE.L  #MAPGRCOL,D1            ; DECIDE COLOR
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15

            MOVE.W  (PLRPOSY),D2            ; INITIAL Y
            MOVE.W  (PLRPOSX),D1            ; INITIAL X 
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #MAPTILEH,D4            ; ADD 32 TO Y
            ADD.W   #MAPTILEW,D3            ; ADD 32 TO X
            
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVE.W  (PLRPOSY)-6/32,D0       ; COLUMN POSITION
            MOVE.W  (PLRPOSX)-6/32,D1       ; ROW POSITION   
            MOVE.W  #MAPSCRW,D2             ; NUMBER OF COLUMNS
            
            MULU    D1,D2                   ; MAPDATA = RP * NC + CP
            ADD.W   D0,D2
            LEA     MAPDATA,A0              ; GET MAPS DATA
            ADD.W   D2,A0

            MOVE.B  #0,(A0)                 ; SET MAP CELL

            MOVEM.L (A7)+,D0-D7/A0
            
            RTS

; -----------------------------------------------------------------------------
MAPINIT
; RESTORES THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D5-D7/A0-A1,-(A7)
            
            LEA     MAPDATA,A0              ; GET MAPS DATA
            LEA     MAPRESDATA,A1           ; GET MAPS RESTORING DATA

            MOVE.W  #MAPSCRH-1,D5           ; ROW ITERATOR
.LOOPY      MOVE.W  #MAPSCRW-1,D6           ; COLUMN ITERATOR

.LOOPX      MOVE.B  (A1)+,D7                ; RESTORES VALUE   
            MOVE.B  D7,(A0)+                   

            DBRA.W  D6,.LOOPX               ; LOOP FOR ALL COLUMNS
            DBRA.W  D5,.LOOPY               ; LOOP FOR ALL ROWS

            MOVEM.L (A7)+,D5-D7/A0-A1
            
            RTS

; -----------------------------------------------------------------------------
MAPLIFEUPD
; UPDATES THE NUMBER OF LIFES.
; INPUT    - NONE (USES (PLRPOSX) AND (PLRPOSY))
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVEM.L D5-D7/A0-A1,-(A7)
            
            MOVE.L  #MAPBLCOL,D1            ; DECIDE COLOR
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            
            MOVE.W  (LIFENUMBER),D1         ; INITIAL X (REINIT AFTER EACH ROW)
            MULU.W  #32,D1
            SUB.W   #640,D1            
            MOVE.W  #0,D2                   ; INITIAL Y
            MOVE.W  D1,D3
            MOVE.W  D2,D4  
            SUB.W   #MAPTILEW,D3            ; ADD 32 TO X
            ADD.W   #MAPTILEH,D4            ; ADD 32 TO Y
            MOVE.B  #88,D0
            TRAP    #15

            MOVEM.L (A7)+,D5-D7/A0-A1
            
            RTS

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
