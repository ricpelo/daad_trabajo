;
; TEMPLOS 1 - Vocabulary
;
; 11-10-90
; ========
;________________________________________________________________________
/VOC
;______________________________________________________________________________
;
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
ARRIBa  9       noun
SUBIR   9       verb
SUBE    9       verb
SUBO    9       verb
BAJAR   10      verb
BAJA    10      verb
BAJO    10      verb
ABAJO   10      noun
ENTRAr  11      verb    ; also for ENTRA
ENTRO   11      verb
SALIR   12      verb
SALGO   12      verb
SAL     12      verb
;
;*N.B.* COMO is not a synonym here, it is made thus in Response
;as we need it for COMO TE LLAMAS, which should have an accent but
;nobody will use it
;Note that LLAMAr/s will be the verb and COMO the noun!
COMO    39      noun
C¢MO    39      noun
;
;       -Verbs-
;
;Start at 40 so as not to conflict with conversion nouns
;
; - Verbs needed in both parts
;
ESPERar 40      verb    ;-Wait
;
;41
;
SEGUIr  42      verb
SIGO    42      verb
;
QUIERo  43      verb    ;- I want PSI (boat in part2, drink in 1)
NECESit 43      verb    ;- I need
DAME    43      verb    ;- Give Me PSI, t£
DEME    43      verb    ;  & usted
;
;44-45
;
DIBUJos 46      verb    ; &a - select text/graphics mode
GRAFIco 46      verb
;
TEXTO   47      verb
;
DAR     48      verb    ;-Give
DOY     48      verb
TOMA    48      verb    ;PSI
TOME    48      verb    ;PSI    de usted
REGALa  48      verb
;
BESAR   49      verb    ;-Kiss
BESA    49      verb
BESO    49      verb    ;
;
SALIDas 50      verb
X       50      verb    ;poner en instrucciones &a
;
CUANTO  51     verb    ;-how much (to buy boat, or bill)
;
;52-55
;
#if BIGTEXT
 AD     56      verb
#else
 #if PART2
  AD     56      verb
 #endif
#endif
;
MOVER   57      verb    ;-Move (Something)
MUEVE   57      verb    ; PSI
MUEVO   57      verb
ARRAS   57      verb    ;-to drag (the barrel)
EMPUJar 57      verb    ;-Push - the drunk, mono
APARTar 57      verb    ;-Apart - the leaves
;
;58-63
;
PONER   64      verb    ;-Put
PONTE   64      verb
PONGO   64      verb
PON     64      verb
PONLO   64      verb
PONLA   64      verb
PONME   64      verb
;
NADAR   65      verb    ;-Swim
NADAL   65      verb    ; EX COSTA?? &a
NADO    65      verb
NADA    65      verb    ; the word nothing
;
;66-67
;
GRACI   68      verb    ;-Thanks
;
ADIOS   69      verb    ;-Goodbye (can use a system message)
;
;70
;
HOLA    71      verb    ;-Hello
BUENOs  71      verb
BUENAs  71      verb
;
;72
;
TENGO   73      verb    ;- I have (no money)
;
;74
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
M       78      verb    ;-Look
MIRAR   78      verb
MIRA    78      verb
MIRO    78      verb
R       78      verb
REDEScr 78      verb
DESCRi  78      verb
;
FIN     79      verb    ;-Quit
ACABAr  79      verb
ACABO   79      verb
RENDIr  79      verb
RINDO   79      verb
RINDEt  79      verb
TERMIn  79      verb
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
;81
;
QUITAr  82      verb    ;-Remove (clothing)
QUITO   82      verb
;
METER   83      verb    ;-Insert
METE    83      verb
METEL   83      verb
METO    83      verb
INTROdu 83      verb
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
;87-88
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
;92-96
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
;
;98-109
;
COMER   110     verb    ;-you'll like this one
COME    110     verb
COMEL   110     verb
;
BUSCAR  111     verb
BUSCO   111     verb
REGIST  111     verb
;
; - Verbs which are needed only in one part
;
APRET   205     verb    ;-to press (la piedra bajo el musgo)
PRESI   205     verb    ;-to compress
HUNDI   205     verb    ;-push down
;
ARRANca 207     verb    ;-yank (the moss)
;
;       -Nouns-
;
;       <40 means can be used as verbs
;
SI      19      noun
VALE    19      verb
;
#define PSINames 20
COZUMelano 20   noun
CIPACtli   20   noun
INDIO      20   noun
KUILL      21   noun
LORO       21   noun
MONO       21   noun
MACACus    22   noun
CHIMPance  22   noun
;
;       <50 means a proper noun ie not an 'IT'
;
TODO    49      noun
;
; Object Nouns
;
REMO     50     noun
CUERDA   51     noun
HILOS    52     noun
HILO     52     noun
SEDAL    53     noun
PAPAYA   54     noun
GUSANO   55     noun
PEZ      56     noun
CONTRATO 57     noun
PAPEL    57     noun
RED      58     noun
CUENTA   59     noun
COLLAR   60     noun
HACHUELA 61     noun
HACHA    62     noun
FRUTA    63     noun
ESPINA   64     noun
PUA      64     noun
PALO     65     noun
LIANAS   66     noun
ESTACA   67     noun
JARRON   68     noun
JARR¢N   68     noun
;
;-Adjetivos
;
LARGA    100    adjective
LARGO    100    adjective
CORTA    101    adjective
CORTO    101    adjective
AZUL     102    adjective
ROJA     103    adjective
ROJO     103    adjective
VIOLEta  104    adjective
VERDE    105    adjective
CELESte  106    adjective
AMARIllo 107    adjective
BLANCo   108    adjective
NEGRO    109    adjective
;
RAM     76      noun
;
;       -Conjugations-
;
Y       2       conjugation
LUEGO   2       conjugation
;
;       -Prepositions-
;
DENTRO  2       preposition
EN      2       preposition
