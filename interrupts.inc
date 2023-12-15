/*
 * interrupts.inc
 *
 *  Created: 1/1/2023 4:48:48 PM
 *   Author: Janos
 */ 

USART1_TXC:
push temp
push temp2
push xl
push xh
in temp2,sreg
sbi portb,led_
lds xl,blutx1_ptr
lds xh,blutx1_ptr+1
ld temp,x+
cpi temp,0xff
breq tx1_eof
sts UDR1,temp
sts blutx1_ptr,xl
sts blutx1_ptr+1,xh
tx1_eof:
out sreg,temp2
pop xh
pop xl
pop temp2
pop temp
reti

tim2_ovf:
push temp
push temp2
push temp3
push temp4
push xh
push xl
in temp2,sreg
push temp2
;-----------------------------
	ldi temp,tim2_val
	sts tcnt2,temp   ;1.9968 mSec interupt
;-----------------------------
lds temp3,dsp_speedreg
lds temp4,flag_reg0
	cbi portb,led_
;-----------------------------
lds temp,ln1_speedc
dec temp
tst temp
brne ovf2_exitl1
sbr temp3,0x80	;ln1_speedf scroll speed
lds temp,ln1_speed
ovf2_exitl1:
sts ln1_speedc,temp
;-----------------------------------------
lds temp,ln2_speedc
dec temp
tst temp
brne ovf2_exitl2
sbr temp3,0x40	;ln2_speedf scroll speed
lds temp,ln2_speed
ovf2_exitl2:
sts ln2_speedc,temp
;-----------------------------------------
lds temp,ln3_speedc
dec temp
tst temp
brne ovf2_exitl3
sbr temp3,0x20	;ln3_speedf scroll speed
lds temp,ln3_speed
ovf2_exitl3:
sts ln3_speedc,temp
;-----------------------------------------
lds temp,ln4_speedc
dec temp
tst temp
brne ovf2_exitl4
sbr temp3,0x10	;ln4_speedf scroll speed
lds temp,ln4_speed
ovf2_exitl4:
sts ln4_speedc,temp
;--------------------------------------
lds temp,ln5_speedc
dec temp
tst temp
brne ovf2_exitl5
sbr temp3,0x08	;ln5_speedf scroll speed
lds temp,ln5_speed
ovf2_exitl5:
sts ln5_speedc,temp
;---------------------------------------
lds temp,ln6_speedc
dec temp
tst temp
brne ovf2_exitl6
sbr temp3,0x04	;ln6_speedf scroll speed
lds temp,ln6_speed
ovf2_exitl6:
sts ln6_speedc,temp
;--------------------------------
lds xl,cnt1
lds xh,cnt1+1
ldi temp,low(450)
ldi temp2,high(450)
adiw x,1
cp xl,temp
cpc xh,temp2
brne ovf2_exit3
sbr temp4,0x04	;refresh temp
clr xl
clr xh
ovf2_exit3:
sts cnt1,xl
sts cnt1+1,xh
;---------------------
lds temp,cnt2
inc temp
cpi temp,45
brne ovf2_exit4
sbr temp4,0x08 ;ln effect speed
clr temp
ovf2_exit4:
sts cnt2,temp
;----------------------------
lds xl,cnt0
lds xh,cnt0+1
ldi temp,low(500)
ldi temp2,high(500)
adiw x,1
cp xl,temp
cpc xh,temp2
brne ovf2_exit
;****************clock_update
clr xl
clr xh
sbr temp4,0x01	;refresh clock & screen
lds temp,_sec
inc temp
sts _sec,temp
cpi temp,60
brne ovf2_exit
clr temp
sts _sec,temp
sbr temp4,0x40	;min inc
lds temp,_min
inc temp
sts _min,temp
cpi temp,60
brlo ovf2_exit
clr temp
sts _min,temp
lds temp,_hour
inc temp
sts _hour,temp
cpi temp,24
brlo ovf2_exit
clr temp
sts _hour,temp
ovf2_exit:
sts cnt0,xl
sts cnt0+1,xh
;-------------------------------
sts flag_reg0,temp4
sts dsp_speedreg,temp3
;-------------------------------
pop temp2
out sreg,temp2
pop xl
pop xh
pop temp4
pop temp3
pop temp2
pop temp
reti

USART0_RXC:
push temp
push temp2
push templ
push temph
push zl
push zh
in temp2,sreg
sbi portb,led_
lds temp,udr0
sts gps_udr,temp
cpi temp,'$'
brne rx_midle
ldi temp,low(gps_buf)
sts gps_ptrl,temp
ldi temp,high(gps_buf)
sts gps_ptrh,temp
rx_midle:
lds zl,gps_ptrl
lds zh,gps_ptrh
lds temp,gps_udr
st z+,temp
sts gps_ptrl,zl
sts gps_ptrh,zh
cpi temp,'*'
brne rx_exit
ldi temp,low(gps_buf)
sts gps_ptrl,temp
ldi temp,high(gps_buf)
sts gps_ptrh,temp
lds temp,flag_reg2
sbr temp,0x40
sts flag_reg2,temp
rx_exit:
out sreg,temp2
pop zh
pop zl
pop temph
pop templ
pop temp2
pop temp
reti

USART1_RXC:
push temp
push temp2
push zh
push zl
in temp2,sreg
sbi portb,led_
lds temp,udr1
lds zl,blu_bufp
lds zh,blu_bufp+1
st z+,temp
sts blu_bufp,zl
sts blu_bufp+1,zh
cpi temp,0x0a
brne rx1_exit
ldi temp,low(blu_buf)
sts blu_bufp,temp
ldi temp,high(blu_buf)
sts blu_bufp+1,temp
lds temp,flag_reg2
sbr temp,0x08
sts flag_reg2,temp
rx1_exit:
out sreg,temp2
pop zl
pop zh
pop temp2
pop temp
reti

