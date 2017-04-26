;
; TEMPLOS 1 - Data definitions
;
; 31-1-90
; ========
;________________________________________________________________________
;
;This label says if we have object pictures
#define OPICS PC+AMIGA+ST+PCW    ; I.e. OPICS!=0 if on machine that has them
;Position of objects in graphic database
#define OPicsNDRAW  70 ; oddly enough 70 is for the cajon which has no picture
#define FSRistra    60 ; dibujo de la primera ristra. (magnetica+1 normal)
;
;An emergency label we use debug to give EGA version
;#define EGA DEBUG
;
#define TITLE 26
;
;Now decide which machines get which parts of the program
;
;Autoload of PARTS
#define AUTOMOVE PC+PCW
;
;Large program
#define BIGMEM   ST+AMIGA+PC+PCW+MSX+CBM64
;Large text
#define BIGTEXT  ST+AMIGA+PC+PCW
;
;Versions
;
#if PART1
 #define PARTNO 1
#else
 #define PARTNO 2
#endif
;
;Do we use darkness in this adventure?
#define DARK 0
;
;Extended examines
#define MOREXAM  ST+AMIGA+PC+MSX+CBM64+SPE+CPC+PCW
;
;If we have the introduction screen
#define FACES 0 ;ST+AMIGA+PC+PCW
#define BURNING 0 ;no recursive burning
#define LIQUIDS 0 ;no liquid containers
;
#define STAM    ST+AMIGA
;
;Machines which animate Death
;#define DEATHA 0 ;ST+AMIGA+PC
;
;
;Machines which have a slash seperating the Score and turns
;#define SLASH 0 ;DRAW+PC+ST+AMIGA+PCW
;
#define DISK PC+AMIGA+ST+CPC+CBM64+PCW
#define TAPE CPC+CBM64+SPE+MSX
#define DISKTAPE DISK+TAPE
;
#define COLS80 PC+ST
#if C42
 #define CENTRE 8
#endif
#if C40
 #define CENTRE 6
#endif
#if C53
 #define CENTRE 13
#endif
#if PCW
 #define CENTRE 31
#endif
#if PCW
 #define GRFCOL  0
 #define GRFWDTH 64     ;graphics window width
#else
 #define GRFCOL  1
 #define GRFWDTH 42     ;only necessary in !Draw anyway
#endif
;________________________________________________________________________
;                               Objects
;
;- Contenedores que no tienen dibujo
#define Cajon     0
;- Contenedores que tienen dibujo
#define Bambu     Cajon+1
;- No contenedores que tienen dibujo
#define Remo      Bambu+1
#define PielX     Remo+1
#define Cuerda    PielX+1       ; Cuerda entera
#define Papaya    Cuerda+1
#define Gusano    Papaya+1
#define Contrato  Gusano+1
#define Red       Contrato+1
#define Cuenta1   Red+1         ; Las ocho cuentas normales
#define Cuenta2   Cuenta1+1
#define Cuenta3   Cuenta2+1
#define Cuenta4   Cuenta3+1
#define Cuenta5   Cuenta4+1
#define Cuenta6   Cuenta5+1
#define Cuenta7   Cuenta6+1
#define Cuenta8   Cuenta7+1
#define MCuenta2  Cuenta8+1     ; Las requetecuentas (deben ir en este orden)
#define MCuenta1  MCuenta2+1    ;                    (ver Pro HazRistra)
#define Ristra    MCuenta1+1    ; con una cuenta mas la magn‚tica
#define Collar    Ristra+1
#define Hachuela  Collar+1
#define Hacha     Hachuela+1
#define Fruta     Hacha+1
#define Espina    Fruta+1
#define FruEsp    Espina+1
#define Palo      FruEsp+1      ;fruta atravesada por espina
#define Liana     Palo+1
#define Estaca    Liana+1
#define Cascabel  Estaca+1
#define JaguarK   Cascabel+1    ;muerto
#IF BIGMEM
 #define JaguarD   JaguarK+1     ;despellejado
 #define MonoK     JaguarD+1
 #define MonoD     MonoK+1
 #define PielJ     MonoD+1       ;piel de jaguar
 #define PielM     PielJ+1       ;piel de mono
 #define Tronco1   PielM+1
#ELSE
 #define MonoK     JaguarK+1
 #define Tronco1   MonoK+1
