;
;
;******************************************************************************
;                                  *                    #  # # # #
;  11-10-90  Comenzado             *                  # #  #       #
;  --------                        *                #   #  #        #
;  31-1-90   Fecha                 *      #       #     #  #         #
;  --------                        *    # # # # # # # # #  #        #
;                                  *      #   #         #  #       #
;                                  *        #           #  # # # #
;******************************************************************************
;
;               T E M P L O S   S A G R A D O S  -  P a r t e  I
;
;                             Using DAAD Version 2
;
;                         All that design shit: Andres
;                           The hard bit: Juan Manuel
;                     Drawing some pictures: Paco & Carlos.
;
;******************************************************************************
#include c:\daad\symbols.sce
#if Z80
 #include c:\daad\symbols.z80
#endif
/CTL    
_       
;
#define PART1 TRUE      ; We are part1
#define PART2 FALSE     ; Don't want data for part2
;#define VOCCHK TRUE     ; Check parse input
#define VOCCHK FALSE    ; Don't check parse input
;________________________________________________________________________
;                          Declaracion de datos
#include TD.SCE
;________________________________________________________________________
#IF Z80
 ;                    Inicializacion de tablas en Z80
 #dbaddr TabsData
 ;locs en las que hay que dejar los sellos (RunaT)
 #defb   L9 L2 L5 L3 L6 L7 L1 L8
 ;distribucion de los bloque moviles (BloqNT)
 #defb 130 69 204 84 84 40 21 34 81 81 64
 ;comienzos de las tablas de cada loc (BloqTT)
 #defb TPlaza TL1 TL2 TL3 TL4 TL5 TL6 TL7 TL8 TL9 TL10
 ;dichas tablas
 #defb 0 1 1+128 0+128          ;TPlaza
 #defb 0 0+128 1+128            ;TL1
 #defb 4 3 2+128 4+128 2 3+128  ;TL2
 #defb 2+128 3+128 2            ;TL3
 #defb 4+128 3+128 3            ;TL4
 #defb 6+128 5 6 5+128          ;TL5
 #defb 5 5+128 6+128            ;TL6
 #defb 7+128 8+128 7 8          ;TL7
 #defb 8+128 7 7+128            ;TL8
 #defb 8+128 9 8                ;TL9
 #defb 10                       ;TL10
 #dbaddr LastAdd
 #define TabsLen LastAdd-TabsData
 ;
 #extern
 ;
 #defb   PUSH_BC   ;se llama con EXTERN RunaT 0
 #defb   EX_DE_HL  ;DE=flag a partir del que empiezan las tablas
 #defb   LD_BC_nn
 #defw   TabsLen
 #defb   LD_HL_nn
 #defw   TabsData
 #defb   ED
 #defb   LDIR
 #defb   POP_BC
 #defb   RET
#ENDIF
;________________________________________________________________________
/TOK                    ;Text Tokens
#IF BIGMEM
 #include T1B.TOK
#ELSE
 #include T1S.TOK
#ENDIF
;________________________________________________________________________
;                               Vocabulary
/VOC
;       -Movements ie verbs and nouns < 14
;       -if it is a direccion you can order to a character = PSI
;
N       1       noun
NORTE   1       noun
S       2       noun
SUR     2       noun
E       3       noun
ESTE    3       noun
O       4       noun
OESTE   4       noun
NE      5       noun
NORESt  5       noun
NO      6       noun
NOROEs  6       noun
SE      7       noun
SURESt  7       noun
SO      8       noun
SUROEs  8       noun
ARRIBa  9       verb
AR      9       verb
SUBIR   9       verb
SUBE    9       verb
SUBO    9       verb
BAJAR   10      verb
BAJA    10      verb
BAJO    10      verb
ABAJO   10      verb
AB      10      verb
ENTRAr  11      verb    ; also for ENTRA
ENTRO   11      verb
SALIR   12      verb
SALGO   12      verb
SAL     12      verb
SALTAr  13      verb
SALTO   13      verb
;
;*N.B.* COMO is not a synonym here, it is made thus in Response
;as we need it for COMO TE LLAMAS, which should have an accent but
;nobody will use it
;Note that LLAMAr/s will be the verb and COMO the noun!
;COMO    39      noun
;C¢MO    39      noun
;
;       -Verbs-
;
;Start at 40 so as not to conflict with conversion nouns
;
ESPERar 40      verb    ;-Wait
;
EXCAVar 41      verb    ;para encontrar foso
CAVAR   41      verb
CAVA    41      verb
CAVO    41      verb
#IF BIGMEM
 PATEAr 41      verb
 PATEO  41      verb
#ENDIF
;
;SEGUIr  42      verb
;SIGO    42      verb
;
QUIERo  43      verb
DAME    43      verb
DEME    43      verb
;
#if DEBUG
 mv     43      verb ;mover bloque en estancias
#endif
;
TIRAR   44      verb    ;- tirar estaca fuera del foso
TIRA    44      verb
TIRAL   44      verb
#IF BIGMEM
 T¡RAL  44      verb
#ENDIF
TIRO    44      verb
LANZAr  44      verb
LANZO   44      verb
ARROJar 44      verb
;
REMAR   45      verb
REMA    45      verb
;
DIBUJos 46      verb    ; &a - select text/graphics mode
GRAFIco 46      verb
;
TEXTO   47      verb
;
DAR     48      verb    ;-Give
DA      48      verb
DASELo  48      verb
DARSElo 48      verb
#if BIGMEM
 D SELo  48      verb
 D RSElo 48      verb
#endif
DALE    48      verb
DOY     48      verb
;
#IF BIGMEM
 BESAR   49      verb    ;-Kiss
 BESA    49      verb
 BESO    49      verb    ;
#ENDIF
;
;
SALIDas 50      verb
X       50      verb    ;poner en instrucciones &a
;
;CUANTO  51     verb    ;-how much (to buy boat, or bill)
;
SR      52      verb
RS      52      verb
RL      53      verb
LR      53      verb
#if BIGTEXT
 AD     56      verb
#else
 #if PART2
  AD     56      verb
 #endif
#endif
;
MOVER   57      verb
MUEVE   57      verb
MUEVO   57      verb
ARRAS   57      verb
EMPUJar 57      verb
LEVANta 57      verb
#IF BIGMEM
 APRETar  57      verb
 APRIEta  57      verb
 PRESIona 57      verb
 HUNDIr   57      verb
#ENDIF
;
PISAR   58      verb    ;bloque en L10
PISA    58      verb
PISO    58      verb
PISALo  58      verb
;
;59
;
;60-63
;
PONER   64      verb    ;-Put
PONTE   64      verb
PONGO   64      verb
PON     64      verb
PONLO   64      verb
PONLA   64      verb
;
NADAR   65      verb    ;-Swim
NADO    65      verb
NADA    65      verb    ; the word nothing
;
ATAR    66      verb
ATARL   66      verb
ATO     66      verb
ATA     66      verb
ATALA   66      verb
ATALE   66      verb
ATALO   66      verb
AMARRar 66      verb
;
DESATar 67      verb
;
#IF BIGMEM
 GRACI   68      verb    ;-Thanks
#ENDIF
;
;ADIOS   69      verb    ;-Goodbye (can use a system message)
;
#IF BIGMEM
 DESPEllejar 70  verb    ;-bichos
#ENDIF
;
;HOLA    71      verb    ;-Hello
;BUENOs  71      verb
;BUENAs  71      verb
;
;
#define SoplaW  73
SOPLAr  73      verb    ;de momento sin¢nimos para la cerbatana
SOPLO   73      verb
DISPAra 73      verb
;
CORTAr  74      verb
CORTO   74      verb
TALAR   74      verb
;TALA    74      verb   ;quitados por problema con 'lo' y 'la'
;TALO    74      verb
TALAL   74      verb
;
COGER   75      verb    ;-Get
COGE    75      verb
COGEL   75      verb
COJO    75      verb
AGARR   75      verb
;
DEJAR   76      verb    ;-Drop
DEJA    76      verb
DEJAL   76      verb
DEJO    76      verb
SOLTAr  76      verb
SUELTa  76      verb
;
I       77      verb    ;-I
INVENT  77      verb    ;-I
;
#define MirarW  78
M       78      verb    ;-Look
MIRAR   78      verb
MIRA    78      verb
MIRO    78      verb
R       78      verb
REDEScr 78      verb
#IF BIGMEM
 DESCRi  78      verb
 L       78      verb
#ENDIF
;
FIN     79      verb    ;-Quit
F       79      verb
#if BIGMEM
 ACABAr  79      verb
 ACABO   79      verb
 RENDIr  79      verb
 RINDO   79      verb
 RINDEt  79      verb
 TERMIn  79      verb
#ENDIF
;
EX      80      verb    ;-Examine
EXAMIn  80      verb
LEER    80      verb    ;-read
LEERL   80      verb
LEO     80      verb
LEE     80      verb
LEELO   80      verb
LEELA   80      verb
;
ARRANca 81      verb    ;-espina de cactus
;
QUITAr  82      verb    ;-Remove (clothing)
QUITO   82      verb
;
METER   83      verb    ;-Insert
METE    83      verb
METEL   83      verb
METO    83      verb
#IF BIGMEM
 INTROdu 83      verb
#ENDIF
;
SACAR   84      verb    ;-Remove
SACA    84      verb
SACAL   84      verb
SACO    84      verb
;
SAVE    85      verb    ;-Save
GRABAr  85      verb
GRABO   85      verb
;
LOAD    86      verb    ;-load
CARGAr  86      verb
CARGO   86      verb
;
HACER   87      verb    ;-hacer hacha, balsa
HAZ     87      verb
HAGO    87      verb
CONSTR  87      verb
ARMAR   87      verb
ARMA    87      verb
ARMAL   87      verb
ARMO    87      verb
MONTAr  87      verb
MONTO   87      verb
;
DESHAz  88      verb
DESTRui 88      verb
DESARma 88      verb
DESMOnt 88      verb
;
DECIR   89      verb    ;-Say
DIGO    89      verb
DI      89      verb
DILE    89      verb    ;PSI
DICIE   89      verb
DIJE    89      verb
DICES   89      verb    ;PSI...Que dices?
HABLAr  89      verb    ;HABLO es un sustantivo (-LO no funciona)
PREGUnt 89      verb    ;question
;
ABRIR   90      verb    ;-Open
ABRO    90      verb
ABRE    90      verb
ABREL   90      verb
;
CERRAr  91      verb    ;-Shut
CIERRo  91      verb
;
SALVA   92      verb    ;al indio
SALVO   92      verb
;
;93-96
;
LUCHO   97      verb    ;-Fight &a can we remove some of these
LUCHAr  97      verb
MATAR   97      verb    ;kill
MATA    97      verb
MATO    97      verb
MATALo  97      verb    ;to order someone to kill someone
M TALa  97      verb
GOLPEar 97      verb    ;hit
ATACAr  97      verb    ;attack
ATACO   97      verb
PEGAR   97      verb
PEGO    97      verb
PEGA    97      verb
CLAVA   98      verb    ;espina en fruta
CLAVO   98      verb    ;espina en fruta
;PINCHA  98      verb    ;espina en fruta (ya hay un nombre 'pincho')
#IF BIGMEM
 ENSARTA 98      verb
#ENDIF
;
PEDIR   99      verb    ;-Ask (for)
PIDO    99      verb
PIDE    99      verb
;
TOMA    100     verb    ;PSI
TOMAL   100     verb
TEN     100     verb    ;PSI
TOME    100     verb    ;PSI    de usted
TOMEL   100     verb    ;PSI    de usted
;
;101-109
;
COMER   110     verb    ;-you'll like this one
COME    110     verb
COMO    110     verb    ;no tenemos "c¢mo te llamas"
COMETe  110     verb
COMEL   110     verb
;
;
;
;
;       -Nouns-
;
;       <40 means can be used as verbs
;
SI      19      noun
#IF BIGMEM
 VALE    19      verb
#ENDIF
;
;
;       <50 means a proper noun ie not an 'IT'
;
TODO     49     noun
;
; Object Nouns
;
REMO     50     noun
#define CuerdaW 51
CUERDa   51     noun
;52
;53
PAPAYa   54     noun
GUSANo   55     noun
;56
CONTRato 57     noun
PAPEL    57     noun
#define RedW 58
RED      58     noun
CUENTa   59     noun
COLLAr   60     noun
#IF BIGMEM
 OBSIDian 61     noun
#ENDIF
HACHUela 61     noun ;-deben ir seguidos estos dos
HACHA    62     noun
#define HachaW 62
FRUTA    63     noun
CURARem  63     noun
FRUTO    63     noun
#IF BIGMEM
 BOTULica 63     noun
 BOT£Lica 63     noun
#ENDIF
ESPINa   64     noun
PUA      64     noun
P£A      64     noun
PINCHO   64     noun
PALO     65     noun
#define LianaW  66
LIANAs   66     noun
ESTACa   67     noun
#define Ca¤aW 68
CA¥A     68     noun
CANA     68     noun ;para ordenadores sin ¤
CERBAtan 68     noun
CASCAbel 70     noun
JAGUAr   71     noun
#IF BIGMEM
 FELINO  71     noun
#ENDIF
MONO     72     noun
MONOS    72     noun
MACACus  72     noun
#IF BIGMEM
 COGNAzus 72     noun
 CHIMPanc 72     noun
#ENDIF
#IF BIGMEM
 #define  PielW 73
 PIEL     73     noun
#ENDIF
;CLAVO    74     noun
RISTRa   75     noun
TRONCo   76     noun
MADER    76     noun
BALSA    77     noun
;
VASIJa   78     noun
#IF BIGMEM
 JARROn   78     noun
 JARR¢n   78     noun
 #define CajonW 79
 CAJON    79     noun
 CAJ¢N    79     noun
#ENDIF
SELLO    80     noun
TABLEta  80     noun
AGUJEro  81     noun
TUNEL    81     noun
#IF BIGMEM
 T£NEL    81     noun
 PASADizo 81     noun
 ORIFIcio 81     noun
#ENDIF
;
;Other nouns
;
RAM         176  noun
;
#IF BIGMEM
 ASIENto     177  noun
 BANCO       177  noun
#ENDIF
BARCA       178  noun
YUCATana    178  noun
#IF BIGMEM
 BOTE       178  noun
 EMBARcacio 178  noun
#ENDIF
FONDO       179  noun
CHARCO      179  noun
LOSA        180  noun
MAR         181  noun   ; Para examinarlo
#IF BIGMEM
 AGUA        181  noun
#ENDIF
;182
;183
#IF BIGMEM
 IDOLO       184  noun
 ¡DOLO       184  noun
#ENDIF
BLOQUe      185  noun
PIEDRa      185  noun
ALTAR       186  noun
SELVA       187  noun
VEGETaci¢n  187  noun
PLANTas     187  noun
CA¥AS       188  noun
CANAS       188  noun ;para ordenadores sin ¤
BAMBU       188  noun
BAMB£       188  noun
ARBOL       189  noun
 RBOL       189  noun
COCOTero    190  noun
SUELO       191  noun
CACTUs      192  noun
FOSO        193  noun
ESCOMbros   194  noun
PARED       195  noun
MURO        195  noun
MUROS       195  noun
MURAL       195  noun
ACANTilado  196  noun
CENOTe      197  noun
MACHEte     198  noun
;
#define PSINames 199
#define IndioW   199
COZUMelano 199  noun
CIPACtli   199  noun
INDIO      199  noun
KUILL      200  noun
LORO       200  noun
;
;       -Correcci¢n, repetici¢n $$$OJO que no haya palabras con num. m s alto
V       250     verb    ; repite £ltima frase/corrige nombres o adjetivos
P       251     noun    ; corrige verbo
;
;
;-Adjetivos
;
;100-101
IK       102    adjective
AKBAL    103    adjective
KAN      104    adjective
CHICCAN  105    adjective
CIMI     106    adjective
MANIK    107    adjective
LAMAT    108    adjective
MULUC    109    adjective
#define ImixW   110
IMIX     110    adjective       ;la primera supercuenta
#define OcW     111
OC       111    adjective       ;la segunda
#IF BIGMEM
 #define APielMW 112
 #define APielJW 113
 ADJM     112    adjective       ;para diferenciar las pieles
 ADJJ     113    adjective       ;del mono y del jaguar
#ENDIF
RUGOSo   114    adjective       ;troncos
LISO     115    adjective
RECTO    116    adjective
GRUESo   117    adjective
#define IzqW  118
#define DerW  119
#define CenW  120
IZQUIerd 118    adjective
IZ       118    adjective
DERECha  119    adjective
D        119    adjective
CENTRo   120    adjective
C        120    adjective
#if DEBUG
 1        118    adjective
 2        119    adjective
 3        120    adjective
#endif
;
;       -Conjugations-
;
Y       2       conjugation
#IF BIGMEM
 LUEGO  2       conjugation
#ENDIF
;
;       -Prepositions-
;
EN      2       preposition
DENTRO  2       preposition
#IF BIGMEM
 TRAVES 2       preposition ;-a traves de la ca¤a
 POR    2       preposition
#ENDIF
DE      3       preposition
DEL     3       preposition
;
QUE     2       adverb      ;qu‚ quieres
QU‚     2       adverb
;________________________________________________________________________
;                               Text tables
#IF DRAW
 #include T1S.TXT
#ELSE
 #include T1B.TXT
#ENDIF
;________________________________________________________________________
/CON                            Connections
/Cajon
/Bambu
/2
/3
/INDIO
/RISTRA
/BALSA
/LIMBO
/MUERTE
/Barca
#if DEBUG
 entrar Playa
#endif
BAJAR Playa
;
; - Locs. principales
;
/MarI
/MarT
/MarH
/Playa2
#IF !DRAW
 N Playa
#ENDIF
/Playa
#IF !DRAW
 S Playa2
#ENDIF
SUBIR Frente
#if DEBUG
 salir L10
#endif
/Frente
BAJAR Playa
ENTRAR Derruid
E Derruid
O Selva1
S Selva1
N Selva1
/Derruid
O Frente
SALIR Frente
N Altar
/Altar
S Derruid
/Selva1
S Frente
O Selva2
/Selva2
E Selva1
N Selva3
/Selva3
S Selva2
N Selva4
#if DEBUG
 SALIR Plaza    ;evita jaguar
#endif
/Selva4
S  Selva3
NE Selva5
BAJAR Foso
/Foso
SUBIR Selva4
/Selva5
SO Selva4
N Plaza
/Plaza
S Selva5
O L1
#IF !DRAW
 E AhogoM
#ENDIF
N L9      ;-cuando abran el cenote
SUBIR L9  ;-se abren estas dos
/L1
E Plaza
O L2
/L2
E L1
N L3
/L3
S L2
N L4
/L4
S L3
N L5
/L5
S L4
E L6
/L6
O L5
E L7
SO L4
/L7
O L6
S L8
E      AhogoM
/L8
N L7
S L9
NO L6
E      AhogoM
/L9
N L8
O L10
S Plaza
E      AhogoM
/L10
E  L9
SE Plaza
S  L1
SO L2
O  L3
NO L4
N  Cenote
NE L8
#if DEBUG
 salir Playa ;$$$
#endif
/Cenote
S L10
N AhogoM
E AhogoM
O AhogoM
BAJAR  AhogoC
ENTRAR AhogoC
SALTAR AhogoC
/AhogoI
#if DEBUG
 SALIR Cenote
