; =============================================================================
; TITLE    : PACMAN
; AUTHOR   : DAVID SANTOME && ALEJANDRO TORRENTE
; CREATION : 06-FEBRERO-2020
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; USER CONSTANTS
            INCLUDE "UTIL.X68"              ; UTILITY MACRO AND SUBROUTINES
            INCLUDE "PLAYER.X68"            ; PLAYER MANAGEMENT
            INCLUDE "AGENT.X68"             ; AGENT MANAGEMENT
            INCLUDE "AGENTLST.X68"          ; AGENT LIST MANAGEMENT
            INCLUDE "GHOST.X68"             ; GHOST AGENT MANAGEMENT
            INCLUDE "SPAWNER.X68"           ; SPAWNER (CREATES ASTEROIDS)
            INCLUDE "STATES.X68"            ; GAME STATES MANAGEMENT
            INCLUDE "MAP.X68"               ; MAP
            INCLUDE "MAPDATA.X68"           ; MAPDATA
            INCLUDE "AUDIO.X68"             ; AUDIO
            
; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM CODE
            JSR     STAINIT                 ; INITIALIZE GAME STATE
            JSR     AUDINIT                     

; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD
            JSR     STAUPD                  ; UPDATE DEPENDING ON THE STATE
            MOVE.W  #60000,D0
.WLOOP      NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            DBRA    D0,.WLOOP

; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT, IF ( (SCRINTCT) == 0 )
            BEQ     .WINT                   ; ORDINARY WAIT 
            SUBQ.B  #1,(SCRINTCT)           ; ELSE { (SCRINTCT) --
            TST.B   (SCRINTCT)              ; IF ( (SCRINTCT) == 0 )
            BEQ     .UPDATE                 ; UPDATE
            CMPI.B  #MAXFDROP,(SRCFCOUNT)   ; ELSE { SRCFCOUNT - MAXFDROP
            BGE     .UPDATE                 ; IF ( SRCFCOUNT >= 5, THEN UPDATE )
            ADDQ.B  #1,(SRCFCOUNT)          ; ELSE { (SRCFCOUNT) ++
            BRA     .LOOP                   ; DO NOT UPDATE

; --- PLOT --------------------------------------------------------------------

.UPDATE     CLR.B   (SCRINTCT)              ; RESET (SCRINTCT)
            CLR.B   (SRCFCOUNT)             ; RESET (SRCFCOUNT)
            JSR     STAPLOT                 ; PLOT DEPENDING ON THE STATE
            TRAP    #SCRTRAP                ; SHOW GRAPHICS                     
            BRA     .LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START
















































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
