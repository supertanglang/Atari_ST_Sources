;*******************************************************************************
;	Bitmap view Copyright (c) 1995 by	Christophe BOYANIQUE
;													http://www.raceme.org
;													tof@raceme.org
;*******************************************************************************
;	This program is free software; you can redistribute it and/or modify it
;	under the terms of the GNU General Public License as published by the Free
;	Software Foundation; either version 2 of the License, or any later version.
;	This program is distributed in the hope that it will be useful, but WITHOUT
;	ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;	FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
;	more details.
;	You should have received a copy of the GNU General Public License along
;	with this program; if not, write to the Free Software Foundation, Inc.,
;	59 Temple Place - Suite 330, Boston, MA 02111, USA.
;******************************************************************************

EXPORT	_cookie		;	Cookie-Jar
EXPORT	_cookieJar	;	Adresse du Cookie-Jar
EXPORT	_getBoot		;	Lecteur de Boot
EXPORT	_vTOS			;	Version du TOS
EXPORT	_AKP			;	Langage du TOS
EXPORT	_LONG			;	LPEEK
EXPORT	_CARD			;	DPEEK
EXPORT	_BYTE			;	PEEK


;******************************************************************************
;
;	long _cookie(long)
;	Retourne la valeur d'un Cookie ou 0 si celui-ci n'existe pas
;
;******************************************************************************
_cookie:
	movem.l	a0-a6/d1-d7,-(sp)
	move.l	d0,d6					;	d6: Cookie recherch�
	pea		_Scookie
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	move.l	long,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_Scookie:
	move.l	$5A0,a6				;	a6: pointeur sur Cookie
_tst_cook:
	cmp.l		#0,(a6)				;	Cookie NULL: Fin du Jar
	bne.s		_ok_cook
	move.l	#0,long				;	long: valeur du Cookie ou 0
	bra.s		_end_cook
_ok_cook:	
	cmp.l		(a6),d6
	bne.s		_notyet_cook
	move.l	4(a6),long
	bra.s		_end_cook
_notyet_cook:
	lea		8(a6),a6
	bra.s		_tst_cook
_end_cook:	
	rts
;******************************************************************************
;******************************************************************************


;******************************************************************************
;
;	long _cookieJar()
;	Retourne l'adresse du Cookie-Jar
;
;******************************************************************************
_cookieJar:
	movem.l	a0-a6/d1-d7,-(sp)
	pea		_ScookieJar
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	move.l	long,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_ScookieJar:
	move.l	$5A0,a6				;	a6: pointeur sur Cookie
	move.l	a6,long
	rts
;******************************************************************************
;******************************************************************************


;******************************************************************************
;
;	long _getBoot()
;	Retourne le lecteur de Boot
;
;******************************************************************************
_getBoot:
	movem.l	a0-a6/d1-d7,-(sp)
	pea		_SgetBoot
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	move.w	word,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_SgetBoot:
	move.w	$446,a6				;	a6: pointeur sur le lecteur de Boot
	move.w	a6,word
	rts
;******************************************************************************
;******************************************************************************


;******************************************************************************
;
;	int _vTOS()
;	Retourne le numero de version du TOS
;
;******************************************************************************
_vTOS:
	movem.l	a0-a6/d1-d7,-(sp)
	pea		_Stos
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	move.w	word,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_Stos:
	move.l	#$4F2,a6
	move.l	(a6),a6
	move.w	2(a6),word
	rts
;******************************************************************************
;******************************************************************************


;******************************************************************************
;
;	int _AKP()
;	Retourne le language utilis�
;
;******************************************************************************
_AKP:
	movem.l	a0-a6/d1-d7,-(sp)
	pea		_Sakp
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	lsr.w		#1,word
	move.w	word,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_Sakp:
	move.l	#$4F2,a6
	move.l	(a6),a6
	move.w	$1c(a6),word
	rts
;******************************************************************************
;******************************************************************************


;******************************************************************************
;
;	long _LONG(long)
;
;******************************************************************************
_LONG:
	movem.l	a0-a6/d1-d7,-(sp)
	move.l	d0,d6
	pea		_Slong
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	move.l	long,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_Slong:
	move.l	d6,a6
	move.l	(a6),long
	rts
;******************************************************************************
;******************************************************************************

;******************************************************************************
;
;	long _CARD(long)
;
;******************************************************************************
_CARD:
	movem.l	a0-a6/d1-d7,-(sp)
	move.l	d0,d6
	pea		_Scard
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	move.w	word,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_Scard:
	move.l	d6,a6
	move.w	(a6),word
	rts
;******************************************************************************
;******************************************************************************


;******************************************************************************
;
;	long _BYTE(long)
;
;******************************************************************************
_BYTE:
	movem.l	a0-a6/d1-d7,-(sp)
	move.l	d0,d6
	pea		_Sbyte
	move.w	#$26,-(sp)
	trap		#14					;	Supexec !!
	addq.l	#6,sp
	move.b	byte,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts
_Sbyte:
	move.l	d6,a6
	move.b	(a6),byte
	rts
;******************************************************************************
;******************************************************************************


long:
	dc.l		1
word:
	dc.w		1
byte:
	dc.b		1