#ENDIF
/AhogoM
#if DEBUG
 SALIR Cenote
#ENDIF
/AhogoC
SUBIR Cenote
;$$$OJO si se a¤aden locs aqu¡ ver $$!!!
;________________________________________________________________________
;                      Object definitions
;
#IF !DRAW
 #define RedLoc Playa2
#ELSE
 #define RedLoc Playa
#ENDIF
; Atributos
;
#define EDIBLE    0     ; Could be eaten (may be poison)
#define POISON    1     ; Is poison
#define SHARP     2     ; Cuts things
#define MASCULINE 3     ; Object is masculine (if not it is feminine)
#define ATABLE    4     ; Se puede atar con la liana
#define SMALL     5     ; Object is small (e.g. will fit in a small container)
;                         (i. e. ca¤a)
#define ISTRONCO  6     ;para HazBalsa
#define NONSTOP   7     ;no quiere punto tras examina
#define ISBEAD    8     ;es cuenta normal
#define BIG       9     ;no pasa por los agujeros del laberinto si lo arrastras
#define NOEXAMIN 10     ;no tiene examina en versiones peque¤as
#define PBambu 1 ;peso
#define PContrato 1
#define PCajon 1 ;peso
;
;
/OBJ
;                                         Tronco Peque¤o
;                                      Nonstop ³ ³ Atable
;                                     Cuenta ³ ³ ³ ³ Masculino
;                                   Grande ³ ³ ³ ³ ³ ³ Corta
;                               Noexamin ³ ³ ³ ³ ³ ³ ³ ³ Venenoso
;                                      ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ Comestible
;                                    ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³
;obj    starts  weight C W   5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0   noun    adjective
#IF BIGMEM
 /Cajon   Barca   1    Y _   _ _ _ _ _ _ _ _ _ _ _ _ Y _ _ _   CAJON    _
#ELSE
 /Cajon   _       1    Y _   _ _ _ _ _ _ _ _ _ _ _ _ Y _ _ _   _        _
#ENDIF
/Bambu    LIMBO   1    Y _   _ _ _ _ _ _ _ _ _ _ Y Y _ _ _ _   CA¥A     _
/Remo     INDIO   10   _ _   _ _ _ _ _ _ Y _ _ _ _ Y Y _ _ _   REMO     _
/PielX    _       1    _ _   _ _ _ _ _ Y _ _ _ _ Y _ Y _ _ _   _        _
/Cuerda   Barca   4    _ _   _ _ _ _ _ Y _ _ _ _ _ _ _ _ _ _   CUERDA   _
/Papaya   LIMBO   3    _ _   _ _ _ _ _ _ _ _ _ _ _ Y _ _ Y Y   PAPAYA   _
/Gusano   LIMBO   1    _ _   _ _ _ _ _ _ _ _ _ _ Y _ Y _ Y Y   GUSANO   _
/Contrato CARRIED 1    _ _   _ _ _ _ _ _ _ _ _ _ Y Y Y _ _ _   CONTRATO _
/Red      RedLoc  3    _ _   _ _ _ _ _ _ _ _ _ _ _ Y _ _ _ _   RED      _
/Cuenta1  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   IK
/Cuenta2  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   AKBAL
/Cuenta3  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   KAN
;                                         Tronco Peque¤o
;                                      Nonstop ³ ³ Atable
;                                     Cuenta ³ ³ ³ ³ Masculino
;                                   Grande ³ ³ ³ ³ ³ ³ Corta
;                               Noexamin ³ ³ ³ ³ ³ ³ ³ ³ Venenoso
;                                      ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ Comestible
;                                    ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³
/Cuenta4  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   CHICCHAN
/Cuenta5  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   CIMI
/Cuenta6  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   MANIK
/Cuenta7  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   LAMAT
/Cuenta8  _       1    _ _   _ _ _ _ _ _ _ Y _ _ _ _ _ _ _ _   CUENTA   MULUC
/MCuenta2 L10     0    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   CUENTA   OC
/MCuenta1 Altar   0    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   CUENTA   IMIX
/Ristra   _       1    _ _   _ _ _ _ _ _ _ _ Y _ _ _ _ _ _ _   RISTRA   _
/Collar   _       8    _ Y   _ _ _ _ _ _ _ _ _ _ _ Y Y _ _ _   COLLAR   _
/Hachuela LIMBO   4    _ _   _ _ _ _ _ _ _ _ _ _ _ Y _ Y _ _   HACHUELA _
/Hacha    _      10    _ _   _ _ _ _ _ _ _ _ _ _ _ Y Y Y _ _   HACHA    _
/Fruta    LIMBO   1    _ _   _ _ _ _ _ _ _ _ _ _ Y _ _ _ Y Y   FRUTA    _
/Espina   LIMBO   1    _ _   _ _ _ _ _ _ _ _ _ _ Y _ _ _ _ _   ESPINA   _
/FruEsp   _       2    _ _   _ _ _ _ _ _ _ _ _ _ Y _ _ _ _ _   FRUTA    _
/Palo     Selva2  3    _ _   _ _ _ _ _ _ _ _ _ _ _ Y Y _ _ _   PALO     _
/Liana    _       3    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   LIANAS   _
/Estaca   LIMBO   2    _ _   _ _ _ _ _ Y _ _ _ _ _ Y _ _ _ _   ESTACA   _
/Cascabel _       3    _ Y   _ _ _ _ _ Y _ _ _ _ Y _ Y _ _ _   CASCABEL _
/JaguarK  _       30   _ _   _ _ _ _ _ _ _ _ _ _ _ Y Y _ _ _   JAGUAR   _
;                                         Tronco Peque¤o
;                                      Nonstop ³ ³ Atable
;                                     Cuenta ³ ³ ³ ³ Masculino
;                                   Grande ³ ³ ³ ³ ³ ³ Corta
;                               Noexamin ³ ³ ³ ³ ³ ³ ³ ³ Venenoso
;                                      ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ Comestible
;                                    ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³
#IF BIGMEM
 /JaguarD _       25   _ _   _ _ _ _ _ _ _ _ _ _ _ Y Y _ _ _   JAGUAR   _
#ENDIF
/MonoK    _       20   _ _   _ _ _ _ _ _ _ _ _ _ _ Y Y _ _ _   MONO     _
#IF BIGMEM
 /MonoD   _       15   _ _   _ _ _ _ _ _ _ _ _ _ _ Y Y _ _ _   MONO     _
 /PielJ   _       5    _ _   _ _ _ _ _ _ _ _ _ _ _ Y _ _ _ _   PIEL     ADJJ
 /PielM   _       5    _ _   _ _ _ _ _ _ _ _ _ _ _ Y _ _ _ _   PIEL     ADJM
#ENDIF
/Tronco1  _       30   _ _   _ _ _ _ _ Y Y _ _ Y _ Y Y _ _ _   TRONCO   RUGOSo
/Tronco2  _       30   _ _   _ _ _ _ _ Y Y _ _ Y _ Y Y _ _ _   TRONCO   LISO
/Tronco3  _       30   _ _   _ _ _ _ _ Y Y _ _ Y _ Y Y _ _ _   TRONCO   RECTO
/Tronco4  _       30   _ _   _ _ _ _ _ Y Y _ _ Y _ Y Y _ _ _   TRONCO   GRUESo
/Runa1    L5      1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    IK
/Runa2    L6      1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    AKBAL
/Runa3    L8      1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    KAN
/Runa4    L1      1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    CHICCHAN
/Runa5    _       1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    CIMI
/Runa6    L4      1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    MANIK
/Runa7    L9      1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    LAMAT
/Runa8    LIMBO   1    _ _   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   SELLO    MULUC
/Balsa    _       60   _ _   _ _ _ _ _ _ Y _ Y _ _ Y _ _ _ _   BALSA    _
;/Jarron   Altar   60   _ _   _ _ _ _ _ _ _ _ _ _ _ Y Y _ _ _   JARRON   _
;________________________________________________________________________
;                       Processes for Part1
;
;________________________________________________________________________
;                       Main Control loop
/PRO Main
;#if DRAW
; #if PART1
;  #if !CBM64
;   _      _       AT      0
;                  ZERO    DoneOnce
;                  ANYKEY                  ; Preserve presentation
;                  SET     DoneOnce
;  #endif
; #endif
;#endif

#if FACES
 _       _       AT      0
 #if PCW
                 WINDOW  7      ; Clear whole screen
                 CLS
 #endif
                 WINDOW  0      ; Is full screen
 #if PCW
                  WINAT    3  5           ; Centre picture
                  WINSIZE 25 80
 #endif
                 PICTURE 203
                 DISPLAY 0
                 ANYKEY         ; No text
                 CLS            ; Delete it so that pallette change
                 PICTURE 1      ; We must have a picture to set pallette
                 DISPLAY 0      ; Destroys full window (no effect on PCW)
#else
 #if !DRAW
  _       _       AT      0           ; Start of game
                  WINDOW  0
                  PICTURE 0           ; We must have a picture to set pallette
                  DISPLAY 0
 #endif
#endif

_       _       AT      0
                WINDOW  1       ; Full screen (but -1 line on PCW)
                WINAT   0  0
#IF !DRAW
                WINSIZE 31 127  ;borra primero la pantalla entera
                CLS             ;(por los que tienen texto en 80 o m s cols.)
#ENDIF
                WINSIZE 31 53
                CENTRE
                CLS
;#IF COLS80
;                 HASNAT  GMODE
;                 TAB     27
;
; _       _       AT      0
;#ENDIF
#IF STAM
                GFX     0       1       ;phys to back
                GFX     0       8       ;text to back
#ENDIF
                DESC    0       ; Title
#IF STAM
                GFX     0       7       ;text to phys
                GFX     0       0       ;back to phys
#ENDIF
                ANYKEY
                CLS
                PROCESS Init            ; Do init stuff
                GOTO    Barca

_       _       ATGT    LVLoc
                MES     0

;-----------------------------
; tc.sce        \/  \/
;

;_       _       AT      MUERTE          ; Always changes 'mode'
;                ZERO    Piccies
;                PICTURE MUERTE          ; if there is a picture
;                CLEAR   HayPic
;                PROCESS Graphic         ; This clears text section if text mode
;                WINDOW  7               ; Clear whole screen (inc status)
;                CLS
;                WINDOW  1               ; Area is below a picture now
;                END

_       _       AT      MUERTE          ; This is only if there is no picture
                DESC    MUERTE          ; Message we have died
                ANYKEY                  ; Eva wants it
                END                     ; (Mainly on 8 bit I suppose)

#if DARK
 ;solo si usamos oscuridad
 _       _       CLEAR   DarkF           ; Assume light
                 NOTZERO Dark
                 ABSENT  QuinqueE        ; No lamp
                 SET     DarkF           ; Dark
#endif

_       _       COPYFF  Player Work1    ;pone en Work1 el dibujo a imprimir
                AT      Barca
                COPYFF  BarcaLoc Work1  ;en la barca recorremos varias locs

#if CPC
 _      _       AT      Selva3          ;no tiene gr fico en amstrad
                LET     Work1   Selva4  ;ponemos el mismo del claro
#endif

_       _       AT      Plaza           ;la primera vez que entras en el
                ZERO    PlazaF          ;laberinto
                COPYFF  Piccies Work6   ;lo preservamos
                SET     Piccies
                PROCESS SetText         ;a pantalla completa
                PROCESS Status          ;porque se borra

_       _       ZERO    Piccies         ; Want pictures
#if DARK
                ZERO    DarkF           ; Not dark
#endif
                NOTZERO Work1           ; There might be one
                NOTSAME Work1 HayPic    ; Not already correct picture
                PICTURE [Work1]         ; If we have a picture
                PROCESS Graphic         ; Change mode if needed
                WINDOW  0               ; Select graphics window
#IF DRAW
                PROCESS Slide           ; Display graphic
#ELSE
                COPYFF  Work1 Work5     ; Gonna damage piccy
                PROCESS Slide           ; Display graphic
                COPYFF  Work5 Work1
#ENDIF
#if OPICS
                PROCESS PicInv          ; We need pictures
#endif
                COPYFF  Work1 HayPic    ; Which picture on screen & in graphics
                SKIP    $WANTPIC

_       _       NOTZERO HayPic          ; We are not already in text mode
                NOTSAME Work1 HayPic    ; And this picture not on screen
                PROCESS CAnykey         ; About to change mode so wait for key
                PROCESS SetText         ; Set up the text mode & a clear screen

#if DARK
 _       _       NOTZERO HayPic          ; We're not in text mode
                 NOTZERO DarkF           ; and it is now dark
                 PROCESS CAnykey
                 PROCESS SetText
#endif

$WANTPIC
_       _       WINDOW  3               ; Update short desc in status
                PRINTAT 0 0             ; need to deal with unusual locs
                SYSMESS Spaces          ; (Always clear!)
                TAB     0
                LET     Work1   BarcaSD
                ATGT    MarH
                LET     Work1   PlayaSD
                ATGT    Playa
                LET     Work1   TemploSD
                ATGT    Frente
                LET     Work1   SalaSD
                ATGT    Derruid
                LET     Work1   AltarSD
                ATGT    Altar
                LET     Work1   SelvaSD
                ATGT    Selva5
                LET     Work1   PlazaSD
                ATGT    Plaza
                LET     Work1   LaberintoSD
                ATGT    L10
                LET     Work1   CenoteSD
                ATGT    Cenote
                LET     Work1   AhogoISD
                ATGT    AhogoI
                LET     Work1   AhogoMSD
                ATGT    AhogoM
                LET     Work1   CenoteSD

_       _       GT      Player FSLoc-1  ; Valid range for short descs
                LT      Player LSLoc+1
#if DARK
                ZERO    DarkF
#endif
                MES     [Work1]
                BACKAT                  ; flush buffer
#IF DEBUG
 #IF MSX
                printat 0 0
                print Player
                space
 #ENDIF
#ENDIF

#if DARK
 _      _       NOTZERO DarkF
                SYSMESS DarkS
#endif

_       _       CLEAR   APending
                WINDOW  1               ; Text window
#if DARK
                NOTZERO DarkF           ; Dark
                SYSMESS 0
#endif

_       _       AT      Plaza           ;la primera vez que entras en el
                ZERO    PlazaF          ;laberinto
                SET     PlazaF          ;
                MESSAGE PlazaM          ;'la magia te sobrecoge'
                ANYKEY
                COPYFF  Work6   Piccies ;recuperamos modo
                RESTART                 ;ahora ya sale graf. y descr. normal

_       _       ZERO    DarkF
                DESC    [Player]        ; Doesn't exit loop now
                AT      Barca
                DESC    [BarcaLoc]      ; en la barca tiene desc extra

_       _       PROCESS EachDesc        ; Old Process 1!!

; Now we use Process 1 as the main code loop, a return from it is the end
; of the game

_       _       PROCESS MainLoop        ; A return is system exit

;________________________________________________________________________
/PRO MainLoop ;Main system loop

; The counters
#define PoisT  7  ;turnos de envenenamiento
#define PoisM  6  ;te pones malo
#define PoisMM 5  ;muy malo (chequeo con LT as¡ que es ese valor-1)
;
#define Storm0 10 ;turnos para que estalle la tormenta
#define Storm1  7 ;primer aviso
#define Storm2  5 ;segundo aviso
#define Storm3  3 ;tercer aviso
;
#define Indio1 15 ;turnos para que muera
#define Indio2  7 ;salen los tiburones


SACAR   _       SETCO   [CONum]
                SAME    COLoc   O2Num   ;si no se ha movido=>exceso de peso 
                CREATE  [CONum]         ;o de objs. Dijo que se cae al suelo
                                        ;y ah¡ es donde va a estar

_       _       PROCESS Status                  ; Display update (score etc)
#IF BIGMEM
                MINUS   TeDio   1               ;mientras <>0 te dira 'de nada'
#ENDIF
                MINUS   Poisoned 1              ; In the process of dying
                EQ      Poisoned 1              ; Going
                SYSMESS 82
                GOTO    MUERTE
                SET     APending
                RESTART

_       _       EQ      Poisoned PoisM          ; comienzas a estar malo
                SYSMESS MaloS

_       _       NOTZERO Poisoned
                LT      Poisoned PoisMM         ; estas muy malo
                SYSMESS MaloS+1
                AT      Barca
                NOTEQ   BarcaLoc MarT
                NOTEQ   BarcaLoc Playa
                LET     AhogTrn 3       ;te vas a ahogar rapido
                MES     IndioM+3        ;el indio aprovecha tu debilidad
                PROCESS Tetira          ; y te tira al agua

_       _       NOTAT   Barca           ;fuera de la barca no deben pasar
                CLEAR   StormT          ;estas cosas
                CLEAR   IndioT

_       _       MINUS   StormT  1
                EQ      StormT  1
                MESSAGE BarcaM+4
                LET     BarcaLoc MarT   ;comienza la tormenta en serio
                LET     IndioT  Indio1  ;indio al agua
                ISAT    Cuerda  INDIO
                CREATE  Cuerda

_       _       EQ      StormT  1
                CREATE  Remo
                CLEAR   StormT
                RESTART

_       _       EQ      StormT  Storm1  ;nublado
                MESSAGE BarcaM+1

_       _       EQ      StormT  Storm2  ;m s nublado
                MESSAGE BarcaM+2

_       _       EQ      StormT  Storm3  ;m s nublado a£n
                MESSAGE BarcaM+3

_       _       AT      Barca
                MINUS   IndioT  1               ;muere el indio
                EQ      IndioT  1               ; y t£ con ‚l
                CLEAR   IndioT
                MESSAGE IndioM+12
                END

_       _       EQ      IndioT  Indio2  ;salen tiburones
                MESSAGE IndioM+11

_       _       CLEAR   EnAhogo                 ;para NADAR
                ATGT    AhogoI-1
;$$!!! poner si se a¤aden locs tras esta:  ATLT    AhogoC+1
                SET     EnAhogo

_       _       ZERO    EnAhogo                 ;si no est s en el agua
                CLEAR   AhogTrn                 ;no te ahogas

_       _       MINUS   AhogTrn 1               ; te vas a ahogar,cari¤o
                EQ      AhogTrn 1               ; te has ahogado
                SYSMESS 83
                GOTO    MUERTE
                SET     APending
                RESTART

_       _       NOTZERO EnAhogo                 ;en el agua y no en la balsa
                ZERO    AtBalsa
                ZERO    AhogTrn                 ;si no lo ha hecho ya
                LET     AhogTrn 5               ;turnos para ahogarte

_       _       PROCESS EachMove        ; Do process 2 stuff here (each part)

; Ensure PSI's have done nothing yet this turn, Note that as the flags are
; cleared here a PSI EachMove message can be suppressed by Response for the
; next move, this is used so don't change it
;
;_       _       LET     ThisPSI PSI0+4  ; Clear PSI action flags
;
;_       _       CLEAR   [ThisPSI]
;                PLUS    ThisPSI 5
;                LT      ThisPSI LastPSI+5
;                SKIP    -1

#IF VOCCHK
 _      _       TAB     20
                PRINT   Verb
                TAB     25
                PRINT   Noun1
                TAB     30
                PRINT   Adject1
                TAB     35
                PRINT   Noun2
                TAB     40
                PRINT   Adject2
                TAB     45
                PRINT   Prep
                TAB     50
                PRINT   Adverb
                MESSAGE kkM
