; =============================================================================
; SYSTEM CONSTANTS
; =============================================================================

; --- GAME STATES -------------------------------------------------------------

STANONE     EQU     -1                      ; PLACEHOLDER TO FORCE CHANGE
STAINTR     EQU     0                       ; INTRO/PRESS FIRE STATE
STAPLAY     EQU     1                       ; NORMAL GAME STATE
STAGOVR     EQU     2                       ; GAME OVER STATE
STAVICT     EQU     3                       ; VICTORY STATE
; --- AGENT TYPES -------------------------------------------------------------

GHOSTTYPE   EQU     1                       ; GHOST

; --- AUDIO RELATED CONSTANTS -------------------------------------------------

AUDMU1ID    EQU     0                       ; ID OF ATTRACT MODE MUSIC
AUDMU2ID    EQU     1                       ; ID OF GAME OVER MUSIC
AUDMU3ID    EQU     2                       ; ID OF VICTORY MUSIC
AUDSN1ID    EQU     3                       ; ID OF EATING BALLS
AUDENDID    EQU     $FF                     ; ID TO STOP ALL SOUNDS
AUDMSKLP    EQU     $80                     ; LOOP AUDIO MASK
AUDMSKNL    EQU     $00                     ; NO LOOP AUDIO MASK
AUDACCY     EQU     $FF                     ; ACCEPT PLAYING NEW SOUND
AUDACCN     EQU     $00                     ; DO NOT PLAY NEW SOUND

; --- PLAYER RELATED CONSTANTS ------------------------------------------------

PLRWIDTH    EQU     20                      ; PLAYER WIDTH (PIXELS)
PLRHEIGH    EQU     20                      ; PLAYER HEIGHT (PIXELS)
PLRLIFE     EQU     1                       ; PLAYER INITIAL LIFE (<SCRWIDTH)
PLRSPEED    EQU     32                      ; PLAYER SPEED (PIXELS PER INT)
PLRNRMCL    EQU     $0000C0FF               ; PLAYER NORMAL COLOR
PLRTXTCL    EQU     $00FFFFFF               ; FONT COLOR
EYECOLOR    EQU     $00000000               ; EYE COLOR
EYEPOS      EQU     14                      ; EYE POSITION              
EYEWIDTH    EQU     4                       ; EYE WIDTH
EYEHEIGH    EQU     4                       ; EYE HEIGHT
MOUTHPOS    EQU     8                       ; MOUTH POS
MOUTHWIDTH  EQU     6                       ; MOUTH WIDTH
MOUTHHEIGH  EQU     3                       ; MOUTH HEIGHT
PLRTXTX     EQU     2                       ; SCORE X COORDINATE
PLRTXTY     EQU     1                       ; SCORE Y COORDINATE
PLRUMDMG    EQU     %00000001               ; UPDATE DAMAGE MASK
PLRPMDMG    EQU     %00000010               ; PLOT DAMAGE MASK
PLRUBDMG    EQU     0                       ; UPDATE DAMAGE BIT
PLRPBDMG    EQU     1                       ; PLOT DAMAGE BIT

; --- GHOST RELATED CONSTANTS ----------------------------------------------

GHOSTSIZE   EQU     20                      ; GHOST DIAMETER
GHOSTPENCL  EQU     $00FFFFFF               ; GHOST PEN COLOR
GHOSTFILCL  EQU     $0000FF00               ; GHOST FIL COLOR
GHOSTDMG    EQU     1                       ; GHOST DAMAGE TO PLAYER
GHOSTONEX   EQU     582                     ; UPPER RIGHT CORNER
GHOSTONEY   EQU     40                      ; UPPER RC
GHOSTTWOX   EQU     42                      ; DOWN LEFT CORNER
GHOSTTWOY   EQU     420                     ; DOWN LC
GHOSTTHREEX EQU     582                     ; DOWN RC
GHOSTTHREEY EQU     420                     ; DOWN RC
GHOSTSPEED  EQU     32                      ; GHOST SPEED

; --- BALL RELATED CONSTANTS ----------------------------------------------

BALLSIZE    EQU     10                      ; BALL DIAMETER
BALLPENCL   EQU     $000000FF               ; BALL PEN COLOR
BALLSCORE   EQU     1                       ; POINTS PER BALL

; --- AGENT RELATED CONSTANTS -------------------------------------------------

AGNWIDTH    EQU     32                      ; AGENT WIDTH
AGNHEIGH    EQU     32                      ; AGENT HEIGHT
AGNBBXO     EQU     4                       ; BOUNDING BOX X OFFSET
AGNBBYO     EQU     4                       ; BOUNDING BOX Y OFFSET
AGNGACC     EQU     $0001F000               ; GRAVITY ACCELERATION (FIXED PNT)
AGNJMPSP    EQU     $FFEE0000               ; JUMPING INITIAL SPEED

; --- INTRO STATE RELATED CONSTANTS -------------------------------------------

INTTITX     EQU     36                      ; TITLE X COORDINATE
INTTITY     EQU     5                       ; TITLE Y COORDINATE
INTTITC     EQU     $0000C0FF               ; TITLE COLOR
INTPRSX     EQU     31                      ; PRESS FIRE X COORDINATE
INTPRSY     EQU     26                      ; PRESS FIRE Y COORDINATE
INTPRSC     EQU     $0000C0FF               ; PRESS FIRE COLOR

; --- GAME OVER STATE RELATED CONSTANTS ---------------------------------------

GOVSTRX     EQU     35                      ; TITLE X COORDINATE
GOVSTRY     EQU     15                      ; TITLE Y COORDINATE
GOVSTRC     EQU     $000000FF               ; TITLE COLOR

; --- VICTORY STATE RELATED CONSTANTS ---------------------------------------

VICTSTRX    EQU     35                      ; TITLE X COORDINATE
VICTSTRY    EQU     15                      ; TITLE Y COORDINATE
VICTSTRC    EQU     $0000C0FF               ; TITLE COLOR

; --- FRAME RATE RELATED CONSTANTS ---------------------------------------

TFRAMEX     EQU     55                      ; FRAME RATE X COORDINATE
TFRAMEY     EQU     1                       ; FRAME RATE Y COORDINATE
MAXFDROP    EQU     5                       ; MAX FRAME DROP

; --- MAP RELATED CONSTANTS ---------------------------------------------------

MAPINIX     EQU     0                       ; X OF INITIAL SCREEN
MAPINIY     EQU     0                       ; Y OF INITIAL SCREEN
MAPSCRW     EQU     20                      ; TILES PER SCREEN HORIZONTALLY
MAPSCRH     EQU     15                      ; TILES PER SCREEN VERTICALLY
MAPTILEW    EQU     32                      ; SIZE OF TILE, HORIZONTALLY
MAPTILEH    EQU     32                      ; SIZE OF TILE, VERTICALLY
MAPBLCOL    EQU     $00FF0000               ; BLOCK COLOR BLUE
MAPGRCOL    EQU     $00000000               ; GROUND COLOR BLACK




































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
