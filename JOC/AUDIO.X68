; =============================================================================
; AUDIO MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
AUDINIT
; INITALIZES THE AUDIO MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A2,-(A7)
            LEA     .AUDLIST,A0
            LEA     .IDLIST,A2
.LOOP       MOVE.L  (A0)+,D0                ; LOAD ALL AUDIO FILES
            BEQ     .END
            MOVE.B  (A2)+,D1
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            BRA     .LOOP
.END        MOVE.B  #AUDACCY,(AUDACCSN)     ; START BY ACCEPTING SOUNDS
            MOVEM.L (A7)+,D0-D1/A0-A2
            RTS
.AUDLIST    DC.L    .MUSIC1,.MUSIC2,.MUSIC3,.SOUND1,0
.MUSIC1     DC.B    'SND/PACINTRO.WAV',0
.MUSIC2     DC.B    'SND/PACGOV.WAV',0
.MUSIC3     DC.B    'SND/MUSIC3.WAV',0
.SOUND1     DC.B    'SND/PACSOUND.WAV',0
.IDLIST     DC.B    AUDMU1ID,AUDMU2ID,AUDMU3ID,AUDSN1ID
            DS.W    0

; -----------------------------------------------------------------------------
AUDPLAY
; CHANGES AUDIO TO PLAY
; INPUT    - D1.B   BIT 7=1 LOOP, BIT 7=0 PLAY ONLY ONCE
;                   BITS 6-0 SOUND ID
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP.B   #AUDACCN,(AUDACCSN)     ; CHECK IF SOUNDS ACCEPTED
            BEQ     .END                    ; NO: END
            MOVEM.L D0-D2,-(A7)
            MOVE.B  #76,D0
            MOVE.L  #3,D2
            TRAP    #15                     ; STOP ALL SOUNDS
            CLR.L   D2
            BCLR    #7,D1                   ; CLEAR MSB AND CHECK
            BEQ     .CONT                   ; IF ZERO, CONTINUE
            ADDQ.W  #1,D2                   ; IF ONE, ACTIVATE LOOP
.CONT       CMP.B   #AUDENDID,D1            ; IS IT STOP SOUND ID?
            BEQ     .DONE                   ; NOT PLAY
            MOVE.B  #76,D0                  ; SELECT STANDARD PLAYER
            TRAP    #15                     ; AND PLAY
.DONE       MOVEM.L (A7)+,D0-D2
.END        RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