#ENDIF

_       _       PARSE   0               ; Get next LS from current buffer
                SYSMESS 6               ; I didn't understand
                REDO

#IF VOCCHK
 _      _       TAB     20
                PRINT   Verb
                TAB     25
                PRINT   Noun1
                TAB     30
                PRINT   Adject1
                TAB     35
                PRINT   Noun2
                TAB     40
                PRINT   Adject2
                TAB     45
                PRINT   Prep
                TAB     50
                PRINT   Adverb
                MESSAGE kkM+1
#ENDIF

SOPLA   _       NOTEQ   Noun1   Ca¤aW
                NOTEQ   Noun2   Ca¤aW
                SKIP    $NOCA¥A

SOPLA   _       EQ      Noun2   Ca¤aW   ;si pone SOPLA NOMBRE interpreta
                COPYFF  Noun2   Noun1   ;SOP IT NOMBRE (y NOMBRE va a Noun2)
                COPYFF  Noun2   CPNoun
                COPYFF  Adject2 Adject1
                COPYFF  Adject2 CPAdject
                SET     Noun2           ;as¡ que desfacemos el entuerto
                SET     Adject2

$NOCA¥A
_       _       NOUN2   P
                LT      Noun1   250
                EQ      OldNoun2 255
                COPYFF  OldNoun1 OldNoun2
                COPYFF  OldAdj1  OldAdj2

_       _       NOUN2   P
                LT      Noun1   250
                COPYFF  Noun1   OldNoun1
                SYNONYM _       P

_       _       NOUN2   P
                LT      Adject2 250
                COPYFF  Adject2 OldAdj2

_       P       LT      Verb    250
                COPYFF  Verb    OldVerb

_       P       LT      Adject1 250
                COPYFF  Adject1 OldAdj1

_       P       LT      Noun2   250
                COPYFF  Noun2   OldNoun2
                LT      Adject2 250
                COPYFF  Adject2 OldAdj2

_       P       SYNONYM V       _
                SET     Noun1           ; el synonym no lo hace

V       _       EQ      Noun1   255
                COPYFF  OldNoun1 Noun1
                COPYFF  OldAdj1  Adject1
                COPYFF  OldNoun2 Noun2
                COPYFF  OldAdj2  Adject2

V       _       EQ      Prep    255     ;esto se repite siempre
                COPYFF  OldPrep Prep

V       _       COPYFF  OldVerb Verb    
                EQ      Adverb  255
                COPYFF  OldAdv  Adverb

_       _       COPYFF  Verb    OldVerb ; por si al siguiente turno repetimos
                COPYFF  Noun1   OldNoun1
                COPYFF  Noun2   OldNoun2
                COPYFF  Adject1 OldAdj1
                COPYFF  Adject2 OldAdj2
                COPYFF  Adverb  OldAdv
                COPYFF  Prep    OldPrep

SALTAR  _       AT      Barca
                SYNONYM BAJAR   _

SALTAR  _       NOTZERO AtBalsa
                SYNONYM BAJAR   _

NADAR   _       AT      Barca
                SYNONYM BAJAR   _

NADAR   _       NOTZERO AtBalsa
                SYNONYM BAJAR   _

DEJAR   BARCA   AT      Barca
                SYNONYM BAJAR   _

DEJAR   BALSA   NOTZERO AtBalsa
                SYNONYM BAJAR   _

MOVER   _       NOTZERO EnLabe
                LT      Noun1   5       ;mover n/s/e/o
                COPYFF  Noun1   Noun2
                COPYFF  Adject1 Adject2
                SYNONYM MOVER   BLOQUE

DAR     _       GT      Noun1   PSINames-1
                LT      Noun1   PSINames+NumPSIs
                COPYFF  Noun1   Work1   ;convierte DAR persona obj
                COPYFF  Noun2   Noun1   ;en        DAR obj persona
                COPYFF  Work1   Noun2

PEDIR   _       GT      Noun1   PSINames-1
                LT      Noun1   PSINames+NumPSIs
                COPYFF  Noun1   Work1   ;convierte PEDIR persona obj
                COPYFF  Noun2   Noun1   ;en        PEDIR obj persona
                COPYFF  Work1   Noun2

ATAR    CUERDA  COPYFF  Noun1   Work1   ;conv. ATAR cuerda cosa
                COPYFF  Noun2   Noun1   ;      ATAR cosa cuerda
                COPYFF  Work1   Noun2

ATAR    REMO    NOUN2   _
                LET     Noun2   CuerdaW

_       _       EQ      Turns   255     ; Max for one byte
                PLUS    Turns+1 1
                CLEAR   Turns
                SKIP    1

_       _       PLUS    Turns   1

#IF VOCCHK
 _      _       TAB     20
                PRINT   Verb
                TAB     25
                PRINT   Noun1
                TAB     30
                PRINT   Adject1
                TAB     35
                PRINT   Noun2
                TAB     40
                PRINT   Adject2
                TAB     45
                PRINT   Prep
                TAB     50
                PRINT   Adverb
                MESSAGE kkM+2
#ENDIF

_       _       WHATO
                EQ      Verb  255
                GT      Noun1 PSINames-1 ; This is really talking to them
                LT      Noun1 PSINames+NumPSIs
                SYNONYM DECIR _         ; Noun1/Adject1 is already their name

;COMO    _       SYNONYM COMER _         ; Need to do a forced synonym here

MATAR   LORO    SYNONYM COGER  LORO

CLAVAR  _       NOUN2   PUA
                COPYFF  Noun1   Noun2
                SYNONYM CLAVAR  PUA

CLAVAR PUA     NOUN2   GUSANO
               CARRIED Espina
               SYNONYM MATAR GUSANO

SR     _        SYNONYM SAVE    RAM

LR     _        SYNONYM LOAD    RAM

TALAR   ARBOL   SYNONYM TALAR   TRONCO

DEJAR   COLLAR  AT      L10
                NOUN2   BLOQUE
                SYNONYM PONER   COLLAR

PONER   COLLAR  AT      L10
                NOUN2   BLOQUE
                CARRIED Collar          ;tiene lo que debe donde debe
                ZERO    Tunel10         ;y el tunel est  cerrado
                SET     Tunel10         ;lo abre
                MESSAGE BloqM+10        ;lo dice
                CREATE  Collar
#if OPICS
                PROCESS DropPic
#endif
                REDO

COGER   _       PREP    DE
                SYNONYM SACAR   _

DEJAR   _       PREP    EN
                SYNONYM METER _

PONER   _       PREP    EN              ; they mean METER
                SYNONYM METER _

#if BIGMEM
 _      _       NOUN2   MONO            ; para distinguir 'piel de mono'
                ADJECT1 _               ; de 'piel de jaguar'
                LET     Adject1 APielMW

 _      _       NOUN2   JAGUAR
                ADJECT1 _
                LET     Adject1 APielJW
#ENDIF

_       _       PROCESS Response        ; Do any commands
                ISDONE                  ; Done something
                REDO

_       _       COPYFF  Player Work1
                MOVE    Work1           ; No so try to move player
                PROCESS DoorChk         ; check doors in the way
                ISDONE                  ; hay puerta
                NOTZERO EnLabe
                MESSAGE TunelM          ; una losa impide el camino
                REDO

_       _       ISNDONE
                LET     Work2   AtaNum1
                PROCESS Tied            ; me traigo el objeto atado 1 (o no)
                LET     Work2   AtaNum2
                PROCESS Tied            ; me traigo el objeto atado 2 (o no)
                COPYFF  Work1   Player  ; move player
                RESTART                 ; Absolute jump to start process 0

_       _       NEWTEXT
                GT      Verb    13
                SYSMESS UCantS
                REDO

_       _       SYSMESS 7               ; 'no puedes '
                LT      Verb    9       ; norte-sur-este-oeste-ne-no-se-so
                SYSMESS 3               ; 'ir al '

_       _       COPYFF  Verb    Work1   ; > pasa verbo a flag direcci¢n
                PLUS    Work1   SM+5    ; ¡ndice para mensaje
                SYSMESS [Work1]         ; imprime la direcci¢n
                SYSMESS 4               ;'.'
                ZERO    EnLabe
                PROCESS Salidas         ; rutina de salidas

_       _       NOTZERO EnLabe          ;si esta en las estancias no dice
                NEWLINE                 ;'puedes ir a tal' pero pone NL

_       _       REDO

;
; tc.sce   /\  /\
;
;---------------------------
;________________________________________________________________________
/PRO EachDesc ; Old process 1

_       _       CLEAR   FBN
                CLEAR   FBE
                CLEAR   FBS
                CLEAR   FBO
                CLEAR   EnLabe
                ATGT    Plaza-1
                ATLT    Cenote+1
                SET     EnLabe          ;indica que est  en laberinto
                COPYFF  Player  Work1   ;lee num. bloques en cada pared
                MINUS   Work1   Plaza
                PLUS    Work1   NBloqT
                COPYFF  [Work1] COAtt
                PROCESS RBits

_       _       AT      Plaza
                NOTZERO Tunel10
                MES     PlazaM+1

_       _       AT      AhogoM          ;muerte en arrecifes
                GOTO    MUERTE          ;antes de listar objetos
                NEWLINE
                RESTART

_       _       ABSENT  Balsa           ;no podemos estar subidos
                CLEAR   AtBalsa         ;si la hemos roto o nos movimos

_       _       SYSMESS 4               ; .\s al fin de descripcion
                NOTZERO AtBalsa         ;subido a balsa
                MES     BalsaM+7        ;lo dice
                DESTROY Balsa           ;no quiero que la liste

_       _       AT      AhogoC          ;en el agua y no en la balsa.Solo cenote
                ZERO    AtBalsa
                MES     BalsaM+8        ;'est s nadando'

;The first time you visit certain locations where the PSI's will always be
;you may just get the pretty description of them

; Describe objects and PSI's

_       _       AT      Barca           ;lista pseudogente
#IF BIGMEM
                DESTROY Cajon           ;no debe listarlo
#ENDIF
                NOTEQ   BarcaLoc MarT   ;si el indio no est  en el agua
                SYSMESS PM+1            ;'aqu¡ est n el indio y el loro'
                SYSMESS PM+6
                SYSMESS PM+4            ;'\sy\s'
                SYSMESS PM+7
                SYSMESS PM+2            ;'.\s'
                SKIP    1

_       _       AT      Barca           ;lista pseudogente
                SYSMESS PM              ;'aqu¡ est  el loro.'
                SYSMESS PM+7
                SYSMESS PM+2
                MES     IndioM+2        ;'el indio est  en el agua'
#IF BIGMEM
                DESTROY Cajon           ;no debe listarlo
#ENDIF

_       _       LISTOBJ                 ; Objetos
                NOTZERO AtBalsa         ; subido a balsa
                CREATE  Balsa           ; la recupera

#IF BIGMEM
 _      _       AT      Barca
                CREATE  Cajon
#ENDIF

;-------------- Actions on behalf of PSI's each describe (Ojo con NOLISTES)

;-------------- End of location description

_       _       NEWLINE
                AT      Barca
                EQ      BarcaLoc MarI
                ZERO    StormT
                LET     StormT  Storm0

_       _       AT      Altar
                ISAT    MCuenta1 HERE           ;si la magnetocuenta est  aqu¡
                SETCO   MCuenta1
                MESSAGE CuentaM+4               ;dice que est  volando

_       _       AT      Foso
                NOTZERO Empalado
                MESSAGE EmpaladoM
                GOTO    MUERTE
                RESTART

_       _       AT      Selva5
                ZERO    Jaguar                  ; jaguar vivo
                MESSAGE JaguarM                 ; 'hay un jaguar cerca'

_       _       AT      Selva3
                ZERO    Mono                    ; mono vivo
                MESSAGE MonoM                   ; describe escena de los monos

#IF BIGMEM
 _      _       CLEAR   Cuelgade                ;en bigmem podr s subir por la
                ATGT    Plaza-1
                ATLT    L10+1
                PRESENT Liana                   ;si cuelga de un tunel alto
                NOTEQ   AtaNum1 255
                ABSENT  [AtaNum1]               ;si no est  aqu¡ est  atascado
                COPYFF  AtaLoc1 Cuelgade        ;el obj1 est  atascado ah¡

 _      _       PRESENT Liana
                ATGT    Plaza-1
                ATLT    L10+1
                NOTEQ   AtaNum2 255
                ABSENT  [AtaNum2]
                COPYFF  AtaLoc2 Cuelgade        ;el obj2 est  atascado ah¡

 _      _       LET     Verb    1               ;si no hay conexion con esa loc
                ZERO    Cuelgade                ;es que cuelga de un tunel alto
                SKIP    $NOCUELGA               ;si no, cuelgade=0

 $NEXTDIR
 _      _       COPYFF  Player Work1    ; copia loc actual del jugador
                MOVE    Work1           ; intenta moverse y si puede
                SAME    Work1   Cuelgade ;se puede ir andando a esta loc?
                CLEAR   Cuelgade        ;acabamos, la liana no cuelga
                SKIP    $NOCUELGA

 _      _       PLUS    Verb    1       ; pr¢xima direcci¢n
                LT      Verb    13      ; no se ha pasado a£n
                SKIP    $NEXTDIR

 _      _       MES     AtaM+11         ;'la liana cuelga del tunel'...
                LET     Verb    1

 $NEXTDIR2
 _      _       COPYFF  Cuelgade Work1  ; copia loc actual del tronco
                MOVE    Work1           ; intenta moverse y si puede
                SAME    Work1  Player   ;¨es la loc donde estamos?
                SKIP    $CALCDIR

 _      _       PLUS    Verb    1       ;  pr¢xima direcci¢n
                LT      Verb    13      ;  no se ha pasado a£n
                SKIP    $NEXTDIR2

 $CALCDIR
 _      _       LET     Work1   SM+7    ;
                NOTEQ   Verb    1       ;N
                LET     Work1   SM+6    ;
                NOTEQ   Verb    2       ;S
                LET     Work1   SM+9    ;
                NOTEQ   Verb    3       ;E
                LET     Work1   SM+8    ;
                NOTEQ   Verb    4       ;O
                LET     Work1   SM+13   ;
                NOTEQ   Verb    5       ;NE
                LET     Work1   SM+12   ;
                NOTEQ   Verb    6       ;NO
                LET     Work1   SM+11   ;
                NOTEQ   Verb    7       ;SE
                LET     Work1   SM+10   ;

 _      _       SYSMESS [Work1]
                COPYFF  Work1   Cuelga2 ;para ex liana
                SYSMESS FSNL
#ENDIF


$NOCUELGA
_       _       AT      L10
                ISAT    MCuenta2 HERE           ;si la magnetocuenta est  aqu¡
                SETCO   MCuenta2
                LET     Work1   CuentaM+5       ;dice que est  volando alta
                EQ      RistraCt 8              ;lleva la ristra entera
                LET     Work1   CuentaM+7       ;dice que est  volando baja

_       _       AT      L10
                SET     YaL10                   ;permite salvar ya
                ISAT    MCuenta2 HERE           ;si la magnetocuenta est  aqu¡
                MESSAGE [Work1]

_       _       AT      AhogoM          ;muerte en arrecifes
                GOTO    MUERTE          ;antes de listar objetos
                RESTART

;________________________________________________________________________
/PRO EachMove ; Old process 2

_       _       SETCO   [AtaNum1]               ;as¡ si llevas un atascable
                HASNAT  BIG                     ;se atasca antes de arrastrar
                SETCO   [AtaNum2]               ;a uno no arrastrable
                HASAT   BIG
                COPYFF  AtaNum1 Work1
                COPYFF  AtaLoc1 Work2
                COPYFF  AtaNum2 AtaNum1
                COPYFF  AtaLoc2 AtaLoc1
                COPYFF  Work1   AtaNum2
                COPYFF  Work2   AtaLoc2

_       _       ISAT    Liana   NOTCREATED      ;si la liana no est 
                SET     AtaNum1                 ;asegura que no hay nada atado
                CLEAR   AtaLoc1
                SET     AtaNum2
                CLEAR   AtaLoc2

_       _       SETCO   [AtaNum1]               ;actualiza siempre localidad
                COPYFF  COLoc   AtaLoc1         ;de los objs atados
                SETCO   [AtaNum2]
                COPYFF  COLoc   AtaLoc2

_       _       EQ      AtaLoc1 NOTCREATED      ;si un objeto est  destruido
                COPYFF  AtaNum2 AtaNum1         ;deja de estar atado
                COPYFF  AtaLoc2 AtaLoc1
                SET     AtaNum2
                CLEAR   AtaLoc2

_       _       EQ      AtaLoc2 NOTCREATED
                SET     AtaNum2
                CLEAR   AtaLoc2

_       _       ABSENT  Balsa                   ;no podemos estar subidos
                CLEAR   AtBalsa                 ;si la hemos roto o nos movimos

COGER   BALSA   AT      AhogoC                  ;chapuza para no traernos 
                SKIP    $NOATADO                ;el tronco y la liana

COGER   _       WHATO
                NOTEQ   CONum   255             ;si has cogido un chisme atado
                NOTSAME CONum   AtaNum1
                NOTSAME CONum   AtaNum2
                SKIP    $NOATADO

COGER   _       EQ      CONum   255
                SKIP    $NOATADO

COGER   _       NOTCARR Liana                   ;y no llevas la liana
                NOTAT   AhogoC                  ;en cenote es distinto
                COPYFF  CONum   Work6
                SETCO   Liana
                PROCESS CreaGet               ;aunque est‚ en otra loc. la coges
                ISNDONE                         ;si pudo cogerla
                COPYFF  Player  Work1
                LET     Work2   AtaNum1
                PROCESS Tied            ; me traigo el objeto atado 1 (o no)
                LET     Work2   AtaNum2
                PROCESS Tied            ; me traigo el objeto atado 2 (o no)
                SKIP    $NOATADO

COGER   _       NOTCARR Liana                   ;No pudiste cogerla
                NOTAT   AhogoC                  ;en cenote es distinto
                DROP    [Work6]
#if OPICS
                PROCESS DropPic
#endif

$NOATADO
_       _       AT      Barca           ;si est s con el indio
                NOTEQ   BarcaLoc MarT
                ISAT    Contrato HERE   ; y el contrato est  en el suelo
                MES     IndioM+6        ; 'el indio lo coge y'
                SYSMESS 114             ; ' te dice "'
                SYSMESS 117             ; 'gracias'
                EQ      BarcaLoc Playa
                PLACE   Contrato INDIO
                SYSMESS ICSNL

_       _       AT      Barca           ;si est s con el indio
                NOTEQ   BarcaLoc MarT
                NOTEQ   BarcaLoc Playa
                ISAT    Contrato HERE   ; y el contrato est  en el suelo
                MES     IndioM+5        ; 'ahora te vas al agua'
                SYSMESS ICSNL
                PROCESS Tetira          ; 'el indio te tira al agua'

_       _       EQ      Jaguar  1       ;el jaguar est  saltando
                MESSAGE JaguarM+2       ;'te come'
#if !DEBUG
                GOTO    MUERTE
                RESTART
#endif

_       _       AT      Selva5
                NOTEQ   Jaguar  255             ;est  vivo
