; =============================================================================
; GAME VARS
; =============================================================================

; --- GAME STATE RELATED VARIABLES --------------------------------------------

STACUR      DS.W    1                       ; CURRENT GAME STATE
STANEXT     DS.W    1                       ; NEXT GAME STATE

; --- PLAYER RELATED VARIABLES ------------------------------------------------

PLRPOSX     DS.W    1                       ; PLAYER X POSITION (PIXELS)
PLRPOSY     DS.W    1                       ; PLAYER Y POSITION (PIXELS)
PLRTLIFE    DS.W    1                       ; PLAYER LIFE
PLRSCORE    DS.W    1                       ; PLAYER SCORE
PLRDMG      DS.B    1                       ; BIT0: UPD DAMAGE, BIT1 PLOT DMG
            DS.W    0

; --- UTILITY VARIABLES ------------------------------------------------------

UTLRNDIX    DS.B    1                       ; NEXT INDEX TO RANDOM NUMBER
            DS.W    0
            
; --- MAP RELATED VARIABLES --------------------------------------------------

MAPPOSX     DS.W    1                       ; CURRENT SCREEN X
MAPPOSY     DS.W    1                       ; CURRENT SCREEN Y
MAPSCPTR    DS.L    1                       ; CURRENT SCREEN POINTER
MAPNUMEN    DS.W    1                       ; NUMBER OF LIVING ENEMIES IN SCR

; --- GHOST RELATED VARIABLES ------------------------------------------------

GHOSTNUMBER DS.W    1

; --- LIFE RELATED VARIABLES ------------------------------------------------

LIFENUMBER  DS.W    1

; --- AUDIO RELATED VARIABLES ------------------------------------------------

AUDACCSN    DS.B    1                       ; ACCEPT NEW SOUNDS?
            DS.W    0



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
