; -------------------------------
; DETOURNEMENT DU RESET (SCREEN2)
; -------------------------------


 move.l $44e,a1              ; a0=adresse de l'ecran
 move.w #7999,d0
loop:
 clr.l (a1)+                 ; Efface l'ecran
 dbra d0,loop

 movem.l palette(pc),d0-d7   ; Change la palette
 movem.l d0-d7,$ffff8240

 move.l $44e,a1
 adda.l #$1d88,a1
 move.l picture(pc),a0
 move.w #105,d0

ligne_suivante:
 move.w #21,d1
mot_suivant:
 move.l (a0)+,(a1)+
 dbra d1,mot_suivant
 adda.l #72,a0
 adda.l #72,a1
 dbra d0,ligne_suivante

 bchg #1,$ffff820a           ; Mode 50 Hz

boucle:            
 bra.s boucle

palette:
 dc.w $000,$777,$770,$543,$444,$322,$533,$431
 dc.w $000,$700,$444,$267,$135,$247,$050,$173
picture:
 dc.l 1

 end

 