;                CHANCE  15
                MESSAGE JaguarM+1               ;'salta hacia ti'
                LET     Jaguar  1               ;lo indica

_       _       AT      L3                      ;encuentra la losa suelta
                ZERO    LosaF                   ;aun no la ha pisado
                CHANCE  20              
                MESSAGE LosaM                   ;'notas una losa suelta'
                LET     LosaF    1              ;ya puedes examinarla

_       _       ISNOTAT Collar  L10     ;si el tunel est  abierto y el collar
                NOTZERO Tunel10         ;no est  sobre el bloque
                AT      L10
                MESSAGE BloqM+8         ;'el bloque vuelve a su sitio'

_       _       ISNOTAT Collar  L10     ;si el tunel est  abierto y el collar
                NOTZERO Tunel10         ;no est  sobre el bloque
                MESSAGE BloqM+9         ;te mueres al mover este bloque
                GOTO    MUERTE
                RESTART
                                        
_       _       ZERO    EnAhogo
                SKIP    $NOAGUA

_       _       CLEAR   Work1                   ;para la siguiente entrada
                LET     CONum   Balsa
                NOTZERO AtBalsa                 ;subido a la balsa
                EQ      BalsaCt 2               ;balsa inestable
                CLEAR   AtBalsa                 ;te caes
                MESSAGE BalsaM+6

$OBJLOOP
_       _       SETCO   [Work1]                 ;todo lo que est‚ en el cenote
                ISAT    [Work1] HERE
                NOTSAME CONum   AtaNum1         ;sin atar
                NOTSAME CONum   AtaNum2
                DESTROY [CONum]
                MES     CenotM                  ;desaparece en el cenote
                SYSMESS FSNL

_       _       NOTEQ   Work1   LASTOBJ
                PLUS    Work1   1
                SKIP    $OBJLOOP

;               si tiene cuentas se pegan
$NOAGUA
_       _       ZERO    RistraCt                ;no lleva ristra ni cuenta imix
                NOTCARR MCuenta1
                DONE ;***

_       _       LET     Work1   CARRIED
                LET     Work3   ISBEAD
                PROCESS ObjCt                   ;cuenta las cuentas que llevamos
                ZERO    Work2                   ;si no llevamos
                DONE ;***

#IF OPICS
 _      _       LET     Work2   Ristra          ;para OPatch
                CARRIED MCuenta1
#ELSE
 _      _       CARRIED MCuenta1
#ENDIF
                DESTROY MCuenta1
                LET     LastLink MCuenta1       ;el ultimo eslabon es el primero
#IF OPICS
                LET     Work2   MCuenta1        ;para OPatch
#ENDIF

_       _       DOALL   CARRIED
                WHATO
                HASAT   ISBEAD
                COPYFF  CONum   Work1
                PUTO    RISTRA
#IF OPICS
                PROCESS DropPic
#ENDIF
                MES     RistraM                 ;'_ se une a'
                SETCO   [LastLink]
                SYSMESS SUFS                    ;'_\s.'
                NEWLINE
                COPYFF  Work1   LastLink        ;este es ahora el ultimo eslabon
                PLUS    RistraCt 1              ;una cuenta m s
                PLACE   Ristra  CARRIED
#IF OPICS
                SETCO   [Work2]                 ;la primera vez
                LET     Work6   Ristra
                PROCESS OPatch                  ;sustituye MCuenta
                LET     Work2   Ristra          ;y luego  ristra
#ENDIF

;$$$ Si se a¤ade algo aqu¡ cambiar los 'DONE ;***' por skips
;________________________________________________________________________
/PRO Response ; Command decoder

#if DEBUG
 f      RAM     goto    Playa
                create  Fruta
                create  Espina
                create  Bambu
                create  Cajon
                set     CajonF
                place   Collar  L10
                place   Tronco1 L10
                place   Tronco2 L10
                place   Tronco3 L10
                place   Tronco4 L10
                place   Liana   L10
                restart

 i      kuill   clear HayPic
                restart

 i      ram     newline
                print FBN
                space
                print FBS
                space
                print FBE
                space
                print FBO
                space

 i      ram     newline
                print Tunel0
                tab   4
                print Tunel1
                tab   8
                print Tunel2
                tab   12
                print Tunel3
                tab   16
                print Tunel4
                tab   20
                print Tunel5
                tab   24
                print Tunel6
                tab   28
                print Tunel7
                tab   32
                print Tunel8
                tab   36
                print Tunel9
                tab   40
                print Tunel10

 x      ram     notzero EnLabe
                set     Tunel0
                set     Tunel1
                set     Tunel2
                set     Tunel3
                set     Tunel4
                set     Tunel5
                set     Tunel6
                set     Tunel7
                set     Tunel8
                set     Tunel9
 ;               set     Tunel10

 pon    ram     absent  Ristra
                create  Cuenta1
                create  Cuenta2
                create  Cuenta3
                create  Cuenta4
                create  Cuenta5
                create  Cuenta6
                create  Cuenta7
                create  Cuenta8
                place   MCuenta1 CARRIED
 #if OPICS
                process GetPic
 #endif
                ok

#endif

;
;-Special movements
;

#IF BIGMEM
 BAJAR   _      AT      Barca                   ;si te tiras con contrato
                EQ      BarcaLoc MarI
                MESSAGE BarcaM+7                ;el indio te saca
                DONE

 BAJAR   _      AT      Barca                   ;si te tiras en la tormenta
                EQ      BarcaLoc MarT           ;morir s
                MESSAGE BarcaM+8
                GOTO    MUERTE
                RESTART
#ENDIF

BAJAR   _       AT      Barca
                EQ      BarcaLoc Playa
                NOTCARR Contrato                ;el indio no nos deja llevarlos
                NOTCARR Cuerda
#IF BIGMEM
 ;por curarme en salud, nunca va a ser necesario
                NOTCARR Remo
#ENDIF
                MESSAGE IndioM+1                ;el indio te deja pasar
                NOTDONE                         ;para mover al jugador

BAJAR   _       AT      Barca
                EQ      BarcaLoc Playa
                MESSAGE IndioM                  ;el indio no te deja bajar
                DONE

BAJAR   _       AT      Selva4
                ZERO    HayFoso         ; no ha encontrado el foso
                NOTDONE

BAJAR   _       AT      Selva4
                NOTZERO NOCarr
                MESSAGE FosoM+1         ;'resbalas y caes'
                SET     Empalado

BAJAR   _       AT      Selva4
                GOTO    Foso
                RESTART

SUBIR   _       AT      Foso
                NOTZERO NOCarr
                MESSAGE FosoM+1         ;'resbalas y caes'
                SET     Empalado
                RESTART

_       _       GT      Verb    0       ; una de las direcciones
                LT      Verb    9       ;menos saltar,entrar,salir,subir o bajar
                NOTEQ   Verb    2       ;SUR (puede volverse si quiere)
                NOTEQ   Verb    7       ;SE
                NOTEQ   Verb    8       ;SO
                AT      Selva4
                ZERO    HayFoso         ; no ha encontrado el foso
                MESSAGE FosoM           ; Find it the hard way
                SET     Empalado
                GOTO    Foso
                RESTART

N       _       AT      Selva3
                ZERO    Mono            ;est  vivo
                MESSAGE MonoM+1         ;te tiran cocos y no te dejan pasar
#if DEBUG
                notdone
#endif
                DONE

_       _       AT      Selva5
                NOTEQ   Jaguar  255     ;est  vivo
                LT      Verb    13      ;intentas escaparte
                MESSAGE JaguarM+2       ;te come
#if !DEBUG
                GOTO    MUERTE
#else
                notdone
#endif
                RESTART

SUBIR   TRONCO  AT      AhogoC
                ABSENT  Tronco1
                ABSENT  Tronco2
                ABSENT  Tronco3
                ABSENT  Tronco4
                SYNONYM SUBIR BALSA
                WHATO

SUBIR   TRONCO  AT      AhogoC
                MESSAGE BalsaM+6        ;es inestable y te vas al agua
                DONE

SUBIR   BALSA   PRESENT Balsa
                ZERO    AtBalsa         ;si no est s subido
                SET     AtBalsa
                CLEAR   AhogTrn         ;para turnos para ahogarse
                OK

SUBIR   BALSA   NOTZERO AtBalsa
                MESSAGE BalsaM+5        ;'ya estas subido, bobo'
                DONE

SUBIR   BALSA   SYSMESS UCantS          ;como si no fuera una direccion
                DONE

BAJAR   BALSA   NOTZERO AtBalsa
                CLEAR   AtBalsa
                OK

BAJAR   BALSA   SYSMESS UCantS          ;como si no fuera una direccion
                DONE

SALTAR  _       ATGT    L7-1
                ATLT    L9+1
                SYNONYM E       _

E       _       ATGT    L7-1
                ATLT    L9+1
                SYSMESS SaltoS          ;saltas a los arrecifes
                PAUSE   200
                DROPALL                 ;por si la liana atascada
                NOTDONE
#IF !DRAW
 SALTAR _       AT      Plaza           ;aqu¡ tambien hay arrecifes
                SYNONYM E       _

 E      _       AT      Plaza
                SYSMESS SaltoS          ;saltas a los arrecifes
                PAUSE   200
                DROPALL
                NOTDONE

#ENDIF

_       _       NOTAT   Cenote
                SKIP    $NOCENOTE

N       _       SYNONYM E       _

O       _       SYNONYM E       _

E       _       MESSAGE TunelM+3        ;te caes a los arrecifes
#IF OPICS
                LET     Work1   CARRIED ;se te cae todo lo que llevas
                LET     Work2   HERE
                SET     Work3
                SET     Work4
                PROCESS ObjMov
#ELSE
                DROPALL
#ENDIF
                ANYKEY
                NOTDONE

BAJAR   LIANA   ABSENT  Liana
                SYSMESS 26              ;'no est  a tu alcance'
                DONE

BAJAR   LIANA   NOTEQ   AtaLoc1 L10     ;no hay objeto atascado
                NOTEQ   AtaLoc2 L10
                MESSAGE CenotM+3        ;'te caes'
                MESSAGE CenotM+4        ;'te ostias en el cenote'
                GOTO    MUERTE
                RESTART

BAJAR   LIANA   CREATE  Liana           ;in case it was carried
#IF OPICS
                PROCESS DropPic
#ENDIF
                NOTZERO NOCarr          ;si no tienes las manos vac¡as
                MESSAGE FosoM+1         ;'resbalas y caes'
                PAUSE   100
                MESSAGE CenotM+4        ;'te ostias en el cenote'
                GOTO    MUERTE
                RESTART

BAJAR   LIANA   MESSAGE CenotM+5        ;'Bajas por la liana'
                ANYKEY
                NOTDONE                 ;para moverle

BAJAR   _       SYNONYM SALTAR  _

SALTAR  _       SYSMESS SaltoS
                PAUSE   200
                MESSAGE CenotM+4         ;'te ostias en el cenote'
                GOTO    MUERTE
                RESTART

$NOCENOTE
SUBIR   _       AT      AhogoC
                NOTZERO NOCarr
                MESSAGE FosoM+1         ;con las manos llenas no puede
                DONE

#IF BIGMEM
 SUBIR  LIANA   NOTZERO Cuelgade        ;la liana cuelga
                GT      NOCarr  1
                MESSAGE FosoM+1         ;con las manos llenas no puede
                DONE

 SUBIR  LIANA   NOTZERO Cuelgade        ;la liana cuelga
                EQ      NOCarr  1
                NOTCARR Liana           ;si lleva algo, esto es lo unico
                MESSAGE FosoM+1         ;que puede llevar
                DONE

 SUBIR  LIANA   NOTZERO Cuelgade        ;la liana cuelga
                GOTO    [Cuelgade]      ;trepamos
                RESTART

#ENDIF
;
;-Assorted stuff
;

ESPERAR _       SYSMESS 35              ;'el tiempo pasa'
                DONE

_       LOSA    ZERO    LosaF           ;no la ha encontrado a£n
                MESSAGE LosaM+1         ;'qu‚ losa?'
                DONE

NADAR   _       NOTZERO EnAhogo         ;si viene a cuento
                ZERO    AtBalsa
                SYSMESS DoinItS         ;'ya estoy nadando'
                DONE

EXCAVAR _       AT      Selva4
                ZERO    HayFoso         ; encuentra el foso
                SET     HayFoso
                MESSAGE FosoM+2
                DONE

MOVER   BALSA   ABSENT  Balsa
                NOTDONE

MOVER   BALSA   MESSAGE BalsaM+1        ;la mueves
                AT      Cenote
                SYNONYM TIRAR   BALSA

MOVER   LOSA    AT      L3
                SYSMESS 15
                NOTEQ   LosaF   255
                SET     LosaF           ;encuentras la runa
                CREATE  Runa5
                MESSAGE FindOM
                DONE

MOVER   BLOQUE  NOTZERO EnLabe
                ATLT    L10             ;Plaza y L1 a L9
                PROCESS ProBloques      ;tienen bloques normales
                DONE

PISAR   BLOQUE  AT      L10
                SYNONYM MOVER BLOQUE

MOVER   BLOQUE  AT      L10
                ZERO    Tunel10         ;y el tunel est  cerrado
                MESSAGE BloqM+7         ;'presi¢n incorrecta'
                MESSAGE BloqM+9         ;te mueres al mover este bloque
                GOTO    MUERTE
                RESTART

#IF BIGMEM
 SALVAR INDIO   NOUN2   CUERDA
                EQ      BarcaLoc MarT
                CARRIED Cuerda
                MESSAGE LanzaM+4        ;la cuerda no llega
                DONE

 SALVAR INDIO   NOUN2   REMO
                EQ      BarcaLoc MarT
                CARRIED Remo
                MESSAGE LanzaM+5        ;el remo tampoco
                DONE
#ENDIF

SALVAR  INDIO   AT      Barca
                EQ      BarcaLoc MarT
                SYSMESS HowS            ;'¨C¢mo?
                DONE

TIRAR   TODO    DOALL   CARRIED

TIRAR   BALSA   PRESENT Balsa           ;$$$ VER 'EMPUJAR BALSA'
                PUTO    CARRIED         ;ojo con esto

TIRAR   _       WHATO
                NOTCARR [CONum]
                NOTEQ   CONum Liana    ;basta con que est‚ present
                SYSMESS 28
                DONE

TIRAR   _       WHATO
                NOTAT   Barca
                SKIP    $NOBARCA

TIRAR   CONTRA  SYSMESS TiraS           ;'¨Tirar @?'
                SYSMESS MeniegoS        ;'Ni hablar'
                DONE

TIRAR   CUERDA  EQ      BarcaLoc MarT
                MESSAGE LanzaM+4        ;la cuerda no llega
                DONE

TIRAR   REMO    NOTZERO Remoatado       ;si est  atado
                CARRIED Cuerda          ;y tienes cogida la cuerda
                PUTO    INDIO           ;el indio tiene ahora el remo
#IF OPICS
                PROCESS DropPic
#ENDIF
                MESSAGE BarcaM+5        ;salvas al indio
                LET     BarcaLoc Playa  ;y pasas a la siguiente loc
                CLEAR   IndioT          ;ya no se lo van a comer
                CLEAR   Remoatado       ;desatamos el remo
                RESTART


TIRAR   _       DESTROY [CONum]
#IF OPICS
                PROCESS DropPic
#ENDIF
                MES     LanzaM+2
                EQ      CONum   Remo    ;era tirar remo
                SETCO   Cuerda
                NOTZERO Remoatado       ;si estaba atado
                DESTROY Cuerda
                MES     LanzaM+3        ;no tienes cogida la cuerda y la pierdes

TIRAR   _       NEWLINE
                DONE

$NOBARCA
TIRAR   _       AT      Foso            ; lanza cosas fuera del foso
                CARRIED [CONum]
                PUTO    Selva4
#if OPICS
                PROCESS DropPic
#endif
                MES     LanzaM          ; 'lo has tirado'
                MESSAGE LanzaM+1        ; 'cae fuera del foso'
                DONE

TIRAR   _       NOTAT   Cenote
                SYNONYM DEJAR   _

TIRAR   LIANA   PRESENT Liana
                NOTEQ   AtaNum1 255     ;lleva algo atado
                MES     AtaM+5          ;lo dice y punto
                SYSMESS FSNL
                DONE                    ;hasta que no deje dicho objeto

;TIRAR   BALSA   PRESENT Balsa           ;$$$ VER 'EMPUJAR BALSA'
;                PUTO    CARRIED         ;ojo con esto

TIRAR   _       NOTSAME CONum   AtaNum1
                NOTSAME CONum   AtaNum2 ;no est  atado
                DESTROY [CONum]
#if OPICS
                PROCESS DropPic
#endif
                MES     CenotM          ;'desaparece'
                SYSMESS FSNL
                DONE

TIRAR   _       COPYFF  AtaNum2 Work1   ;work1 tiene el objeto de la otra punta
                LET     Work2   AtaLoc1 ;para cambiar la loc del obj que tiramos
                NOTSAME CONum   AtaNum1 ;pero si hemos tirado el 2
                COPYFF  AtaNum1 Work1
                LET     Work2   AtaLoc2 ;para cambiar la loc del obj que tiramos

TIRAR   _       EQ      Work1   255     ;no hay otro objeto
                DESTROY [CONum]
#if OPICS
                PROCESS DropPic
#endif
                MES     CenotM          ;'desaparece'
                DESTROY Liana
#if OPICS
                PROCESS DropPic
#endif
                MES     CenotM+1        ;'llevandose la liana'
                SYSMESS FSNL
                DONE

TIRAR   _       SETCO   [Work1]           ;el otro
                COPYFF  COWei   Work3     ;para la siguiente entrada
                HASAT   BIG               ;es atascable
                ISAT    [Work1] L10       ;y est  atascado
                WHATO                     ;recupera current
                SKIP    $SECUELGA

TIRAR   _       WHATO                   ;recupera current
                SMALLER Work3   COWei   ;si hemos tirado el + pesado (o =)
                DESTROY [CONum]
#if OPICS
                PROCESS DropPic
#endif
                MES     CenotM          ;'desaparece'
                DESTROY Liana
#if OPICS
                PROCESS DropPic
#endif
                MES     CenotM+1        ;'llevandose la liana'
                SYSMESS 47              ;' y '
                DESTROY [Work1]
#if OPICS
                PROCESS DropPic
#endif
                SYSMESS U               ;'_'
                SYSMESS FSNL
                DONE

$SECUELGA
TIRAR   _       PUTO    AhogoC            ;dentro del cenote
#if OPICS
                PROCESS DropPic
#endif
                LET     [Work2] AhogoC
                MESSAGE CenotM+2          ;se cuelga
                DONE