#ENDIF
#define Tronco2 Tronco1+1
#define Tronco3 Tronco2+1
#define Tronco4 Tronco3+1  
#define Runa1   Tronco4+1  ;las runas son en realidad tabletas de arcilla
#define Runa2   Runa1+1    ;as¡ me queda una etiqueta m s corta que 'tabletas'!
#define Runa3   Runa2+1
#define Runa4   Runa3+1
#define Runa5   Runa4+1
#define Runa6   Runa5+1
#define Runa7   Runa6+1
#define Runa8   Runa7+1
;
#define Balsa   Runa8+1
;- No contenedores que no tienen dibujo
;#define Jarron    Balsa+1
#DEFINE LASTOBJ Balsa
;
;_________________________________________________________________________
;                               Flags
#define Work3      64
#define Work4      Work3+1
#define Work5      Work4+1
#define Work6      Work5+1
#define HayPic     Work6+1    ; Text or Graphics (0-Text, else no of pic on screen)
#define APending   HayPic+1   ; Message outstanding
#define OldVerb    APending+1 ; Used to repeat verb if requested
#define OldNoun1   OldVerb+1
#define OldNoun2   OldNoun1+1
#define OldAdj1    OldNoun2+1
#define OldAdj2    OldAdj1+1
#define OldAdv     OldAdj2+1
#define OldPrep    OldAdv+1
#define Poisoned   OldPrep+1  ; Player gonna die
#define BarcaLoc   Poisoned+1 ; Position of boat
#define HayFoso    BarcaLoc+1 ; 0=Foso not found yet
#define Empalado   HayFoso+1  ; 255=empalado en foso
#define Jaguar     Empalado+1 ; 255=jaguar muerto
#define Mono       Jaguar+1   ; 255=mono muerto
#define MonoEx    Mono+1      ; 255=mono examinado ya
#define CajonF    MonoEx+1    ; 0=cajon cerrado
#define TrunkCt   CajonF+1    ; cuenta troncos cortados
#define BalsaCt   TrunkCt+1   ; cuenta troncos en balsa
#define RistraCt  BalsaCt+1   ; cuenta cuentas normales en ristra
#define LastLink  RistraCt+1  ; ultimo eslabon de la ristra
#define AtaNum1   LastLink+1  ; Num. objeto atado a liana
#define AtaLoc1   AtaNum1+1   ; localidad en la que est 
#define AtaNum2   AtaLoc1+1   ; lo mismo para la otra punta de la liana
#define AtaLoc2   AtaNum2+1   ; ditto
#define Cuelgade  AtaLoc2+1   ; si <>0 loc de la que cuelga la liana
#define Cuelga2   Cuelgade+1  ; sysmes con direccion de la que cuelga
#define AtBalsa   Cuelga2+1  ; =255 si est  en la balsa
#define AhogTrn   AtBalsa+1   ; turnos para ahogarse en cenote
#define PlazaF    AhogTrn+1   ; =255 si ya ha estado en la plazoleta
#define LosaF     PlazaF+1    ; =1 sabe que hay losa/=255 ha levantado la losa
#define EnLabe    LosaF+1     ;=255 si esta entre plaza y cenote (inclusive)
#define FBN       EnLabe+1    ;estas cuatro contienen el num. de bloques
#define FBS       FBN+1       ;en cada pared si estamos en el laberinto
#define FBE       FBS+1       ;(son la salida del pro RBit)
#define FBO       FBE+1
#define EnAhogo   FBO+1       ;=255 si en una localidad con agua donde ahogarse
#define StormT    EnAhogo+1   ;para la tormenta en la barca
#define IndioT    StormT+1    ;para que se muera el indio
#define Remoatado IndioT+1    ;=255 si remo atado a cuerda
#define TeDio     Remoatado+1 ;=255 si el indio acab de darte algo
;poner juntas las tablas a inicializar con EXTERN en Z80
#define RunaT     TeDio+1     ;locs donde dejar las runas (8 bytes)
#define NBloqT    RunaT+8     ;tabla con num. bloques por pared (11 bytes)
#define BloqTT    NBloqT+11   ;t con flag comz de la tabla de cada estancia (11)
#define TPlaza    BloqTT+11
#define TL1       TPlaza+4
#define TL2       TL1+3
#define TL3       TL2+6
#define TL4       TL3+3
#define TL5       TL4+3
#define TL6       TL5+4
#define TL7       TL6+3
#define TL8       TL7+4
#define TL9       TL8+3
#define TL10      TL9+3         ;siguiente TL10+1
#define Tunel0    TL10+1        ;puertas en las estancias interconexas
#define Tunel1    Tunel0+1
#define Tunel2    Tunel1+1
#define Tunel3    Tunel2+1
#define Tunel4    Tunel3+1
#define Tunel5    Tunel4+1
#define Tunel6    Tunel5+1
#define Tunel7    Tunel6+1
#define Tunel8    Tunel7+1
#define Tunel9    Tunel8+1
#define Tunel10   Tunel9+1
;
#define YaL10   Tunel10+1       ;=255 L10 already visited so enable SAVES
;
;----
;
#define ThisPSI 220           ; PSI's indirection
#define PSI0    ThisPSI+1     ;para comienzo tabla PSIs
#define Indio   PSI0
#define Kuill   Indio+5
;
; Object graphics
;
#define FirstOF 240     ; Space for 6 objects in graphics section
#define LastOF  245
#define OPoint  246     ; Pointer to table
;
#define Piccies 253     ; Pictures on/off (0-on, 255-off)
#define ThisPart 254    ; Counter for Init and part number
#define DoneOnce   255  ; We have initialised once
;________________________________________________________________________
;                      Processes
;
#define Main            0
#define MainLoop        Main+1
#define EachDesc        MainLoop+1
#define EachMove        EachDesc+1
#define Response        EachMove+1
#define Init            Response+1
#define Status          Init+1
#if OPICS
 #define PicInv          Status+1
 #define GetPic          PicInv+1
 #define DropPic         GetPic+1
 #define OPatch          DropPic+1
 #define ORender         OPatch+1
 #define OSetThis        ORender+1
 #define OClearThis      OSetThis+1
 #define OFindIt         OClearThis+1
 #define Salidas         OFindIt+1         ;3
