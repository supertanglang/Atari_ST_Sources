 moveq #1,d0
 bsr music
 lea music_vbl(pc),a0
 move.l a0,$4d2
 rts

music_vbl:
 movem.l d0-d7/a0-a6,-(sp)
 bsr music_exec
 lea $ffff8800,a0
 moveq #10,d0
 move.b d0,(a0)
 move.b (a0),d0
 cmpi.b #$e,d0
 blt.s led_off

led_on:
 move.b #14,(a0)
 move.b (a0),d0
 andi.b #$f9,d0
 move.b d0,2(a0)
 bra.s fin

led_off:
 move.b #14,(a0)
 move.b (a0),d0
 ori.b #6,d0
 move.b d0,2(a0)

fin:
 movem.l (sp)+,d0-d7/a0-a6
 rts

music:
 ibytes "MADMAX.DAT"

music_exec: equ music+8

 end
 