#if BIGMEM
 QUITAR PIEL    NOUN2   JAGUAR
                SYNONYM DESPElleja JAGUAR

 QUITAR PIEL    NOUN2   MONO
                SYNONYM DESPElleja MONO

 DESPE  _       PROCESS Hachas          ;distingue hacha y hachuela
                ISNDONE                 ;no tienes ninguna de las 2
                NOTDONE

 DESPE  MONO    PRESENT MonoK
                MES     HachaM          ;'con el hacha/hachuela'
                SYSMESS [Work2]         ;respeta g‚nero hacha/hachuela
                SPACE
 #IF OPICS
                SETCO   MonoK
                LET     Work6   MonoD
                PROCESS OPatch
 #ENDIF
                SWAP    MonoK   MonoD
                CREATE  PielM
                MESSAGE HachaM+2        ;'despellejas al mono '
                GET     PielM
 #IF OPICS
                PROCESS GetPic
 #ENDIF
                DONE

 DESPE  JAGUAR  PRESENT JaguarK
                MES     HachaM          ;'con el hacha/hachuela'
                SYSMESS [Work2]         ;respeta g‚nero hacha/hachuela
                SPACE
 #IF OPICS
                SETCO   JaguarK
                LET     Work6   JaguarD
                PROCESS OPatch
 #ENDIF
                SWAP    JaguarK JaguarD
                CREATE  PielJ
                MESSAGE HachaM+2        ;'despellejas al jaguar'
                GET     PielJ
 #IF OPICS
                PROCESS GetPic
 #ENDIF
                DONE

 DESPE  _       NOTDONE

#ENDIF

MATAR   MONO    NOUN2   CERBAT          ;si lleva la cerbatana
                CARRIED Bambu
                AT      Selva3          ;y viene a cuento
                SYNONYM SOPLAR CERBAT   ;a buen entendedor...
                WHATO

MATAR   MONO    AT      Selva3          ;si no
                ZERO    Mono
                SYSMESS 26              ;'no est  a tu alcance'
                DONE

MATAR   JAGUAR  NOUN2   ESTACA          ;lo matas con la estaca
                CARRIED Estaca          ;si la llevas
                AT      Selva5
                SET     Jaguar
                MESSAGE JaguarM+3
                CREATE  JaguarK         ;jaguar muerto
                DONE

MATAR   JAGUAR  NOUN2   CERBAtana       ;le tiras con la cerbatana
                SYNONYM SOPLAR CERBAT
                WHATO

MATAR   JAGUAR  GT      Noun2   HachaW-2 ;hacha o hachuela
                LT      Noun2   HachaW+1
                PROCESS Hachas
                ISDONE                   ;si la llevas
                AT      Selva5
                MES     JaguarM+5        ;no te sale bien
                SPACE
                MESSAGE JaguarM+2        ; y te come
                GOTO    MUERTE
                RESTART

MATAR   JAGUAR  AT      Selva5
                EQ      Jaguar  1
                SYSMESS ComoS           ;c¢mo lo mato?
                DONE

MATAR   INDIO   AT      Barca
                EQ      BarcaLoc MarT
                MESSAGE IndioM+2        ;el indio est  en el agua
                DONE

MATAR   INDIO   AT      Barca
                MES     IndioM+4        ;el indio te puede
                GOTO    MUERTE
                RESTART

MATAR   GUSANO  PRESENT Gusano
                SYSMESS GusanS
                DESTROY Gusano
#IF OPICS
                PROCESS DropPic
#ENDIF
                DONE

;$$$ OHO: al soplar cerbatana supongo que solo puede contener el contrato
;         y/o la fruta (ensartada o no)
SOPLAR  CERBAT  NOTCARR Bambu           ; si no la tienes
                SYSMESS 49              ; 'no la tienes'
                DONE

SOPLAR  CERBAT  EQ      COWei PBambu    ; Vacia
                MESSAGE BambuM+4        ; pos vale pos bueno
                DONE

SOPLAR  CERBAT  ISAT    Contrato Bambu  ;Con el contrato y nada m s
                EQ      COWei PBambu+PContrato
                MESSAGE BambuM+4        ; pos vale pos bueno
                DONE

;Si llega aqu¡ es que la cerbatana est  cargada, ya sea con pua o sin ella
SOPLAR  CERBAT  SETCO   Fruta           ;por defecto
                ISAT    FruEsp  Bambu
                SETCO   FruEsp          ;CO es con lo que est  cargada la ca¤a

SOPLAR  CERBAT  COPYFF  CONum   Work1   ;lo salvamos
                PUTO    [Player]        ;y lo ponemos en el suelo
                SETCO   Fruta           ;diremos 'La fruta' aunque tenga la pua
                MESSAGE BambuM+5        ;'_ sale disparada'
                EQ      Work1   FruEsp  ;mata
                AT      Selva3          ;donde los monos
                ZERO    Mono            ;el mono est  vivo
                MES     MonoM+2         ;le matas
                LET     Work2   MonoM+3 ;no has examinado al mono por defecto
                NOTZERO MonoEx
                LET     Work2   MonoM+4 ;lo has examinado

SOPLAR  CERBAT  EQ      Work1   FruEsp  ;contin£a la entrada anterior
                AT      Selva3          ;acabando el mensaje
                ZERO    Mono
                MES     [Work2]
                MESSAGE MonoM+5
                SET     Mono            ;crea el mono muerto y el cascabel
                CREATE  MonoK
                CREATE  Cascabel
                CREATE  FruEsp          ;y la fruta ensartada
                DONE

SOPLAR  CERBAT  AT      Selva5          ;donde el jaguar
                ZERO    Jaguar          ; y est  vivo
                MES     JaguarM+4       ;le irritas
                SPACE                   ;(da igual que tenga pua o no)
                MESSAGE JaguarM+2       ;te come
                GOTO    MUERTE
                RESTART

#IF BIGMEM
 SOPLAR _       EQ      Noun1   255
                EQ      Noun2   255
                OK                      ;siempre se puede soplar anyway
#ENDIF

#if BIGMEM
 COMER  JAGUAR  ABSENT  JaguarK
                ABSENT  JaguarD
                NOTDONE

 COMER  JAGUAR  MESSAGE ComerM          ;'ni de co¤a'
                DONE

 COMER  MONO    ABSENT  MonoK
                ABSENT  MonoD
                NOTDONE

 COMER  MONO    MESSAGE ComerM          ;'ni de co¤a'
                DONE
#ENDIF

ATAR    PAPAYA  PRESENT Papaya
                MESSAGE AtaM+9          ;est  demasiado blanda
                DONE

ATAR    REMO    NOUN2   CUERDA
                PRESENT Remo
                CARRIED Cuerda
                ZERO    Remoatado
                SET     Remoatado
                MES     AtaM+1          ;'atas _ con'
                SETCO   Cuerda
                SYSMESS SUFS
                NEWLINE
                DONE

ATAR    PALO    NOUN2   HACHUela
                SYNONYM HACER   HACHA

ATAR    HACHU   NOUN2   PALO
                SYNONYM HACER   HACHA

;ATAR    TRONCOS SYNONYM HACER   BALSA  ;no funciona si intenta atar la liana 
                                        ;a un tronco

ATAR    _       NOTEQ   Noun1   LianaW
                PRESENT Liana
                COPYFF  Noun1   Noun2
                COPYFF  Adject1 Adject2
                SYNONYM ATAR    LIANA
                EQ      Noun2   255     ;si no dio un nombre v lido
                NOTDONE                 ;no puedes hacerlo

ATAR    LIANA   CARRIED Liana
                EQ      Noun2   255
                SYSMESS AqueS
                DONE

ATAR    LIANA   CARRIED Liana
                PROCESS MakeO2
                PRESENT [O2Num]         ;present por la balsa que no pots coger
                SETCO   [O2Num]
                HASAT   ATABLE
                SKIP    $CANTIE

ATAR    LIANA   NOTDONE

$CANTIE
ATAR    LIANA   LET     Work1   AtaNum1
                NOTEQ   AtaNum1 255
                LET     Work1   AtaNum2
                NOTEQ   AtaNum2 255
                MESSAGE AtaM            ;'atados los dos cabos'
                DONE

ATAR    LIANA   SAME    AtaNum1 O2Num   ;intenta atar dos veces a lo mismo
                SYSMESS 80
                DONE

ATAR    LIANA   COPYBF  [Work1] O2Num   ;num y loc. donde est  el objeto
                PLUS    Work1   1       ;atado al cabo correspondiente
                COPYBF  [Work1] O2Loc
                MES     AtaM+1          ;'atas _ con'
                SETCO   Liana
                SYSMESS SUFS
                NEWLINE
                DONE

DESATAR REMO    PRESENT Remo
                PRESENT Cuerda
                NOTZERO Remoatado
                CLEAR   Remoatado
                MESSAGE AtaM+2          ;'desatas _.'
                DONE

DESATAR _       NOTEQ   Noun1   LianaW
                SAME    CONum   AtaNum1
                COPYFF  Noun1   Noun2
                SYNONYM DESATAR LIANA

DESATAR _       NOTEQ   Noun1   LianaW
                SAME    CONum   AtaNum2
                COPYFF  Noun1   Noun2
                SYNONYM DESATAR LIANA

DESATAR LIANA   PRESENT Liana
                EQ      Noun2   255
                SYSMESS DequeS
                DONE

DESATAR LIANA   AT      AhogoC          ;donde la liana nunca estar 
                EQ      Noun2   255     ;pero es como si siempre estuviera
                SYSMESS DequeS
                DONE

DESATAR LIANA   PROCESS MakeO2
;               PRESENT Liana
                PRESENT [O2Num]
                SETCO   [O2Num]
                SKIP    $CANUNTIE

DESATAR LIANA   NOTDONE

$CANUNTIE
DESATA  LIANA   SAME    O2Num   AtaNum1
                COPYFF  AtaNum2 AtaNum1
                COPYFF  AtaLoc2 AtaLoc1
                SKIP    $ARRAS

DESATA  LIANA   NOTSAME O2Num   AtaNum2
                MESSAGE AtaM+3                  ;'la liana no est  atada a _'
                DONE

$ARRAS
DESATA  LIANA   SET     AtaNum2
                CLEAR   AtaLoc2
                MESSAGE AtaM+2                  ;'desatas la liana'
                ISAT    [AtaNum1] AhogoC        ;el otro estaba colgando
                SETCO   [AtaNum1]
                DESTROY [CONum]
#if OPICS
                PROCESS DropPic
#endif
                MES     CenotM          ;'desaparece'
                DESTROY Liana
#if OPICS
                PROCESS DropPic
#endif
                MES     CenotM+1        ;'llevandose la liana'
                SYSMESS FSNL
                DONE

DESATA LIANA    NOUN2   Balsa
                AT      AhogoC          ;si estamos en el fondo del cenote
                NOTZERO AtBalsa         ;en la balsa
                MESSAGE FinaleM         ;nos vamos
                END

HACER   HACHA   CARRIED Hachuela
                CARRIED Liana
                CARRIED Palo
                DESTROY Liana
#if OPICS
                PROCESS DropPic
#endif
                DESTROY Hachuela
#if OPICS
                PROCESS DropPic
#endif
                PLACE   Hacha   CARRIED
                DESTROY Palo
#if OPICS
                LET     Work6   Hacha
                PROCESS OPatch
#endif
                MESSAGE HachaM+3        ;'haces un hacha'
                DONE

HACER   BALSA   NOTCARR Liana                   ;sin lianas no atas troncos
                NOTDONE

HACER   BALSA   ISNOTAT Balsa   NOTCREATED      ;ya hay una balsa rulando
                SYSMESS YaTengoS+1              ;'ya he hecho una'
                DONE

HACER   BALSA   COPYFF  Player  Work1
                LET     Work3   ISTRONCO
                PROCESS ObjCt                   ;cuenta los troncos que habr 
                COPYFF  Work2   BalsaCt         ;en la balsa
                LET     Work1   CARRIED         ;usa todos los troncos que pille
                PROCESS ObjCt
                ADD     Work2   BalsaCt         ;numero total de troncos
                LT      BalsaCt 2               ;hacen falta 2 troncos m¡nimo
                NOTDONE

HACER   BALSA   DESTROY Liana
#IF OPICS
                PROCESS DropPic
                SET     Work4
#ENDIF
                LET     Work2   BALSA
                PROCESS ObjMov
                COPYFF  Player  Work1
                PROCESS ObjMov
#IF OPICS
                CLEAR   Work4
#ENDIF
                CREATE  Balsa
                MESSAGE BalsaM                  ;te haces una balsa
                DONE

HACER   _       NOTDONE

DESHAZ  BALSA   ABSENT  Balsa
                NOTDONE

DESHAZ  BALSA   ISAT    Balsa   NOTCREATED      ;no hay balsa
                NOTDONE

DESHAZ  BALSA   NOTCARR Hacha
                MESSAGE BalsaM+2                ;no puedes cortar las lianas
                DONE

DESHAZ  BALSA   DESTROY Balsa
                LET     Work1   BALSA           ;pone los troncos de la balsa
                COPYFF  Player  Work2           ;en el suelo
                SET     Work3                   ;sin atribs
                PROCESS ObjMov
                MESSAGE BalsaM+3        ;deshaces la balsa
                DONE
;------------------------
; ts.sce        \/  \/
;
;AD       _       MESSAGE ??             ;$$$ ya veremos
;                 DONE

REMAR   _       CARRIED Remo            ;solo puede pasar en la tormenta
                MESSAGE BarcaM+6
                DONE

REMAR   _       SETCO   Remo
                SYSMESS 49              ;'no tienes los remos'
                DONE

DIBUJos _       CLEAR   Piccies         ; Select graphics
                RESTART

TEXTO   _       SET     Piccies         ; or text mode
                PROCESS SetText
                RESTART

;SAVE    _       NOTZERO EnLabe          ;en las estancias
;                ZERO    YaL10           ;y a£n no ha llegado al final
;                SYSMESS MagicNoS        ;no valen trucos
;                DONE

SAVE    RAM     RAMSAVE
                SYSMESS 15              ; Not going to affect mode
                DONE

SAVE    _       SAVE    0
                DONE

LOAD    RAM     RAMLOAD 255
                PROCESS SetText         ; Fool the mode
                RESTART                 ; This will set the correct one

LOAD    RAM     NOTDONE

#IF !DRAW
 LOAD   _       PROCESS DoLoad          ; Load and change modes as needed
#ELSE
 LOAD   _       LOAD    0
#ENDIF
                PROCESS SetText         ; Fool the mode
                RESTART                 ; This will set the correct one

FIN     _       SYSMESS 18
                QUIT
                END

FIN     _       DONE                    ;Not like QUIT on PAW

SALIDAS _       PROCESS Salidas
                DONE


COMER   _       NOTCARR [CONum]         ; you don't have it
                PRESENT [CONum]
                SYSMESS 49              ; But it is here
                DONE

COMER   _       NOTCARR [CONum]
                SYSMESS 26
                DONE

COMER   _       HASAT   EDIBLE
                DESTROY [CONum]
#if OPICS
                 PROCESS DropPic
#endif
                SYSMESS 130             ; Will drop through table
                HASAT   POISON
                SYSMESS 131             ; Bad taste
                LET     Poisoned PoisT  ; moves to die
                AT      Barca
                NOTEQ   BarcaLoc MarT
                SYSMESS MaliciaS        ; el indio te mira con malicia
;                DONE


; - Opening and closing things  0=CLOSED 255=OPEN

#IF BIGMEM
 ABRIR  CAJON   AT      Barca
                ZERO    CajonF
                SET     CajonF
                SYSMESS OpenS
                DONE

 ABRIR  CAJON   AT      Barca
                PROCESS Open            ;ya lo estaba
                DONE

 CERRAr CAJON   AT      Barca
                NOTZERO CajonF
                CLEAR   CajonF
                SYSMESS CloseS
                DONE

 CERRAR CAJON   AT      Barca
                SYSMESS 73              ;ya lo estaba
                PROCESS AdjSex
                SYSMESS FSNL
                DONE
#ENDIF

; Drop objects
DEJAR   LIANA   CARRIED [AtaNum1]       ;si lleva uno de los objetos atados
                MES     AtaM+5          ;no puede soltar la liana
                SYSMESS FSNL
                DONE                    ;hasta que no deje dicho objeto

DEJAR   LIANA   CARRIED [AtaNum2]
                MES     AtaM+5
                SYSMESS FSNL
                DONE

DEJAR   TODO    DOALL   CARRIED


DEJAR   CUENTA  NOTZERO RistraCt                ;lleva la ristra
                EQ      COLoc   RISTRA          ;si est  en la ristra
                SYNONYM DEJAR   RISTRA

DEJAR   CUENTA  EQ      CONum   MCuenta1        ;la volante huidiza
                CARRIED MCuenta1
                SYSMESS 39                      ;'dejas la cuenta'
                MESSAGE CuentaM+2               ;'se va volando'
                AT      Altar
                MESSAGE CuentaM+3               ;se coloca sobre el altar

DEJAR   CUENTA  EQ      CONum   MCuenta1
                CARRIED MCuenta1
                PUTO    Altar
#if OPICS
                PROCESS DropPic
#endif
                DONE

DEJAR   RISTRA  NOTZERO RistraCt
                SYSMESS 39                      ;'dejas la ristra'
#if OPICS
                PROCESS DropPic
#endif
                LET     Work1   RISTRA
                COPYFF  Player  Work2
                SET     Work3
                PROCESS ObjMov
                PLACE   MCuenta1 Altar
                MESSAGE CuentaM+2               ;'se va volando'
                LET     Work1   RistraM+1       ;'varias cuentas caen'
                EQ      RistraCt 1
                LET     Work1   RistraM+2       ;'La otra cae'

DEJAR   RISTRA  NOTZERO RistraCt
                MES     [Work1]
                MESSAGE RistraM+3               ;'al suelo'
                AT      Altar
                MESSAGE CuentaM+3               ;se coloca sobre el altar

DEJAR   RISTRA  EQ      RistraCt 8              ;si lo que lleva es la ristra
                AT      L10                     ;entera, la Oc est  baja
                SETCO   MCuenta2
                MESSAGE CuentaM+8               ;pues sube

DEJAR   RISTRA  NOTZERO RistraCt
                CLEAR   RistraCt
                DESTROY Ristra
#if OPICS
                PROCESS DropPic
#endif
                DONE

DEJAR   _       AUTOD
#if OPICS
                PROCESS DropPic
#endif

DEJAR   SELLO   COPYFF  CONum   Work1
                MINUS   Work1   Runa1
                PLUS    Work1   RunaT
                SETCO   [CONum]         ;actualiza COLoc!
                SAME    [Work1] COLoc
                COPYFF  CONum   Work1
                MINUS   Work1   Runa1-Cuenta1
                MESSAGE RunaM+1                 ;'@ se convierte en una cuenta'
                DESTROY [CONum]
                CREATE  [Work1]
                DONE

DEJAR   SELLO   MESSAGE RunaM+2                 ;'la runa tiembla un poquito'
                DONE

;QUITAR  TODO    DOALL   WORN
;
;QUITAR  _       AUTOR
;#if OPICS
;                PROCESS GetPic
;#endif
;                DONE


PONER   COLLAR  CARRIED Collar
#if OPICS
                 PROCESS DropPic
#endif
                MESSAGE CollarM+1
                GOTO    MUERTE
                RESTART

PONER   TODO    DOALL   CARRIED

PONER   _       AUTOW
#if OPICS
                 PROCESS DropPic
#endif

PONER   _       DONE

CLAVAR  PUA     NOUN2   FRUTA
                SYNONYM METER  PUA

METER   PUA     NOUN2   FRUTA
                CARRIED Fruta
                CARRIED Espina
                DESTROY Espina
#if OPICS
                 PROCESS DropPic