#else
 #define Salidas         Status+1         ;3
#endif
#define DoorChk         Salidas+3
#define Examine         DoorChk+1
#define Closed          Examine+1
#define Open            Closed+1
#define AdjSex          Open+1
#IF !DRAW
 #define DoLoad          AdjSex+1
 #define Slide           DoLoad+1        ; Introduce new picture-SPAUSE is speed
#ELSE
 #define Slide           AdjSex+1        ; Introduce new picture-SPAUSE is speed
#ENDIF
#define Graphic         Slide+1         ; Change mode if needed
#if PC
 #if EGA
  #define SPAUSE 2
 #else
  #define SPAUSE 5
 #endif
#else
 #if AMIGA
  #define SPAUSE 4
 #else
  #define SPAUSE 2
 #endif
#endif
#define CAnykey         Graphic+1       ; Anykey was pending for mode change
#define SetText         CAnykey+1       ; Sets up text mode
#define MakeO2          SetText+1       ; Makes CO2 data contain that for NOUN2
#define Inside          MakeO2+1        ; List contents of container
#define Hachas          Inside+1        ; distingue entre hacha y hachuela
#define ObjMov          Hachas+1
#define ObjCt           ObjMov+1
#define CreaGet         ObjCt+1
#define Tied            CreaGet+1
#define RBits           Tied+1
#define ProBloques      RBits+1
#define Tetira          ProBloques+1
#define DiDaToma        Tetira+1
;
#define LastLen         1               ; only one table long
;
;_________________________________________________________________________
;                           Localidades
#define INDIO     4  ;lo que lleva el indio
#define RISTRA    5  ;aqui meto las cuentas
#define BALSA     6  ;aqui los troncos
#define LIMBO     7  ; For not yet created objs that can only be created once
#define MUERTE    8
;
#define Barca   9
;
#define MarI    10 ;Mar inicial
#define MarT    11 ;Mar tormenta
#define MarH    12 ;Mar hambre
#define Playa2  13 ;Mar arrecifes
#define Playa   14
#define Frente  15
#define Derruid 16
#define Altar   17
#define Selva1  18
#define Selva2  19
#define Selva3  20
#define Selva4  21
#define Foso    22
#define Selva5  23
#define Plaza   24
#define L1      25
#define L2      26
#define L3      27
#define L4      28
#define L5      29
#define L6      30
#define L7      31
#define L8      32
#define L9      33
#define L10     34
#define Cenote  35
#define AhogoI  36 ;Ahogo porque te tira el indio
#define AhogoM  37 ;Ahogo al caer al mar desde el cenote
#define AhogoC  38 ;Ahogo al tirarte al cenote
;
;Valid short locations for this part
;
#define FSLoc  9        ; first valid loc       $$$ provisional
#define LSLoc 38        ; last valid short desc $$$ provisional
;
#define LVLoc 38        ; last valid loc        $$$ provisional
;
;Locations where things happen
;
;_________________________________________________________________________
;                               Misc
;
#define MAXOBJS 6       ; Max objects you can carry
#define LastPSI Kuill   ; Double definition for two systems of looping
#define NumPSIs 2
#define PSIINC  5       ; Number of flags per PSI
;
; - Windows
;
; 0 - Graphics rendering (main)
; 1 - Text & Input
; 2 - Area of all objects & graphics (with default colours)
; 3 - Status line
; 4 - Area of objects only
; 5 -
; 6 - Object rendering 16 Bit
; 7 - Whole screen clear
;
