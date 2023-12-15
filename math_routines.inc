/*
 * math_routines.inc
 *
 *  Created: 02.07.2019 09:27:12
 *   Author: janos
 */ 

; r25..r18 % r17..r10 = r25..r18
;.global __umoddi3
__umoddi3:
        set
        jmp    __udivdi3_1

; r25..r18 / r17..r10 = r25..r18
;.global __udivdi3
__udivdi3:
        clt
__udivdi3_1:
        push    t0
        push    t1
        push    t2
        push    t3
        push    t4
        push    t5
		push	r15
	clr	t0
	clr	t1
        movw    t2, t0
        movw    t4, t0
        movw    t6, t0
	ldi	cnt, 64
__udivdi3_2:
	lsl	a0
	rol	a1
	rol	a2
	rol	a3
	rol	a4
	rol	a5
	rol	a6
	rol	a7
	rol	t0
	rol	t1
	rol	t2
	rol	t3
	rol	t4
	rol	t5
	rol	t6
	rol	t7
	cp	t0, b0
	cpc	t1, b1
	cpc	t2, b2
	cpc	t3, b3
	cpc	t4, b4
	cpc	t5, b5
	cpc	t6, b6
	cpc	t7, b7
	brcs	__udivdi3_3
	sub	t0, b0
	sbc	t1, b1
	sbc	t2, b2
	sbc	t3, b3
	sbc	t4, b4
	sbc	t5, b5
	sbc	t6, b6
	sbc	t7, b7
	inc	a0
__udivdi3_3:
	dec	cnt
	brne	__udivdi3_2
        brtc    restore_regs
        movw    a0, t0
        movw    a2, t2
        movw    a4, t4
        movw    a6, t6
restore_regs:
	pop r15
	pop	t5
    pop t4
	pop	t3
	pop	t2
	pop	t1
	pop	t0
	ret

; r25..r18 * r17..r10 = r25..r18
;.global __muldi3
__muldi3:
        push    t0
        push    t1
        push    t2
        push    t3
        push    t4
        push    t5
		push	r15
	clr	t0
	clr	t1
        movw    t2, t0
        movw    t4, t0
	movw	t6, t0
	ldi	cnt, 65
        jmp    __muldi3_3
__muldi3_1:
	brcc	__muldi3_2
	add	t0, b0
	adc	t1, b1
	adc	t2, b2
	adc	t3, b3
	adc	t4, b4
	adc	t5, b5
	adc	t6, b6
	adc	t7, b7
__muldi3_2:
	ror	t7
	ror	t6
	ror	t5
	ror	t4
	ror	t3
	ror	t2
	ror	t1
	ror	t0