#endif
                PLACE   FruEsp  CARRIED
                DESTROY Fruta
#if OPICS
                LET     Work6   FruEsp
                PROCESS OPatch
#endif
                SYSMESS 15
                SYSMESS ClavaS          ; 'la pua se impregna de veneno'
                DONE

METER   _       NOUN2   BLOQUE          ;solo puedes poner el collar
                NOTDONE                 ;y eso ya lo controlo arriba

; - Putting things in and out of containers
METER   _       PROCESS MakeO2          ; Get data for object 2
                ABSENT  [O2Num]         ; Not here
                SYSMESS 26
                NEWTEXT
                DONE

METER   _       ZERO    O2Con           ; Not a container
                NEWTEXT
                NOTDONE

METER   _       SAME    CONum   O2Num   ;intentas meter un obj en s¡ mismo
                NOTDONE
#IF BIGMEM
 METER  _       NOUN2   CAJON
                ZERO    CajonF
                SETCO   Cajon
                PROCESS Closed
                DONE
#ENDIF

METER   TODO    DOALL   CARRIED

METER   _       HASAT   O2+SMALL        ; It is a small container
                HASNAT  SMALL           ; and its not a small object
                SYSMESS 86
                COPYFF  O2Num CONum     ; Fool _
                SYSMESS SUFS            ; _.
                NEWLINE
                DONE

#IF BIGMEM
 METER  _       NOUN2   Cajon
                HASAT   BIG
                SYSMESS 86
                COPYFF  O2Num CONum     ; Fool _
                SYSMESS SUFS            ; _.
                NEWLINE
                DONE
#ENDIF

METER   _       NOUN2   CA¥A            ;metes algo peque¤o en la ca¤a
                NOTEQ   CONum   Fruta   ;estos tres se quedan en la ca¤a
                NOTEQ   CONum   FruEsp
;               NOTEQ   CONum   Contrato
                CARRIED [CONum]         ;si lo llevas
                PUTO    [Player]        ;se cae al suelo
#if OPICS
                 PROCESS DropPic
#endif
                MESSAGE BambuM+2        ;lo dice
                DONE

METER   _       AUTOP   [O2Num]         ; Put object in container
#if OPICS
                 PROCESS DropPic
#endif
                DONE

SACAR   PUA     NOUN2   FRUTA
                CARRIED FruEsp
                DESTROY FruEsp
#if OPICS
                PROCESS DropPic
#endif
                SETCO   Fruta
                PROCESS CreaGet
                SETCO   Espina
                PROCESS CreaGet
                DONE

SACAR   _       PROCESS MakeO2          ; Get data for object 2
                ZERO    O2Con           ; Not a container
                NEWTEXT
                NOTDONE

SACAR   _       ABSENT  [O2Num]         ; Or not here
                SYSMESS 26
                NEWTEXT
                DONE

#IF BIGMEM
 SACAR  _       NOUN2   CAJON
                ZERO    CajonF
                SETCO   Cajon
                PROCESS Closed
                DONE
#ENDIF

SACAR   TODO    DOALL   [O2Num]

SACAR   _       AUTOT   [O2Num]         ; Get object out of container
#if OPICS
                 PROCESS GetPic
#endif
                DONE

;SACAR   _       SETCO   [CONum]
;                SAME    COLoc   O2Num   ;si no se ha movido=>exceso de peso
;                CREATE  [CONum]         ;o de objs. Dijo que se cae al suelo
;                DONE                    ;y ah¡ es donde va a estar
;
; - Lighting things

;       -       -       -       -       -       -       -       -       -
;
; - The following actions can't be carried out in the dark. Other ones
; specific to each part must be excluded in their own table

#if DARK
 _       _       NOTZERO Dark
                 ABSENT  0             ; No lamp
                 SYSMESS 0
                 SYSMESS FSNL
                 DONE
#endif

COGER   LORO    AT      Barca
                SYSMESS  PM+7
                SYSMESS  LoroS+3
                SYSMESS FSNL
                DONE

COGER   GUSANO  PRESENT Papaya
                ISAT    Gusano  LIMBO
                CREATE  Gusano

COGER   ESTACA  AT      Foso
                ISAT    Estaca  LIMBO
                CREATE  Estaca

ARRANCAR PUA    SYNONYM COGER   PUA

ARRANCAR CA¥AS  SYNONYM COGER   CA¥A

ARRANCAR CA¥A   SYNONYM COGER   CA¥A

COGER   CA¥AS   AT      Selva1                  ;donde est n las ca¤as
                SYNONYM COGER CA¥A

COGER   CA¥A    AT      Selva1                  ;donde est n las ca¤as
                ISNOTAT Bambu   Selva1          ;no hay ca¤a en el suelo
                MESSAGE BambuM                  ;no puedes porque est n
                DONE                            ;firmeM sujetas al suelo

ARRANCAR LIANA  SYNONYM COGER   LIANA

COGER   LIANA   AT      Selva3
                ISAT    Liana   NOTCREATED      ;as¡ no dice que
                NOTDONE                         ;no est  a tu alcance

COGER   PUA     AT      Selva2
                ISNOTAT Espina  LIMBO           ;la he cogido ya
                ISNOTAT Espina  Selva2          ;y no est  en el suelo
                SYSMESS YaTengoS
                DONE

COGER   PUA     AT      Selva2                  ;desierto
                CREATE  Espina

#IF BIGMEM
 COGER  CAJON   AT      Barca
                MESSAGE CajonM          ; est  fijo en la barca
                DONE
#ENDIF

COGER   TODO    DOALL   HERE

#IF BIGMEM
 COGER  _       PRESENT Cajon           ;si el objeto est  en un contenedor
                NOTZERO CajonF          ;presente tambi‚n puede cogerse
                ISAT    [CONum] Cajon   ;no funciona con el todo porque
                PROCESS CreaGet         ;esta en otra loc
                DONE
#ENDIF

COGER  _        PRESENT Bambu           ;idem
                ISAT    [CONum] Bambu
                PROCESS CreaGet
                DONE

COGER   CUENTA  COPYFF  Player  Work1
                LET     Work3   ISBEAD  ;cuenta cuentas normales cogibles
                PROCESS ObjCt
                ISAT    MCuenta1 HERE   ;si la imix est  aqu¡
                ZERO    Work2           ;y no hay cuentas normales
                LET     Adject1 ImixW
                WHATO                   ;‚sta es la que quiero

COGER   CUENTA  NOTEQ   Adject1 ImixW   ;no se refiere a la imix
                SKIP    $NOIMIX

COGER   CUENTA  ISNOTAT MCuenta1 HERE   ;no esta aqu¡
                NOTDONE

COGER   CUENTA  NOTEQ   Noun2   RedW    ;sin usar la red
#IF BIGMEM
                NOTEQ   Noun2   PielW   ;ni la piel
#ENDIF
                MESSAGE CuentaM         ;se escapa
                DONE

#IF !BIGMEM
 COGER  CUENTA  SETCO   Red             ;solo puedes cogerla con la red
                NOTCARR Red
                SYSMESS 49              ;'no tienes la red'
                DONE
#ELSE
 COGER  CUENTA  NOUN2   RED
                SETCO   Red
                NOTCARR Red
                SYSMESS 49              ;'no tienes la red'
                DONE

 COGER  CUENTA  NOUN2   RED
                MESSAGE EE+1            ;'la cuenta se escapa por los bujeros'
                DONE

 COGER  CUENTA  NOUN2   PIEL            ;usar  la piel del jaguar
                SETCO   PielX           ;dira 'con ayuda de la piel'
                NOTCARR PielJ           ;sin especificar cual
                NOTCARR PielM
                NOTDONE
#ENDIF

COGER   CUENTA  MES     HachaM          ;con la ayuda de tal
                SYSMESS DeLaS           ;piel y red son femeninos
                MESSAGE CuentaM+1       ;pillas la cuenta
                SKIP    $AUTOGET

$NOIMIX
COGER   CUENTA  ISAT    MCuenta2 HERE   ;si la Oc est  aqu¡
                ZERO    Work2           ;y s¢lo est  la Oc
                LET     Adject1 OcW
                WHATO                   ;‚sta es la que quiero

COGER   CUENTA  ISAT    MCuenta2 HERE   ;si la Oc est  aqu¡
                EQ      Adject1 OcW     ;y queremos cogella
                NOTEQ   RistraCt 8      ;pero si no lleva la ristra entera
                MESSAGE CuentaM+6       ;'est  demasiado alta'
                DONE

COGER   CUENTA  ISAT    MCuenta2 HERE   ;si la Oc est  aqu¡
                ZERO    Work2           ;y s¢lo est  la Oc
                DESTROY MCuenta2
                MESSAGE CollarM         ;'se forma un collar'
                DESTROY Ristra
                CLEAR   RistraCt
#IF OPICS
                LET     Work6   Collar
                PROCESS OPatch
#ENDIF
                PLACE   Collar  CARRIED
                DONE

$AUTOGET
#IF BIGMEM
 COGER  _       NOTEQ   Noun1   CajonW
                AUTOG
 #if OPICS
                 PROCESS GetPic
 #endif
                DONE

 COGER  _       NOTDONE                 ;por el cajon

#ELSE

 COGER  _       AUTOG
                DONE

#ENDIF

CORTAR  CA¥AS   AT      Selva1                  ;donde est n las ca¤as
                SYNONYM CORTAR CA¥A

CORTAR  _       PROCESS Hachas          ;distingue hacha y hachuela
                ISNDONE                 ;no tienes ninguna de las 2
                NOTDONE

CORTAR  CA¥A    AT      Selva1          ;que es donde est n las ca¤as
                ISAT    Bambu   LIMBO
                MES     HachaM          ;'con el hacha/hachuela'
                SYSMESS [Work2]         ;respeta g‚nero hacha/hachuela
                SPACE
                CREATE  Bambu
                MESSAGE HachaM+1        ;'cortas la ca¤a'
                AUTOG
#IF OPICS
                PROCESS GetPic
#ENDIF
                DONE

CORTAR  CA¥A    AT      Selva1          ;que es donde est n las ca¤as
                SYSMESS YaTengoS
                DONE

CORTAR  LIANAS  AT      Selva3          ; que es donde est n las lianas
                ISAT    Liana   NOTCREATED ; hay que cortarlas mas de 1 vez
                MES     HachaM          ;'con el hacha/hachuela'
                SYSMESS [Work2]         ;respeta g‚nero hacha/hachuela
                SPACE
                CREATE  Liana
                MESSAGE HachaM+1        ;'cortas la liana'
                AUTOG
#IF OPICS
                PROCESS GetPic
#ENDIF
                DONE

CORTAR  LIANA   AT      Selva3          ;que es donde est n las lianas
                SYSMESS YaTengoS
                DONE

CORTAR  TRONCO  CARRIED Hachuela        ;la hachuela no vale
                ATGT    Selva1-1
                ATLT    Selva5+1
                NOTAT   Selva2          ;desierto sin troncos
                MESSAGE HachaM+4
                DONE

CORTAR  TRONCO  ATGT    Selva1-1        ;ni el hacha para otro tipo de troncos
                ATLT    Selva5+1
                NOTAT   Selva2          ;desierto sin troncos
                NOTAT   Selva4
                MESSAGE HachaM+4
                DONE

CORTAR  TRONCO  AT      Selva4
                EQ      TrunkCt 4       ;Ya ha cortado 4 troncos
                MESSAGE HachaM+5        ;'el hacha no tiene filo'
                DONE

CORTAR  TRONCO  AT      Selva4
                LET     Work1   Tronco1
                ADD     TrunkCt Work1   ;accede al tronco que le toca cortar
                MES     HachaM          ;'con el hacha/hachuela'
                SYSMESS [Work2]         ;respeta g‚nero hacha/hachuela
                SPACE
                CREATE  [Work1]
                MESSAGE HachaM+1        ;'cortas un tronco'
                PLUS    TrunkCt 1
                DONE

CORTAR  _       NOTDONE

; - Looking inside objects
;
MIRAR   _       PREP    EN
                SYNONYM EXAMINAR _

MIRAR   _       RESTART

EX      _       PREP    EN
                HASAT   CONTAINER
                PROCESS Inside
                NEWLINE
                DONE

; - trying to examine characters

EX      _       NOTAT   Barca
                SKIP    $NOBARCA2

EX      INDIO   EQ      BarcaLoc        MarT
                MESSAGE IndioM+2                ;'indio en el agua'
                DONE

EX      INDIO   SYSMESS PE
                DONE

EX      LORO    SYSMESS PE+1
                DONE

$NOPSI
;
; - examine something that is not an object
;
#IF BIGMEM
 EX     ASIENto MESSAGE EE+0
                DONE
#ENDIF

EX      MAR     SYSMESS ExMarS                  ;moja
                DONE

EX      MACHETE NOTEQ   BarcaLoc MarT
                MESSAGE EE+7
                DONE

EX      BARCA   MESSAGE EE+20
                DONE

EX      SUELO   SYNONYM EX      FONDO

EX      FONDO   MESSAGE EE+2
                ISAT    Papaya  LIMBO
                CREATE  Papaya
#IF BIGMEM
                MES     FindM
                MESSAGE FindM+1
#ELSE
                MESSAGE FindOM                  ;encuentras la papaya
#ENDIF

EX      FONDO   DONE

$NOBARCA2
EX      MAR     AT      AhogoI
                SYSMESS ExMarS                  ;moja
                DONE

EX      VASIJAS AT      Altar
                MESSAGE EE+26
                DONE

#IF !DRAW
 EX     IDOLO   AT      Derruid
                MESSAGE EE+27
                DONE
#ENDIF

EX      BLOQUe  AT      Derruid
                MESSAGE EE+8
                DONE

EX      BLOQUE  NOTZERO EnLabe
                NOTAT   Cenote
                MESSAGE EE+6            ;'moviles'
                DONE

EX      ALTAR   AT      Altar
                MESSAGE EE+9
                DONE

EX      ESCOMbr AT      Altar
                MESSAGE EE+22
                ISAT    Hachuela LIMBO
                CREATE  Hachuela                ;encuentras el hachuela
#IF BIGMEM
                MES     FindM
                MESSAGE FindM+2
#ELSE
                MESSAGE FindOM                  ;encuentras la papaya
#ENDIF

EX      ESCOMbr AT      Altar
                DONE

EX      ARBOL   AT      Selva1
                MESSAGE EE+11
                DONE

EX      FRUTAs  AT      Selva1
                ISNOTAT Fruta   CARRIED
                ISNOTAT FruEsp  CARRIED
                MESSAGE EE+12
                DONE

EX      SUELO   AT      Selva1
                MESSAGE EE+13
                ISAT    Fruta   LIMBO
                CREATE  Fruta
#IF BIGMEM
                MES     FindM
                MESSAGE FindM+3
#ELSE
                MESSAGE FindOM                  ;encuentras la papaya
#ENDIF

EX      SUELO   AT      Selva1
                DONE

EX      SUELO   AT      Selva4
                ZERO    HayFoso         ;no ha encontrado el foso
                MESSAGE EE+14
                DONE

EX      SUELO   AT      Selva4
                MESSAGE EE+15           ;hay foso
                DONE

EX      SUELO   AT      L10             ;sobresale un bloque del suelo
                ZERO    Tunel10         ;si el tunel est  cerrado
                MESSAGE EE+25
                DONE                    ;si no, est  hundido

EX      SUELO   NOTZERO EnLabe          ;en laberinto
                MESSAGE EE+16           ;de losas
                DONE

EX      COCOTer AT      Selva3
                SYNONYM EX      VEGETac

EX      VEGETac ATGT    Selva1-1
                ATLT    Selva5+1
                NOTAT   Foso
                RESTART

EX      VEGET   ATGT    L1-1
                ATLT    L7+1
                NOTAT   L3
                NOTAT   L4
                MESSAGE EE+23
                ISAT    Runa8   LIMBO
                CHANCE  50
                CREATE  Runa8
                MESSAGE RunaM+3         ;'rebuscando encuentras un sello'
                DONE

EX      VEGET   ATGT    L1-1
                ATLT    L7+1
                NOTAT   L3
                NOTAT   L4
                DONE

EX      CA¥A    AT      Selva1
                ABSENT  Bambu
                SYNONYM EX      CA¥AS

EX      CA¥AS   AT      Selva1
                MESSAGE EE+10
                DONE

EX      CACTUs  AT      Selva2
                MESSAGE EE+17
                DONE

EX      LIANA   AT      Selva3
                ABSENT  Liana
                MESSAGE EE+24
                DONE

EX      FOSO    ATGT    Selva4-1
                ATLT    Foso+1
                NOTZERO HayFoso                 ;ha encontrado el foso
                MESSAGE EE+18
                DONE

#IF BIGMEM
 EX     FOSO    ATGT    Selva4-1                ;si no has encontrado el foso
                ATLT    Foso+1                  ;no est  a tu alcance
                NOTDONE
#ENDIF

EX      ESTACA  ATGT    Selva4-1
                ATLT    Foso+1
                ISNOTAT Estaca  CARRIED
                NOTZERO HayFoso                 ;si ya ha encontrado el foso
                MESSAGE EE+19
                AT      Foso
                ISAT    Estaca  LIMBO
                MESSAGE EstacaM                 ;'ves una estaca suelta'

EX      ESTACA  ATGT    Selva4-1                ;pero no la crea
                ATLT    Foso+1                  ;hasta que la coja
                ISNOTAT Estaca  CARRIED
                NOTZERO HayFoso                 ;si ya ha encontrado el foso
                DONE

EX      JAGUAR  AT      Selva5                  ;el jaguar vivo no es un objeto
                ZERO    Jaguar                  ;pero si pierdes el tiempo
                DONE                            ;examin ndolo, te come

EX      MONO    AT      Selva3
                ZERO    Mono                    ;el mono vivo no es un objeto
                MESSAGE EE+21
                SET     MonoEx                  ;ya sabemos que es el Macacus
                DONE

EX      PUA     PRESENT FruEsp          ;si la tiene ensartada
                SETCO   FruEsp          ; tb puede examinarla (como ensartada)

EX      LOSA    AT      L3
                MESSAGE EE+3            ;'Esta suelta'
                DONE

#IF DRAW
 EX     TUNEL   NOTZERO EnLabe          ;en 8 bits dice que los hay altos y
                MESSAGE EE+5            ;bajos
                DONE
#ELSE
 EX     TUNEL   AT      Plaza   ;en 16 bits hay un mensaje por localidad
                MESSAGE EE+FstTunelEE+0
                DONE

 EX     TUNEL   AT      L1
                MESSAGE EE+FstTunelEE+1
                DONE

 EX     TUNEL   AT      L2
                MESSAGE EE+FstTunelEE+2
                DONE

 EX     TUNEL   AT      L3
                MESSAGE EE+FstTunelEE+3
                DONE

 EX     TUNEL   AT      L4
                MESSAGE EE+FstTunelEE+4
                DONE

 EX     TUNEL   AT      L5
                MESSAGE EE+FstTunelEE+5
                DONE

 EX     TUNEL   AT      L6
                MESSAGE EE+FstTunelEE+6
                DONE

 EX     TUNEL   AT      L7
                MESSAGE EE+FstTunelEE+7
                DONE

 EX     TUNEL   AT      L8
                MESSAGE EE+FstTunelEE+8
                DONE

 EX     TUNEL   AT      L9
                MESSAGE EE+FstTunelEE+9
                DONE

 EX     TUNEL   AT      L10
                MESSAGE EE+FstTunelEE+10
                DONE

 EX     TUNEL   AT      Cenote
                MESSAGE EE+FstTunelEE+11
                DONE
