; TEMPLOS
;
; Usa Work5 y Work6
;
#ECHO Routines to handle object pictures
;________________________________________________________________________
;
/PRO PicInv ;Clear and draw inventory area
;
; Screen is clear on entry if we are changing modes
;
;There are two methods of rendering the inventory
;1/ Non drawstring
;The window is placed at the required position (i.e. next free one)
;and the required object graphic is drawn
;2/ Drawstring - not used as we don't have any
;As method one but the window is cleared and a picture drawn which
;consists of a plot for the given window (bottom left). This allows
;the graphics to appear in any window.

_       _       NOTZERO HayPic          ; Not Changing modes
                DONE                    ; so do nothing

_       _       SET     HayPic          ; Fool GetPic
                SET     FirstOF
                SET     FirstOF+1
                SET     FirstOF+2
                SET     FirstOF+3
                SET     FirstOF+4
                SET     FirstOF+5
                CLEAR   Work5           ;contador

$INVLOOP
_       _       SETCO   [Work5]         ; Ensure CO is set up
                CARRIED [Work5]
                PROCESS GetPic          ; Display current object

_       _       NOTEQ   Work5   LASTOBJ
                PLUS    Work5   1
                SKIP    $INVLOOP
;________________________________________________________________________
/PRO GetPic  ;Graphic inventory control - GET CO

_       _       NOTZERO HayPic          ; Text mode, so do nothing
                WINDOW  6
                PROCESS OSetThis        ; Sets position to next free
                PROCESS OClearThis
                COPYFF  CONum Work6
                PROCESS ORender
                ISDONE
                COPYBF  [OPoint] CONum
;________________________________________________________________________
/PRO DropPic ;Graphic inventory control - DROP

_       _       NOTZERO HayPic          ; Text mode, so do nothing
                PROCESS OFindIt         ; Find the object
                ISDONE                  ; If it was there
                WINDOW  6
                PROCESS OClearThis      ; Clear space

_       _       WINDOW  1
;________________________________________________________________________
/PRO OPatch     ; Patches CO if drawn to be Objno Work6

_       _       NOTZERO HayPic
                PROCESS OFindIt         ; Find object
                ISDONE
                WINDOW  6
#IF !DRAW
                GFX     0       1       ;phys to back
                GFX     0       4       ;graf to back
#ENDIF
                COPYFF  Work6   Work5
                PROCESS OClearThis
                COPYFF  Work5   Work6
                PROCESS ORender
                COPYFF  Work5   Work6
#IF !DRAW
                GFX     0       0       ;back to phys
                GFX     0       3       ;graf to phys
#ENDIF
                ISDONE
                COPYBF  [OPoint] Work6  ; Object patch
;________________________________________________________________________
/PRO ORender    ;draws object in Work6
;ojo, hay que estar ya en la ventana 6 y actualizar la tabla de objetos aparte
;sale con DONE si lo hizo


_       _       ZERO HayPic             ; Text mode, so do nothing
                NOTDONE

#IF PART1
 _      _       EQ      Work6 Ristra      ;la ristra tiene dibujo variable
                LET     Work6 FSRistra-1  ;segun el numero de cuentas
                ADD     RistraCt Work6
                SKIP    $RISTRA
#ENDIF

_       _       PLUS    Work6   OPicsNDRAW

$RISTRA
_       _       PICTURE [Work6]         ; See if there is a picture
                DISPLAY 0               ; If so display
                WINDOW  1
                DONE

_       _       WINDOW  1
                NOTDONE

;________________________________________________________________________
/PRO OSetThis   ; Sets pointer flags to next free position in table

_       _       LET     OPoint  FirstOF

_       _       NOTEQ   [OPoint] 255
                PLUS    OPoint  1
                LT      OPoint  LastOF+1
                SKIP    -1
;________________________________________________________________________
/PRO OClearThis ; Clears the position given by OPoint (On drawstring sets
;                 the current position to starting point as well)
_       _       COPYFF  OPoint  Work6
                PICTURE [Work6]         ; Must exist and will be buffered
                DISPLAY 0               ; Do the display
                SET     [OPoint]        ; Position is clear
;________________________________________________________________________
/PRO OFindIt    ; Sets pointer flags to position of current object
; Returns DONE if found
_       _       LET     OPoint  FirstOF

_       _       SAME    [OPoint] CONum
                DONE

_       _       PLUS    OPoint  1
                LT      OPoint  LastOF+1
                SKIP    -2

_       _       NOTDONE