__muldi3_3:
	ror	a7
	ror	a6
	ror	a5
	ror	a4
	ror	a3
	ror	a2
	ror	a1
	ror	a0
	dec	cnt
	brne	__muldi3_1
        jmp    restore_regs




									;***************************************************************************
                                    ;*
                                    ;* BCD3bin == BCD to 24-Bit Binary Conversion
                                    ;*
                                    ;* fBCD0:fBCD1:fBCD2:fBCD3  >>>  tbin0:tbin1:tbin2
                                    ;*	     dec			hex
                                    ;*	 r16r17r18r19	    >>>      r20r21r22
                                    ;*
                                    ;***************************************************************************                                 
                                    BCD3bin:										
											;mov	r16,r20 	;for compatibility with Math32
                                    		;mov	r17,r21 	;
                                    		;mov	r18,r22 	;
                                    		;mov	r19,r23 	;
											push r15
                                    BCD3bin16:	ldi	tbin0,0xca		;digit-to-digit presetting
                                    		ldi	tbin1,0x1b		;-1111110=0xef0bba
                                    		ldi	tbin2,0xff		;0xff1bca=0xef0bba-0xefeff0
                                    		sbrc	fBCD3,4 		; delete decimal correction
                                    		subi	fBCD3,6 		; if NUMBER<10000000 always
                                    bcdbin_106:	subi	tbin0,byte1(-1000*1000) ;addit tbin,10^6
                                    		sbci	tbin1,byte2(-1000*1000) ;
                                    		sbci	tbin2,byte3(-1000*1000) ;
                                    		subi	fBCD3,0x01		;
                                    		brcc	bcdbin_106		;
                                    bcdbin_105:	subi	tbin0,byte1(-100*1000)	;addit tbin,10^5
                                    		sbci	tbin1,byte2(-100*1000)	;
                                    		sbci	tbin2,byte3(-100*1000)	;
                                    		subi	fBCD2,0x10		;
                                    		brcc	bcdbin_105		;
                                    bcdbin_104:	subi	tbin0,byte1(-10*1000)	;addit tbin,10^4
                                    		sbci	tbin1,byte2(-10*1000)	;
                                    		sbci	tbin2,byte3(-10*1000)	;
                                    		subi	fBCD2,0x01		;
                                    		brhc	bcdbin_104		;
                                    bcdbin_103:	subi	tbin0,byte1(-1000)	;addit tbin,10^3
                                    		sbci	tbin1,byte2(-1000)	;
                                    		sbci	tbin2,byte3(-1000)	;
                                    		subi	fBCD1,0x10		;
                                    		brcc	bcdbin_103		;
                                    bcdbin_102:	subi	tbin0,byte1(-100)	;addit tbin,10^2
                                    		sbci	tbin1,byte2(-100)	;
                                    		sbci	tbin2,byte3(-100)	;
                                    		subi	fBCD1,0x01		;
                                    		brhc	bcdbin_102		;
                                    bcdbin_101:	subi	tbin0,byte1(-10)	;addit tbin,10^1
                                    		sbci	tbin1,byte2(-10)	;
                                    		sbci	tbin2,byte3(-10)	;
                                    		subi	fBCD0,0x10		;
                                    		brcc	bcdbin_101		;addit tbin,0xefeff0+LSD
                                    		add	tbin0,fBCD0		; addend of tbin1 & tbin2 is
                                    		adc	tbin1,fBCD1		; arbitrarily chosen const
                                    		adc	tbin2,fBCD2		; (pre take off from tbin)
                                    		pop r15
											ret
									;***************************************************************************
                                    ;*
                                    ;* Bin3BCD == 24-bit Binary to BCD conversion
                                    ;*
                                    ;* fbin0:fbin1:fbin2  >>>  tBCD0:tBCD1:tBCD2:tBCD3
                                    ;*	  hex			     dec
                                    ;*     r16r17r18      >>>	r20r21r22r23
                                    ;*
                                    ;***************************************************************************                                    
                                    Bin3BCD:	
											;mov	r16,r20 	;for compatibility with Math32
                                    		;mov	r17,r21 	;
                                    		;mov	r18,r22 	;
											push r15
                                    Bin3BCD16:	ldi	tBCD3,0xfa		;initialize digits 7 and 6
                                    binbcd_107:	subi	tBCD3,-0x10		;
                                    		subi	fbin0,byte1(10000*1000) ;subit fbin,10^7
                                    		sbci	fbin1,byte2(10000*1000) ;
                                    		sbci	fbin2,byte3(10000*1000) ;
                                    		brcc	binbcd_107		;
                                    binbcd_106:	dec	tBCD3			;
                                    		subi	fbin0,byte1(-10000*100) ;addit fbin,10^6
                                    		sbci	fbin1,byte2(-10000*100) ;
                                    		sbci	fbin2,byte3(-10000*100) ;
                                    		brcs	binbcd_106		;
                                    		ldi	tBCD2,0xfa		;initialize digits 5 and 4
                                    binbcd_105:	subi	tBCD2,-0x10		;
                                    		subi	fbin0,byte1(10000*10)	;subit fbin,10^5
                                    		sbci	fbin1,byte2(10000*10)	;
                                    		sbci	fbin2,byte3(10000*10)	;
                                    		brcc	binbcd_105		;
                                    binbcd_104:	dec	tBCD2			;
                                    		subi	fbin0,byte1(-10000)	;addit fbin,10^4
                                    		sbci	fbin1,byte2(-10000)	;
                                    		sbci	fbin2,byte3(-10000)	;
                                    		brcs	binbcd_104		;
                                    		ldi	tBCD1,0xfa		;initialize digits 3 and 2
                                    binbcd_103:	subi	tBCD1,-0x10		;
                                    		subi	fbin0,byte1(1000)	;subiw fbin,10^3
                                    		sbci	fbin1,byte2(1000)	;
                                    		brcc	binbcd_103		;
                                    binbcd_102:	dec	tBCD1			;
                                    		subi	fbin0,byte1(-100)	;addiw fbin,10^2
                                    		sbci	fbin1,byte2(-100)	;
                                    		brcs	binbcd_102		;
                                    		ldi	tBCD0,0xfa		;initialize digits 1 and 0
                                    binbcd_101:	subi	tBCD0,-0x10		;
                                    		subi	fbin0,10		;subi fbin,10^1
                                    		brcc	binbcd_101		;
                                    		add	tBCD0,fbin0		;LSD
											pop r15
                                    		ret