#ENDIF

EX      TUNEL   SYSMESS 26              ;'no est  a tu alcance'
                DONE

EX      PARED   NOTZERO EnLabe
                PROCESS ProBloques      ;lista bloques en pared
                DONE                    ;(copes with Plaza, L10 and cenote)

EX      CENOTE  AT      Cenote
                MESSAGE EE+4
                DONE

EX      CENOTE  AT      AhogoC
                RESTART

EX      CENOTE  SYSMESS 26
                DONE

EX      ACANT   ATGT    L7-1
                ATLT    L9+1
                MESSAGE EE+4
                DONE
#IF !DRAW
 EX     ACANT   AT      Plaza
                MESSAGE EE+4
                DONE
#ENDIF

EX      ACANT   SYSMESS 26
                DONE

EX      _       PROCESS Examine         ; If not a valid object drop thro
                ISNDONE
                SYSMESS GEx             ;msg general para examinas

; - Inventory, por Manolo!

I       _       NOTZERO Dark            ; a oscuras
#if DARK
                ABSENT  0S
#endif
                SYSMESS 0               ; 'no se ve nada.'
                NEWLINE
                DONE

I       _       ZERO    1               ; ning£n objeto 'carried'
                SYSMESS 10              ; 'no tienes nada'
                DONE


I       _       NOTZERO 1               ; tienes alg£n objeto 'carried'
                SYSMESS 9
                LISTAT  CARRIED
                NEWLINE
                DONE
;
;OJO: lo de decir debe estar aqu¡
;
DECIR   KUILL   AT      Barca           ;loro aqu¡ y s¢lo aqu¡
                PROCESS DiDaToma        ;por si es pedir o dar
                ISNDONE                 ;si no
                SYSMESS PM+5            ;'hablas con '
                SYSMESS PM+7            ;'el loro'
                SYSMESS FSNL
                DONE

DECIR   _       EQ      Noun1   255
                AT      Barca
                SYNONYM DECIR   INDIO

DECIR   INDIO   AT      Barca
                PROCESS DiDaToma        ;por si es pedir o dar
                ISNDONE                 ;si no
                SYSMESS PM+5            ;'hablas con '
                SYSMESS PM+6            ;'el indio'
                SYSMESS FSNL
                DONE

DECIR   _       EQ      Noun1   255
                SYSMESS 66              ;'dirigete a alguien para hablar'
                DONE

DAR     _       NOTAT   Barca
                SYSMESS 70              ; no est 
                DONE

DAR     _       EQ      Noun2   IndioW
                EQ      BarcaLoc MarT
                MES     IndioM+2        ;'el indio est  en el agua'
                NOTDONE                 ;para que a¤ada 'no puedes'

DAR     TODO    DOALL   CARRIED

DAR     _       NOTCARR [CONum]         ; You must have it
                SYSMESS 28              ; 'no lo tienes'
                DONE

DAR     GUSANO  NOUN2   KUILL
                SYSMESS PM+7            ;'Kuill'
                SYSMESS LoroS+1         ;' se come el gusano'
                SYSMESS FSNL
                DESTROY Gusano
#IF OPICS
                PROCESS DropPic
#ENDIF
                DONE

DAR     PAPAYA  NOUN2   KUILL
                SYSMESS PM+7            ;'Kuill'
                SYSMESS LoroS+2         ;' pasa de la papaya'
                SYSMESS FSNL
                CREATE  Papaya
#IF OPICS
                PROCESS DropPic
#ENDIF
                DONE

DAR     _       Noun2   KUILL
                SYSMESS PM+7            ;'Kuill'
                SYSMESS LoroS           ;' pasa de t¡'
                SYSMESS FSNL
                DONE

DAR     _       NOTEQ   Noun2   IndioW  ;no le puede dar nada a nadie m s
                NOTDONE

;DAR     _       EQ      BarcaLoc MarT
;arriba          MES     IndioM+2        ;'el indio est  en el agua'
;;               SPACE
;                NOTDONE                 ;para que a¤ada 'no puedes'

DAR     _       SYSMESS PM+6            ; 'el indio'
                SYSMESS 114             ; 'te dice "'
                LET     Work1   111     ; '@ no me interesa'

DAR     PAPEL   PLACE   Contrato INDIO  ;para pod‚rselo pedir aunque no lo d‚
#IF OPICS
                PROCESS DropPic
#ENDIF
                LET     Work1   117     ; 'gracias'
                NOTEQ   BarcaLoc Playa  ; en la playa lo coge y ya est 
                SYSMESS 117             ; 'gracias'
                MES     IndioM+5        ; 'ahora te vas al agua'
                SYSMESS ICSNL
                PROCESS Tetira          ; 'el indio te tira al agua'


DAR     CUERDA  PUTO    INDIO
#IF OPICS
                PROCESS DropPic
#ENDIF
                LET     Work1   117     ; 'gracias'

#IF BIGMEM
 ;por curarme en salud, nunca va a ser necesaria
 DAR     REMO   PUTO    INDIO           ;con perd¢n
 #IF OPICS
                PROCESS DropPic
 #ENDIF
                LET     Work1   117     ; 'gracias'
#ENDIF

DAR     _       SYSMESS [Work1]
                SYSMESS ICSNL
                DONE

PEDIR   _       NOTEQ   Noun2   IndioW  ;no le puede pedir nada a nadie m s
                NOTDONE

PEDIR   _       NOTAT   Barca           ;solo puedes pedirle al indio
                NOTDONE

PEDIR   _       EQ      BarcaLoc MarT
                MESSAGE IndioM+2        ;'indio en el agua'
                DONE

PEDIR _         NOTEQ   BarcaLoc MarT
                SYSMESS PM+6
                SYSMESS 114
                SYSMESS SeNiegaS        ;el indio dice que ni hablar
                SYSMESS ICSNL
                DONE

PEDIR   TODO    DOALL   INDIO

PEDIR   CUERDA  NOTEQ   BarcaLoc MarT
                NOTEQ   BarcaLoc Playa
                ISAT    Cuerda   INDIO
                WHATO
#IF BIGMEM
                LET     TeDio   4       ;mientras <>0 te dira 'de nada'
#ENDIF
                SYSMESS PM+6
                SYSMESS GivesS          ;el indio te da la cuerda
                PROCESS CreaGet
                DONE

PEDIR   REMO    ISAT    Remo    INDIO
                NOTEQ   BarcaLoc Playa
                SYSMESS PM+6
                SYSMESS 114
                MES     IndioM+9        ;el indio dice que ‚l necesita el remo
                SYSMESS ICSNL
                DONE

PEDIR MACHETE   NOTEQ   BarcaLoc MarT
                SYSMESS PM+6
                SYSMESS 114
                MES     IndioM+10       ;el indio dice que es suyo
                SYSMESS ICSNL
                DONE

PEDIR   _       NOTEQ   COLoc   INDIO   ;dice que no tiene lo que pides
                SYSMESS PM+6
                SYSMESS 114
                SYSMESS NoHaveS
                SYSMESS ICSNL
                DONE


; Catch any verbs to non existent PSI's - all must be dealt with in the
; relevent part or they won't be here, we still check it is a valid PSI
; in case they do things to the walls...

DECIR   _       GT      Noun1 PSINames-1
                LT      Noun1 PSINames+NumPSIs
                SYSMESS 70              ; They aren't here
                DONE

DAR     _       GT      Noun2 PSINames-1
                LT      Noun2 PSINames+NumPSIs
                SYSMESS 70              ; Obviously the PSI isn't here
                DONE

#IF BIGMEM
 GRACIAS _       DONE
#ENDIF
;________________________________________________________________________
/PRO Init ;Inicialization

_       _       WINDOW  2       ; Graphics area
                WINAT   1  0
                WINSIZE 14 127  ; The whole top band including objects
                WINDOW  3       ; Status line
                WINAT   0  0
                WINSIZE 1  127
                MODE    2       ; Sin "m s.."
#if OPICS
                 WINDOW  4       ; Object pictures in graphics area
 #if PCW
                  WINAT   1 64   ; With 90 columns that correspond to graphics
                  WINSIZE 16 127
 #else
                  WINAT   1 43   ; These are the 53 column ones
                  WINSIZE 13 127
 #endif
#endif
                PROCESS SetText ; Default at start of game is a text window

_       _       CLEAR   254     ; Clear flags etc

_       _       NOTEQ   254     GFlags  ; Preserve system data flags
                NOTEQ   254     ScMode
                CLEAR   [254]

_       _       PLUS    254     1
                LT      254     254
                SKIP    -2

_       _       RESET                     ; All objects to start position
                LET     Prompt  2         ; nada
                CLEAR   Time              ;50
;               LET     TIFlags IO_TMORE+IO_TAKEY+IO_RBUF
                LET     OFlags  OO_CLIST  ; objetos en una linea

_       _       LET     Strength 34
                LET     MaxCarr MAXOBJS
                LET     BarcaLoc MarI   ; locs. iniciales
                LET     Indio    Barca
                LET     Kuill    Barca
                LET     OldVerb  MirarW ;por si hace V o P nada m s empezar
                SET     AtaNum1         ;nada atado a la liana
                SET     AtaNum2
;inic. con extern en z80
#IF Z80
                EXTERN  RunaT   0
#ELSE
                LET     RunaT   L9      ;locs donde debes dejar las tabletas
                LET     RunaT+1 L2      ;para que se conviertan en cuentas
                LET     RunaT+2 L5
                LET     RunaT+3 L3
                LET     RunaT+4 L6
                LET     RunaT+5 L7
                LET     RunaT+6 L1
                LET     RunaT+7 L8              
                
                                                ;  N S E O
 _      _       LET     NBloqT    130   ;Plazoleta 2 0 0 2
                LET     NBloqT+1  69    ;L1        1 0 1 1
                LET     NBloqT+2  204   ;L2        3 0 3 0
                LET     NBloqT+3  84    ;L3        1 1 1 0
                LET     NBloqT+4  84    ;L4        1 1 1 0
                LET     NBloqT+5  40    ;L5        0 2 2 0
                LET     NBloqT+6  21    ;L6        0 1 1 1
                LET     NBloqT+7  34    ;L7        0 2 0 2
                LET     NBloqT+8  81    ;L8        1 1 0 1
                LET     NBloqT+9  81    ;L9        1 1 0 1
                LET     NBloqT+10 64    ;L10       1 0 0 0

 _      _       LET     BloqTT    TPlaza
                LET     BloqTT+1  TL1
                LET     BloqTT+2  TL2
                LET     BloqTT+3  TL3
                LET     BloqTT+4  TL4
                LET     BloqTT+5  TL5
                LET     BloqTT+6  TL6
                LET     BloqTT+7  TL7
                LET     BloqTT+8  TL8
                LET     BloqTT+9  TL9
                LET     BloqTT+10 TL10
 ; las tablas van en el orden n,s,e,o e izq,der,centro

 _      _       LET     TPlaza    0
                LET     TPlaza+1  1
                LET     TPlaza+2  1+128
                LET     TPlaza+3  0+128
 ;
                LET     TL1       0
                LET     TL1+1     0+128
                LET     TL1+2     1+128
 ;
                LET     TL2       4
                LET     TL2+1     3
                LET     TL2+2     2+128
                LET     TL2+3     4+128
                LET     TL2+4     2
                LET     TL2+5     3+128
 ;
                LET     TL3       2+128
                LET     TL3+1     3+128
                LET     TL3+2     2
 ;
                LET     TL4       4+128
                LET     TL4+1     3+128
                LET     TL4+2     3

 _      _       LET     TL5       6+128
                LET     TL5+1     5
                LET     TL5+2     6
                LET     TL5+3     5+128
 ;
                LET     TL6       5
                LET     TL6+1     5+128
                LET     TL6+2     6+128
 ;
                LET     TL7       7+128
                LET     TL7+1     8+128
                LET     TL7+2     7
                LET     TL7+3     8
 ;
                LET     TL8       8+128
                LET     TL8+1     7
                LET     TL8+2     7+128
 ;
                LET     TL9       8+128
                LET     TL9+1     9
                LET     TL9+2     8
 ;
                LET     TL10      10
#ENDIF

;________________________________________________________________________
/PRO Status ; Poner linea de status

;The number of turns must always increase. I.e. ensure Status is cleared after
;a load!

_       _       WINDOW  3
                PRINTAT 0 24
                HASNAT  GMODE
                TAB     44           ; All text modes are 80 column

_       _       SYSMESS 17
                DPRINT  Turns
#if DEBUG
                space
                print   Player
                space
                print   Cuelgade
                space
                print   Cuelga2
                space
                print   AtaNum1
                space
                print   AtaNum2
#endif
                WINDOW  1
                NOTDONE         ; Ain't done anything really

;________________________________________________________________________
;Now if the version has object pictures we include the code
#if OPICS
 #include TP
#endif
;________________________________________________________________________
/PRO Salidas    ; Rutina de salidas (3 Processes)
; Work1 - Almacena el verbo actual e ¡ndice para mensajes en rutina de salidas/psi
; Work2 - N£mero de salidas/personajes encontrado
; Work3 - Flag con la localidad actual o mensaje que tiene nombre de PSI
; Work4 - Flag de personaje

_       _       NOTZERO EnLabe
                MES     TunelM+1
                AT      Plaza
                SYSMESS SM+4            ; ' y '
                SYSMESS AlS             ; 'al '
                SYSMESS SM+7            ; 'Sur'

_       _       NOTZERO EnLabe
                AT      Cenote
                MES     TunelM+2        ;'y bajar al cenote'

_       _       NOTZERO EnLabe
                SYSMESS SM+2            ; '.'
                DONE

_       _       AT      Barca
                NOTEQ   BarcaLoc Playa
                MESSAGE BarcaM          ;chorrada sobre tirarse al agua
                DONE

_       _       CLEAR   Work2           ; cuantos mensajes
                LET     Work1   SM      ; 'no hay ninguna salida'
                LET     Verb    1       ; comienza por Norte
                PROCESS Salidas+1
                GT      Work2   1
                SYSMESS SM+4            ; ' y '

_       _       EQ      Work2   1
                SYSMESS SM+5            ; 'La £nica salida es'

_       _       SYSMESS [Work1]         ; salida final (o ninguna)
                SYSMESS SM+2            ; '.'
;
/PRO Salidas+1  ; Rutina salidas para cada movimiento

_       _       COPYFF  Player Work3    ; copia loc actual del jugador
                MOVE    Work3           ; intenta moverse y si puede
                PROCESS DoorChk         ; y no hay puerta cerrada o similar
                ISNDONE
                PROCESS Salidas+2       ; imprime salida

_       _       PLUS    Verb    1       ; > pr¢xima direcci¢n
                LT      Verb    13      ; > no se ha pasado a£n
                REDO                    ; repite el proceso
;
/PRO Salidas+2  ; Imprime la salida

_       _       EQ      Work2   1
                SYSMESS SM+1            ; 'Salidas posibles son'

_       _       GT      Work2   1       ; no la primera
                SYSMESS SM+3            ; ', '

_       _       NOTZERO Work2
                SYSMESS [Work1]         ; £ltimo mensaje en buffer

_       _       COPYFF  Verb    Work1   ; > calcula la direcci¢n
                PLUS    Work1   SM+6-1  ; del pr¢ximo mensaje
                PLUS    Work2   1       ; prepara el siguiente
;________________________________________________________________________
/PRO DoorChk    ;chequea puertas o similares
;Salida: DONE: hay puerta cerrada
;        NOTDONE: no hay puerta o est  abierta
;

BAJAR   _       AT      Barca           ;hasta que no atraque no puede salir
                LT      BarcaLoc Playa  ;
                DONE

BAJAR   _       AT      Selva4
                ZERO    HayFoso         ; no lo ha encontrado a£n
                DONE                    ; puede bajar

N       _       AT      Plaza           ;sale al abrir el cenote
                ZERO    Tunel10
                DONE

AR      _       AT      Plaza           ;sale al abrir el cenote
                ZERO    Tunel10
                DONE

O       _       AT      Plaza
                ZERO    Tunel0          ;cerrado
                DONE

E       _       AT      L1
                ZERO    Tunel0
                DONE

O       _       AT      L1
                ZERO    Tunel1
                DONE

E       _       AT      L2
                ZERO    Tunel1
                DONE

N       _       AT      L2
                ZERO    Tunel2
                DONE

S       _       AT      L3
                ZERO    Tunel2
                DONE

N       _       AT      L3
                ZERO    Tunel3
                DONE

S       _       AT      L4
                ZERO    Tunel3
                DONE

N       _       AT      L4
                ZERO    Tunel4
                DONE

S       _       AT      L5
                ZERO    Tunel4
                DONE

E       _       AT      L5
                ZERO    Tunel5
                DONE

O       _       AT      L6
                ZERO    Tunel5
                DONE

E       _       AT      L6
                ZERO    Tunel6
                DONE

O       _       AT      L7
                ZERO    Tunel6
                DONE

S       _       AT      L7
                ZERO    Tunel7
                DONE

N       _       AT      L8
                ZERO    Tunel7
                DONE

S       _       AT      L8
                ZERO    Tunel8
                DONE

N       _       AT      L9
                ZERO    Tunel8
                DONE

O       _       AT      L9
                ZERO    Tunel9
                DONE

E       _       AT      L10
                ZERO    Tunel9
                DONE

N       _       AT      L10
                ZERO    Tunel10
                DONE

#IF BIGMEM
 S      _       AT      Cenote          ;por curarme en salud
                ZERO    Tunel10         ;nunca estar  en cenote con l10 cerrado
                DONE
#ENDIF

;________________________________________________________________________
/PRO Examine    ; Examine objects

_       _       EQ      CONum   255
                NOTDONE                 ; It must be a valid object

EX      LIANA   AT      AhogoC          ;en cenote es como si estuviera presente
                SKIP    $PONPUNTO       ;porque dice que cuelga

_       _       ABSENT  [CONum]         ; and it must be present
                SYSMESS 26
                DONE

; Special description for objects
#IF !BIGMEM
 _      _       HASAT   NOEXAMIN        ;mensaje general para stupideces
                SYSMESS ExamS
                SKIP    $PONPUNTO
#ENDIF

EX      CUENTA  SYSMESS OD+Cuenta1      ;la misma desc para todas las cuentas
                SYSMESS FSNL
                DONE

EX      SELLO   MES     RunaM           ;'tiene un dibujo de'

$PONPUNTO
_       _       COPYFF  CONum Work1     ; Description
                PLUS    Work1 OD
                SYSMESS [Work1]
                HASNAT  NONSTOP         ;no hay que dar num. de componentes
                SYSMESS 4               ;.\s

; All containers list what is inside them, in addition to any desc

_       _       HASAT   CONTAINER
                PROCESS Inside

EX      PAPAYA  ISAT    Gusano LIMBO
                MES     GusanoM         ; dice que hay un gusano en la papaya
                                        ; mientras no lo cojas

