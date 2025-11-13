/*
 * ds18_routines.inc
 *
 *  Created: 03.07.2019 09:18:46
 *   Author: janos
 */ 
temp_load:
lds temph,s18_msb
lds templ,s18_lsb			;temp2=>decimal int, temp=>signed int
ldi yh,high(temp_str)
ldi yl,low(temp_str)
sbrs temph,7
jmp temp_p
	ldi temp,'-'
st y+,temp
	com temph
	neg templ
	sts s18_lsb,templ
	jmp m_disp
temp_p:
	ldi temp,'+'
st y+,temp
m_disp:
push yh
push yl
	clr fbin2
	clr fbin1
	mov fbin0,temph
call bin3bcd
pop yl
pop yh
mov temp,tbcd0
swap temp
andi temp,0x0f
ori temp,0x30
st y+,temp
mov temp,tbcd0
andi temp,0x0f
ori temp,0x30
st y+,temp
	ldi temp,'.'
st y+,temp
push yh
push yl
lds temp,s18_lsb
mov b0,temp
clr b1
clr b2
clr b3
clr b4
clr b5
clr b6
clr b7
ldi a0,low(625)
ldi a1,high(625)
clr a2
clr a3
clr a4
clr a5
clr a6
clr a7
rcall __muldi3
	mov fbin0,a0
	mov fbin1,a1
	clr fbin2
	call bin3bcd
pop yl
pop yh
mov temp,tbcd1
swap temp
andi temp,0x0f
ori temp,0x30
st y+,temp
ldi temp,'~'
st y+,temp
ret

read_temp:
;***************************S1 TEMP READING
	call	ONEWIRE_RST
	ldi		temph,0xCC		;skip rom command
	call	ONEWIRE_WR	
	ldi		temph,0xBE		;read scratchpad command
	call	ONEWIRE_WR
	call	ONEWIRE_RD		;Get data
	mov		temp5,temph
	call	ONEWIRE_RD		;Get data
	mov		temp6,temph
	push	temp5
	swap	temp5
	andi	temp5,0x0f
	swap	temp6
	andi	temp6,0xf0
	or		temp5,temp6
	sts s18_msb,temp5
	pop		temp5
	andi	temp5,0x0f
	sts s18_lsb,temp5
start_tconv:
	call	ONEWIRE_RST
	ldi		temph,0xCC		;skip rom command
	call	ONEWIRE_WR
	ldi		temph,0x44		;Convert temperature command
	call	ONEWIRE_WR
ret

;/******************************************
;/	1WIRE reset and presence pulse
;/******************************************
ONEWIRE_RST:
		cbi   portb,one_wire
		sbi   ddrb,one_wire
		call delay_480_us
		sbi   portb,one_wire
		cbi   ddrb,one_wire
clr temp
owloop: ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
inc temp
cpi temp,255
breq timeout		
		sbic  pinb,one_wire
		jmp owloop
		call delay_480_us
timeout:
ret
;/************************************
;/	write data 1 byte
;/	output:	Onewire_Data
;/************************************
ONEWIRE_WR: 
		ldi   templ,0
OWWriteLoop: 
		ror   temph
		call OWWriteBit 
		inc   templ
		cpi   templ,8
		brne  OWWriteLoop
ret
OWWriteBit:
		brcc  OWWriteZero
		cbi   portb,one_wire
		sbi   ddrb, one_wire
		call delay_1_us
		sbi   portb,one_wire
		cbi   ddrb, one_wire
		call delay_60_us
ret
OWWriteZero: 
		cbi   portb,one_wire
		sbi   ddrb, one_wire
		call delay_60_us
		sbi   portb,one_wire
		cbi   ddrb, one_wire
		call delay_1_us
ret
;/*********************************************
;/	Read data 1 byte
;/	input:	Onewire_Data
;/*********************************************
ONEWIRE_RD: 
		ldi   templ,0
OWReadLoop:
		call OWReadBit
		ror   temph
		inc   templ
		cpi   templ,8
		brne  OWReadLoop
ret
OWReadBit: 
		cbi   portb,one_wire
		sbi   ddrb, one_wire
		call delay_1_us
		sbi   portb,one_wire
		cbi   ddrb, one_wire
		call delay_10_us
	clc
		sbic  pinb,one_wire
	sec
		call delay_60_us
ret
delay_480_us:
push r17
push r18
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 9 600 cycles
; 480us at 20 MHz
    ldi  r17, 13
    ldi  r18, 119
L480us: dec  r18
    brne L480us
    dec  r17
    brne L480us
pop r18
pop r17
ret
delay_240_us:
push r17
push r18
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 4 800 cycles
; 240us at 20 MHz
    ldi  r17, 7
    ldi  r18, 59
L240us: dec  r18
    brne L240us
    dec  r17
    brne L240us
pop r18
pop r17
ret
delay_30_us:
push r17
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 600 cycles
; 30us at 20 MHz
    ldi  r17, 200
L30us: dec  r17
    brne L30us
pop r17
ret
delay_10_us:
push r17
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 200 cycles
; 10us at 20 MHz
    ldi  r17, 66
L10us: dec  r17
    brne L10us
    nop
pop r17
ret
delay_1_us:
push r17
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 20 cycles
; 1us at 20 MHz
    ldi  r17, 6
L1us: dec  r17
    brne L1us
    nop
pop r17
ret
delay_60_us:
; delaying 957 cycles:
push r17
push r18
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 1 200 cycles
; 60us at 20 MHz
    ldi  r17, 2
    ldi  r18, 142
L60us: dec  r18
    brne L60us
    dec  r17
    brne L60us
    nop
pop r18
pop r17
ret