EX      BALSA   COPYFF  BalsaCt Work1   ;num de troncos
                PLUS    Work1   NumM-1
                MES     [Work1]
                MES     BalsaM+4

EX      RISTRA  GT      RistraCt 1      ;plural
                SYSMESS PN              ;'n'

EX      RISTRA  SPACE
                LISTAT  RISTRA

_       _       NOTSAME CONum   AtaNum1
                NOTSAME CONum   AtaNum2
                SKIP    $NOATADO

_       _       PRESENT [CONum]
                MES     AtaM+4          ; 'tiene una liana atada'

$NOATADO
EX      LIANA   NOTEQ   AtaNum1 255
                SETCO   [AtaNum1]
                MES     AtaM+5          ; 'est  atada'
                SPACE
                SYSMESS AlredS          ; 'alrededor '
                SYSMESS AlredS+1        ; 'd'
                LET     Work1   DeLaS
                HASAT   MASCULINE       ;del o de la
                LET     Work1   U

EX      LIANA   NOTEQ   AtaNum2 255
                SYSMESS [Work1]
                SETCO   [AtaNum2]
                SYSMESS 47              ;' y '
                SYSMESS 129             ; 'd'
                LET     Work1   DeLaS
                HASAT   MASCULINE       ;del o de la
                LET     Work1   U

EX      LIANA   NOTEQ   AtaNum1 255
                SYSMESS [Work1]
                SYSMESS 4               ;.\s
#IF BIGMEM
 EX     LIANA   NOTZERO Cuelgade        ;cuelga de un tunel
                MES     AtaM+11         ;lo dice
                SYSMESS [Cuelga2]
                SYSMESS FS
#ENDIF

EX      CUERDA  NOTZERO Remoatado
                MES     AtaM+10         ;'remo atado a cuerda'

EX      REMO    NOTZERO Remoatado
                MES     AtaM+10         ;'remo atado a cuerda'

_       _       NEWLINE

;________________________________________________________________________
/PRO Closed     ; Print "@ esta cerrada/o"

_       _       SYSMESS 104             ; @ esta cerrad
                PROCESS AdjSex
                SYSMESS FSNL
;________________________________________________________________________
/PRO Open       ; Print "x@ esta abierta/o"

_       _       SYSMESS 119             ; Ya esta abiert
                PROCESS AdjSex
                SYSMESS FSNL
;________________________________________________________________________
/PRO AdjSex     ; Prints 'o' or 'a' according to object sex
_       _       HASAT   MASCULINE
                SYSMESS MO              ; Masculine O
                DONE

_       _       SYSMESS FA              ; Female A
;________________________________________________________________________
#IF !DRAW
 /PRO DoLoad     ; This takes care of loading with poss another mode

 _       _      HASAT   GMODE           ; In graphics now
                LOAD    0
                HASNAT  GMODE           ; & Not now
                PLUS    GFlags  128     ; Make it
                DONE

 LOAD   _       HASNAT  GMODE     
                LOAD    0
                HASAT   GMODE
                MINUS   GFlags  128
#ENDIF
;_______________________________________________________________________
/PRO Slide ; Makes a new picture appear (this one as well)
#IF DRAW
 _       _       DISPLAY [DarkF]
#ELSE
 _      _       LET     Work1   13
                LET     Work2   1

 $SLIDELOOP
 _      _       WINAT   [Work1] GRFCOL  ; 0 si PCW, 1 en caso contrario
                WINSIZE [Work2] GRFWDTH
                DISPLAY [DarkF]
                NOTEQ   Work1   1
                MINUS   Work1   1
                PLUS    Work2   1
                SKIP    $SLIDELOOP

 _      _       PICTURE 3              ; Put line below (must be buffered)
                DISPLAY 0
#ENDIF
;________________________________________________________________________
/PRO Graphic    ; Changes to graphic mode if we were in text
_       _       ZERO    HayPic          ; Text before
                PROCESS CAnykey         ; So gonna change, check for pending
                WINDOW  1
                CLS                     ; Clear whole area
                WINAT   15 0            ; Una linea mas bajo en 16bit
#if PCW
                 WINSIZE 16 127          ; All screen on PCW minus status
#else
                 WINSIZE 10 127          ; Siempre el mismo altura
#endif
;________________________________________________________________________
/PRO CAnykey    ; Waits for anykey if we had a pending
_       _       NOTZERO APending
                ANYKEY
                CLEAR   APending
;________________________________________________________________________
/PRO SetText    ; Ensures that text mode is selected (Load & Desc)

_       _       WINDOW  2               ; Always clear graphics in case
                CLS                     ; there were any before
                WINDOW  3               ; Clear status (in case after load)
                CLS
                WINDOW  1
                WINAT   2  0            ; Una linea mas abajo
#if PCW
                 WINSIZE 29 127          ; Leave status line free
#else
                 WINSIZE 23 127
#endif
                CLS
                CLEAR   HayPic          ; Text is always the wrong piccy
;________________________________________________________________________
/PRO MakeO2     ; This makes the O2 Data contain the data for NOUN2.
;The current object data is reset afterwards

_       _       COPYFF  Noun1 Work1     ; Save current object <
                COPYFF  Adject1 Work2   ;                     <
                COPYFF  Noun2 Noun1     ;                     <
                COPYFF  Adject2 Adject1 ;                     < Whato2
                WHATO                   ; Set object2 data    <
                COPYFF  Work1 Noun1     ;                     <
                COPYFF  Work2 Adject1   ;                     <
                COPYFF  CONum O2Num
                COPYFF  COLoc O2Loc
                COPYFF  COCon O2Con
                COPYFF  COAtt O2Att
                COPYFF  COAtt+1 O2Att+1
                WHATO                   ; Reset NOUN1 as current object
                NOTDONE                 ; Was a setup only

;________________________________________________________________________
/PRO Inside     ; Describes containers and their contents

#IF BIGMEM
 _      CAJON   ZERO    CajonF           ; Closed
                SYSMESS 98
                PROCESS AdjSex
                SYSMESS FS
                DONE

 _      CAJON   EQ      COWei   PCajon  ; Empty
                SYSMESS 78
                PROCESS AdjSex
                SYSMESS FS
                DONE
#ENDIF

_       CA¥A    EQ      COWei PBambu    ; Empty
                MES     BambuM+3        ;examina la ca¤a sin m s
                DONE

_       _       SYSMESS  79

_       _       LISTAT  [CONum]
;________________________________________________________________________
;
; ts.sce   /\  /\
;
;---------------------------
;________________________________________________________________________
/PRO Hachas     ;distingue entre hacha y hachuela. Pone la que llevemos en
;el current object. Si no tenemos ninguna da NOTDONE
;saca en work2 el msg de sistema U o DelaS seg£n sea hacha o hachuela

_       _       SETCO   Hacha
                LET     Work2   U
                NOTCARR Hacha
                SETCO   Hachuela
                LET     Work2   DeLaS
                NOTCARR Hachuela
                NOTDONE
;________________________________________________________________________
/PRO ObjMov     ;traslada objetos
;Entradas:Work1: Loc. origen
;         Work2: Loc. destino
;         Work3: atributo (255=no atributo)
;         Work4: <>0 actualiza gr ficos inventario si origen o destino=CARRIED
;

_       _       CLEAR   Work6                   ;object pointer

$LOOP
_       _       SETCO   [Work6]
                SAME    Work1   COLoc
                PUTO    [Work2]                 ;se lo lleva siempre
                NOTEQ   Work3   255
                HASNAT  [Work3]                 ;y si no vale
                PUTO    [Work1]                 ;lo vuelve a traer

_       _       NOTEQ   Work6   LASTOBJ
                PLUS    Work6   1
                SKIP    $LOOP

#IF OPICS
 _      _       NOTEQ   Work1   CARRIED         ;si no afecta al inventario
                NOTEQ   Work2   CARRIED
                DONE                            ;no lo actualizamos

 _      _       NOTZERO HayPic                  ;We are not in text mode
                NOTZERO Work4
                WINDOW  4                       ;clear  area
                CLS
                CLEAR   HayPic                  ;fool PicInv
                PROCESS PicInv
                WINDOW  1
#ENDIF
;________________________________________________________________________
/PRO ObjCt      ;cuenta objetos
; Entradas: Work1: localidad
;           Work3: atributo (255=no atributo)
; Salida:   Work2: num. de objetos


_       _       CLEAR   Work6
                CLEAR   Work2

$LOOP
_       _       SETCO   [Work6]
                SAME    Work1   COLoc
                PLUS    Work2   1               ;lo cuento
                NOTEQ   Work3   255             ;ah, que no
                HASNAT  [Work3]                 ;val¡a
                MINUS   Work2   1               ;pues lo borro

_       _       NOTEQ   Work6   LASTOBJ
                PLUS    Work6   1
                SKIP    $LOOP

;________________________________________________________________________
/PRO CreaGet    ; cuando hay que coger mas de una cosa en la misma entrada
;Salida: NOTDONE si pudo hacerlo

_       _       CREATE  [CONum]
                GET     [CONum]
#IF OPICS
                PROCESS GetPic
#ENDIF
                NOTDONE
;________________________________________________________________________
/PRO Tied        ;comprobaciones al moverse con la liana atada
; Entradas: Player
;           Work1=loc a la que se dirige
;           Work2=AtaNum1 o AtaNum2
;

_       _       COPYFF  Work2   Work3           ;work3 apunta a AtaLoc1/2
                PLUS    Work3   1
                CARRIED Liana
                NOTEQ   [Work2] 255
                NOTSAME [Work3] Work1
                NOTEQ   [Work3] CARRIED
                SKIP    $DOIT

_       _       DONE

$DOIT
_       _       COPYFF  [Work2] Work4           ;=setco [AtaNumX]
                SETCO   [Work4]
                LT      Verb    15              ; s¢lo si nos movemos
                ABSENT  [Work4]                 ;no est  en la loc del objeto
                NOTSAME [Work3] Work1           ;y se va a otra distinta
                MESSAGE AtaM+6                  ;'la liana no da + de s¡'
                RESTART                         ;para que no se mueva

_       _       HASNAT  BIG
                SKIP    $CABE

_       _       ATGT    Plaza
;               ATLT    Cenote                  ;$$!!!
                MESSAGE AtaM+8                  ;'se atasca'
                DONE

O       _       AT      Plaza
                MESSAGE AtaM+8                  ;'se atasca'
                DONE

S       _       AT      Cenote
                MESSAGE AtaM+8                  ;'se atasca'
                DONE

$CABE
_       _       COPYBF  [Work3] Work1           ;mueve el objeto
                PUTO    [Work1]
                MESSAGE AtaM+7                  ;'me lo llevo'

;________________________________________________________________________
/PRO RBits  ;Interpreta los bits en COAtt como 4 n£meros del 0 al 4 que deja en
;            FBN, FBS, FBE y FBO.
;OJO: Supone que est n a 0
_       _       HASAT   15
                LET     FBN     2

_       _       HASAT   14
                PLUS    FBN     1

_       _       HASAT   13
                LET     FBS     2

_       _       HASAT   12
                PLUS    FBS     1

_       _       HASAT   11
                LET     FBE     2

_       _       HASAT   10
                PLUS    FBE     1

_       _       HASAT   9
                LET     FBO     2

_       _       HASAT   8
                PLUS    FBO     1

;________________________________________________________________________

/PRO ProBloques
#IF DRAW
 _      _       NOUN2   E
                AT      Plaza
                MESSAGE BloqM+6         ;'no hay bloques ah¡'
                DONE
#ENDIF

_       _       GT      Noun2   4       ;no es n,s,o,e
                SYSMESS CualS           ;'qu‚ pared?'
                DONE

_       _       ATGT    L10-1           ;en estas dos
                ATLT    Cenote+1        ;no hay bloques en ninguna pared
                MESSAGE BloqM+6         ;'no hay bloques ah¡'
                DONE

_       _       LET     Work1   FBN-1
                ADD     Noun2   Work1   ;flag de esa pared
                ZERO    [Work1]         ;no bloques=>no pared
                MESSAGE BloqM           ;'No hay pared ah¡'
                DONE

EX      _       LET     Work2   SM+5
                ADD     Noun2   Work2   ;nombre de esa pared
                LET     Work3   NumM-1
                ADD     [Work1] Work3   ;mensaje del num. de bloque
                MES     BloqM+1         ;'De la pared '
                SYSMESS [Work2]
                MES     BloqM+2         ;' sobresale'
                GT      [Work1] 1       ;m s de un bloque
                SYSMESS PN              ;'n'

EX      _       SPACE
                MES     [Work3]         ; tantos
                MES     BloqM+3         ;' bloque'
                GT      [Work1] 1       ;m s de un bloque
                SYSMESS PS              ;'s'

EX      _       SPACE
                MESSAGE BloqM+4         ;de piedra
#IF BIGMEM
                NOUN2   N               ;si ha aparecido la escalera en la plaza
                AT      Plaza
                NOTZERO Tunel10
                MESSAGE PlazaM+2        ;lo dice tambien
#ENDIF

MOVER   _       EQ      Adject2 255
                COPYFF  Adject1 Adject2

MOVER   _       COPYFF  Player  Work2
                MINUS   Work2   Plaza
                PLUS    Work2   BloqTT  
                COPYFF  [Work2] Work2   ;work2 apunta primer flag tabla bloques
                NOTEQ   Noun2   1       ;no es norte
                ADD     FBN     Work2
                NOTEQ   Noun2   2       ;no es sur
                ADD     FBS     Work2
                NOTEQ   Noun2   3       ;no es este
                ADD     FBE     Work2

MOVER   _       EQ      [Work1] 2
                NOTEQ   Adject2 IzqW
                PLUS    Work2   1
                NOTEQ   Adject2 DerW
                SYSMESS CualS           ;'cual?'
                DONE

MOVER   _       EQ      [Work1] 3
                NOTEQ   Adject2 IzqW
                PLUS    Work2   1
                NOTEQ   Adject2 DerW
                PLUS    Work2   1
                NOTEQ   Adject2 CenW
                SYSMESS CualS           ;'cual?'
                DONE

;ahora work2 apunta al flag que nos interesa

MOVER   _       COPYFF  [Work2] Work3
                GT      Work3   100
                MINUS   Work3   128

MOVER   _       PLUS    Work3   Tunel0
                MESSAGE BloqM+5         ;'Oyes mecanismos'
                SET     [Work3]         ;abre
                GT      [Work2] 100     ;pero si era cerrar
                CLEAR   [Work3]         ;cierra

;________________________________________________________________________
/PRO Tetira ;el indio te lo quita todo y te tira al agua

_       _       MES     IndioM+7        ; 'te tira al agua'
                NOTZERO NOCarr          ; lleva algo
                MES     IndioM+8        ; 'te quita todo'
                SYSMESS FSKB            ; '.\k\b'
                LET     Work1   CARRIED
                LET     Work2   Barca
                SET     Work3           ; nos lo quita todo
#IF OPICS
                SET     Work4
#ENDIF
                PROCESS ObjMov
                GOTO    AhogoI
                RESTART

_       _       SYSMESS FSKB            ; '.\k\b'
                GOTO    AhogoI
                RESTART
;________________________________________________________________________
/PRO DiDaToma ;convierte DECIR PSI "DAME/TOMA OBJ"
; en PEDIR/DAR OBJ PSI
; sale con NOTDONE si no se pudo convertir
; tambien controla otras chorradas que se puedan decir al indio

_       _       COPYFF  Noun1   Work1   ;para que p.ej. decir indio "dame..."
                PARSE   1               ;sea "pedir ... indio"

#IF BIGMEM
 QUIERe _       ADVERB  QUE
                EQ      Work1   IndioW  ;le hablas al indio
                SYSMESS PM+6
                SYSMESS 114             ;te dice
                MES     IndioM+13       ;algo referente al contrato
                SYSMESS ICSNL
                DONE
#ENDIF

_       _       COPYFF  Work1   Noun2
                WHATO

DAME    _       SYNONYM PEDIR   _
                DONE                 ;as¡ continuar  en response

TOMA    _       SYNONYM DAR     _
                DONE                 ;ditto

#IF BIGMEM
 GRACIAS _      NOTZERO TeDio           ;el indio te ha dado algo
                CLEAR   TeDio
                EQ      Work1   IndioW  ;y le hablas a ‚l
                SYSMESS PM+6
                SYSMESS 114
                SYSMESS 135             ;te dice 'de nada'
                SYSMESS ICSNL
                DONE

 GRACIAS _      ZERO    TeDio           ;pero si no te dio nada
                EQ      Work1   IndioW  ;y le hablas a ‚l
                SYSMESS PM+6
                SYSMESS 74              ;te mira extra¤ado
                DONE

 COME   _       HASAT   EDIBLE
                SYNONYM COGER   _

 COGE   _       NOUN2   INDIO
                EQ      BarcaLoc MarT
                MESSAGE IndioM+2        ;'indio en el agua'
                DONE

 COGE   TODO    NOUN2   INDIO
                DOALL   HERE

 COGE   CONTRAT NOUN2   INDIO
                SYNONYM DAR     CONTRATO
                DONE

 COGE   CUERDA  NOUN2   INDIO
                PRESENT Cuerda
                PLACE   Cuerda  INDIO
 #if OPICS
                PROCESS DropPic
 #endif
                SYSMESS PM+6            ; 'el indio'
                SYSMESS ICogeS          ; 'te mira con cinismo y'
                SYSMESS 114             ; 'te dice "'
                SYSMESS ICogeS+1        ; 'lo que usted diga'
                SYSMESS ICSNL
                DONE

 COGE   _       NOUN2   INDIO
                WHATO
                PRESENT [CONum]
                SYSMESS PM+6            ; 'el indio'
                SYSMESS 114             ; 'te dice "'
                SYSMESS 111             ; '@ no me interesa'
                SYSMESS ICSNL
                DONE

 DEJA   _       NOUN2   INDIO
                EQ      BarcaLoc MarT
                MESSAGE IndioM+2        ;'indio en el agua'
                DONE

 DEJA   CUERDA  NOUN2   INDIO
                NOTEQ   BarcaLoc Playa
                ISAT    Cuerda   INDIO
                WHATO
                SYSMESS PM+6
                SYSMESS 114             ; 'te dice "'
                SYSMESS ICogeS+1        ; 'lo que usted diga'
                SYSMESS ICSNL
                CREATE  Cuerda
                DONE

 DEJA   REMO    NOUN2   INDIO
                ISAT    Remo    INDIO
                SYSMESS PM+6
                SYSMESS 114
                SYSMESS SeNiegaS
                SYSMESS ICSNL
                DONE

 DEJA MACHETE   NOUN2   INDIO
                SYSMESS PM+6
                SYSMESS 114
                MES     IndioM+10       ;el indio dice que es suyo
                SYSMESS ICSNL
                DONE

 DEJA   _       NOUN2   INDIO
                NOTEQ   COLoc   INDIO   ;dice que no tiene lo que pides
                SYSMESS PM+6
                SYSMESS 114
                SYSMESS NoHaveS
                SYSMESS ICSNL
                DONE

 DEJA _         NOUN2   INDIO
                NOTEQ   BarcaLoc MarT
                SYSMESS PM+6
                SYSMESS 114
                SYSMESS SeNiegaS        ;el indio dice que ni hablar
                SYSMESS ICSNL
                DONE

#ENDIF

_       _       NOTDONE
