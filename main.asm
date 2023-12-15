;
; dot_matrix1.asm
;
; Created: 18-Dec-22 10:49:34
; Author : janos
;
.include "m1284def.inc" ; 20 Mhz crystal osc. 
.include "reg_def.inc"
.dseg
;.org sram_start

flag_reg0:	.byte 1
flag_reg1:	.byte 1
flag_reg2:	.byte 1
flag_reg3:	.byte 1
flag_reg4:	.byte 1
cnt0:		.byte 2
cnt1:		.byte 2
cnt2:		.byte 1
cnt3:		.byte 1
cnt4:		.byte 1
cnt5:		.byte 1
prg00_cnt:   .byte 1
lnef_cnt:	.byte 1
_sec:		.byte 1
sec_bcd:	.byte 2
_min:		.byte 1
min_bcd:	.byte 2
_hour:		.byte 1
hour_bcd:	.byte 2
day_bcd:	.byte 2
month_bcd:	.byte 2
year_bcd:	.byte 2
temp_sec:		.byte 1
temp_min:		.byte 1
temp_hour:		.byte 1
temp_day:		.byte 2
temp_month:		.byte 2
temp_year:		.byte 2
sum:			.byte 1
gps_char:		.byte 1
gps_buf:		.byte 80
gps_ptrl:		.byte 1
gps_ptrh:		.byte 1
gps_udr:		.byte 1

s18_lsb:		.byte 1
s18_msb:		.byte 1
temp_str:		.byte 8

blu_bufp:		.byte 2
blu_udr:		.byte 1
blu_temp:		.byte 1
blu_buf:		.byte 202
blutx1_buf:		.byte 200
blutx1_ptr:		.byte 2
dsp_i:			.byte 1
dsp_s8reg:		.byte 1
dsp_s8regr:		.byte 1
dsp_t8reg:		.byte 1
dsp_st16reg0:	.byte 1
dsp_st16reg1:	.byte 1
dsp_st16reg2:	.byte 1
dsp_datereg:	.byte 1
dsp_tempreg:	.byte 1
dsp_clkreg:		.byte 1
dsp_speedreg:	.byte 1
dsp_16reg:		.byte 1
dsp_8reg:		.byte 1
dsp_effreg:		.byte 1
dsp_invreg:		.byte 1


data_64byte:	.byte 64
ln16x32_ptr:	.byte 2

data_32byte:	.byte 32
lnu_ptr:		.byte 2
lnm_ptr:		.byte 2
lnd_ptr:		.byte 2

data_8byte:		.byte 8
ln_str:			.byte 16
ln_dstr:		.byte 128
ln_dstr16:		.byte 256
ln_char:		.byte 1

max7291_adr:	.byte 1
max7291_data:	.byte 1

;ln1_textp:		.byte 2
ln1_ptr:		.byte 2
ln1_cnt :		.byte 2
ln1_speed:		.byte 1
ln1_speedc:		.byte 1

;ln2_textp:		.byte 2
ln2_ptr:		.byte 2
ln2_cnt :		.byte 2
ln2_speed:		.byte 1
ln2_speedc:		.byte 1

;ln3_textp:		.byte 2
ln3_ptr:		.byte 2
ln3_cnt :		.byte 2
ln3_speed:		.byte 1
ln3_speedc:		.byte 1

;ln4_textp:		.byte 2
ln4_ptr:		.byte 2
ln4_cnt :		.byte 2
ln4_speed:		.byte 1
ln4_speedc:		.byte 1

;ln5_textp:		.byte 2
ln5_ptr:		.byte 2
ln5_cnt :		.byte 2
ln5_speed:		.byte 1
ln5_speedc:		.byte 1

;ln6_textp:		.byte 2
ln6_ptr:		.byte 2
ln6_cnt :		.byte 2
ln6_speed:		.byte 1
ln6_speedc:		.byte 1

ln1_text:		.byte 1024
ln1_textch:		.byte 200
ln1_textrch:	.byte 200
ln2_text:		.byte 1024
ln2_textch:		.byte 200
ln2_textrch:	.byte 200
ln3_text:		.byte 1024
ln3_textch:		.byte 200
ln3_textrch:	.byte 200
ln4_text:		.byte 1024
ln4_textch:		.byte 200
ln4_textrch:	.byte 200
ln5_text:		.byte 1024
ln5_textch:		.byte 200
ln5_textrch:	.byte 200
ln6_text:		.byte 1024
ln6_textch:		.byte 200
ln6_textrch:	.byte 200

.MACRO delayms20 
push temp
	ldi temp,@0
delay_loopms:
	call wait_20ms
	dec temp
	tst temp
brne delay_loopms
pop temp
.ENDMACRO

.MACRO delay 
push temp
	ldi temp,@0
delay_loops:
	call wait_1000ms
	dec temp
	tst temp
brne delay_loops
pop temp
.ENDMACRO

.cseg
.org 0x0000 					
jmp RESET 
;jmp INT0 ; IRQ0  
;jmp INT1 ; IRQ1  
;jmp INT2 ; IRQ2 
;jmp PCINT0 ; PCINT0 
;jmp PCINT1 ; PCINT1 
;jmp PCINT2 ; PCINT2  
;jmp PCINT3 ; PCINT3 
;jmp WDT ; Watchdog Timeout 
;jmp TIM2_COMPA ; Timer2 CompareA 
;jmp TIM2_COMPB ; Timer2 CompareB  
.org OVF2addr
jmp TIM2_OVF ; Timer2 Overflow  
;jmp TIM1_CAPT ; Timer1 Capture 
;jmp TIM1_COMPA ; Timer1 CompareA 
;jmp TIM1_COMPB ; Timer1 CompareB 
;jmp TIM1_OVF ; Timer1 Overflow 
;.org 0x0020
;jmp TIM0_COMPA ; Timer0 CompareA 
;.org 0x0022
;jmp TIM0_COMPB ; Timer0 CompareB  
;.org 0x0024
;jmp TIM0_OVF ; Timer0 Overflow  
;jmp SPI_STC ; SPI Transfer Complete 
.org URXC0addr
jmp USART0_RXC ; USART0 RX Complete 
;jmp USART0_UDRE ; USART0,UDR Empty 
;.org 0x002A 
;jmp USART0_TXC ; USART0 TX Complete 
;jmp ANA_COMP ; Analog Comparator  
;jmp ADC ; ADC Conversion Complete  
;jmp EE_RDY ; EEPROM Ready 
;jmp TWI ; two-wire Serial 
;jmp SPM_RDY ; SPM Ready  
.org URXC1addr
jmp USART1_RXC ; USART1 RX Complete  
;jmp USART1_UDRE ; USART1,UDR Empty 
.org UTXC1addr
jmp USART1_TXC ; USART1 TX Complete  
;jmp TIM3_CAPT ; Timer3 Capture(1)  
;jmp TIM3_COMPA ; Timer3 Compare(1) 
;jmp TIM3_COMPB ; Timer3 CompareB(1)
;jmp TIM3_OVF ; Timer3 Overflow(1) 
;********************* mcu stack init
reset:
	ldi 	temp,low(ramend)
	out 	spl,temp
	ldi 	temp,high(ramend)
	out 	sph,temp
;*********************
call wdt_off
call clr_sram
;********************* mcu port init
ldi temp,0b11111111
out ddra,temp
ldi temp,0b00000000
out porta,temp

ldi temp,0b11111110
out ddrb,temp
ldi temp,0b00000000
out portb,temp

ldi temp,0b11111010
out ddrd,temp
ldi temp,0b00000000
out portd,temp

ldi temp,0b11111111
out ddrc,temp
ldi temp,0b00000000
out portc,temp 
;********************* mcu init
/*
ldi temp,0b00000011
out tccr0a,temp
ldi temp,0b00000101 ;clk/1024 presc
out tccr0b,temp
ldi temp,0b00000011
sts timsk0,temp

ldi temp,0xfb
out ocr0a,temp
ldi temp,tim0_val
out tcnt0,temp
*/
ldi temp,0b00000000
sts tccr2a,temp
ldi temp,0b00000111 ;clk/1024 presc
sts tccr2b,temp
ldi temp,0b00000001
sts timsk2,temp
ldi temp,tim2_val
sts tcnt2,temp

ldi temp,0			;set uart 1 BLUETOOTH
sts ubrr1h,temp
ldi temp,0x0a		;set baud rate to 115200 bps
sts ubrr1l,temp
ldi temp,0b11011000
sts ucsr1b,temp
ldi temp,0b00000110
sts ucsr1c,temp

ldi temp,0			;set uart 0 GPS
sts ubrr0h,temp
ldi temp,0x81		;set baud rate to 9600 bps
sts ubrr0l,temp
ldi temp,0b10010000
sts ucsr0b,temp
ldi temp,0b00000110
sts ucsr0c,temp

;********************vcc rise delay sec
delayms20 25
call dsp_init
call dsp_clr
delay 5
;********************
sei
;********************
ldi xh,high(table_dspi)
ldi xl,low(table_dspi)
call eeprom_read
sts dsp_i,temp
call dsp_seti
ldi temp,25
sts _sec,temp
ldi temp,00
sts _min,temp
ldi temp,13
sts _hour,temp
ldi temp,'1'
sts day_bcd,temp
ldi temp,'3'
sts day_bcd+1,temp
ldi temp,'1'
sts month_bcd,temp
ldi temp,'2'
sts month_bcd+1,temp
ldi temp,'8'
sts year_bcd,temp
ldi temp,'0'
sts year_bcd+1,temp

call read_temp
call temp_load
call logo_print
delay 3
ldi temp6,8
logo_l:
call logo_printi
delayms20 1
call logo_print
delayms20 3
dec temp6
tst temp6
brne logo_l
call logo_printi
delay 3
call dsp_clr
call read_temp
call temp_load

ldi temp,low(blu_buf)
sts blu_bufp,temp
ldi temp,high(blu_buf)
sts blu_bufp+1,temp

ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_read
sts dsp_s8reg,temp
adiw x,1
call eeprom_read
sts dsp_s8regr,temp
adiw x,1
call eeprom_read
sts dsp_t8reg,temp
adiw x,1
call eeprom_read
sts dsp_st16reg0,temp
adiw x,1
call eeprom_read
sts dsp_st16reg1,temp
adiw x,1
call eeprom_read
sts dsp_st16reg2,temp
adiw x,1
call eeprom_read
sts dsp_datereg,temp
adiw x,1
call eeprom_read
sts dsp_tempreg,temp
adiw x,1
call eeprom_read
sts dsp_clkreg,temp
adiw x,1
call eeprom_read
sts dsp_effreg,temp
adiw x,1
call eeprom_read
sts dsp_invreg,temp

call load_mem_dsp

main:
call refresh_screen
call blu_rxok
call gps_rxok

call ln24x48_txts
call ln16x32u_txts
call ln16x32d_txts

call ln24x48_txtrs
call ln16x32u_txtrs
call ln16x32d_txtrs

call lnu_txts
call lnm_txts
call lnd_txts

call lnu_txtrs
call lnm_txtrs
call lnd_txtrs

call ln1_txts
call ln2_txts
call ln3_txts
call ln4_txts
call ln5_txts
call ln6_txts

call ln1_txtrs
call ln2_txtrs
call ln3_txtrs
call ln4_txtrs
call ln5_txtrs
call ln6_txtrs

call temp_update
call ln_effect_en
call prg_00
jmp main

prg_00:
lds temp,flag_reg0
sbrs temp,min_p
ret
cbr temp,0x40
sts flag_reg0,temp

lds temp,prg00_cnt
inc temp
sts prg00_cnt,temp
cpi temp,2
breq prg00_exe
ret

prg00_exe:
clr temp
sts prg00_cnt,temp
prg00_main:
call refresh_scr00
call gps_rxok
call blu_rxok
call temp_update
call ln_effect_en
lds temp,flag_reg0
sbrs temp,min_p
jmp prg00_main
cbr temp,0x40
sts flag_reg0,temp
call dsp_clr
call load_mem_dsp
ret

refresh_scr00:
lds temp,flag_reg0
sbrs temp,refresh_scr
ret
cbr temp,0x01
sts flag_reg0,temp
sbi portb,led_
call clock_update
call o16_disp
call d16_disp
call s16_disp
ret

load_mem_dsp:
lds temp,dsp_st16reg0
sbrc temp,lnu_sena
call load_lnu
lds temp,dsp_st16reg0
sbrc temp,lnm_sena
call load_lnm
lds temp,dsp_st16reg0
sbrc temp,lnd_sena
call load_lnd

lds temp,dsp_st16reg1
sbrc temp,lnu_rsena
call load_lnur
lds temp,dsp_st16reg1
sbrc temp,lnm_rsena
call load_lnmr
lds temp,dsp_st16reg1
sbrc temp,lnd_rsena
call load_lndr

lds temp,dsp_st16reg2
sbrc temp,lng_sena
call load_ln24x48
lds temp,dsp_st16reg2
sbrc temp,lng_rsena
call load_ln24x48r

lds temp,dsp_st16reg0
sbrc temp,lnbu_sena
call load_ln16x32u
lds temp,dsp_st16reg0
sbrc temp,lnbd_sena
call load_ln16x32d

lds temp,dsp_st16reg1
sbrc temp,lnbu_rsena
call load_ln16x32ur
lds temp,dsp_st16reg1
sbrc temp,lnbd_rsena
call load_ln16x32dr

lds temp,dsp_s8reg
sbrc temp,ln1_sena
call load_ln1
lds temp,dsp_s8reg
sbrc temp,ln2_sena
call load_ln2
lds temp,dsp_s8reg
sbrc temp,ln3_sena
call load_ln3
lds temp,dsp_s8reg
sbrc temp,ln4_sena
call load_ln4
lds temp,dsp_s8reg
sbrc temp,ln5_sena
call load_ln5
lds temp,dsp_s8reg
sbrc temp,ln6_sena
call load_ln6

lds temp,dsp_s8regr
sbrc temp,ln1_rsena
call load_ln1r
lds temp,dsp_s8regr
sbrc temp,ln2_rsena
call load_ln2r
lds temp,dsp_s8regr
sbrc temp,ln3_rsena
call load_ln3r
lds temp,dsp_s8regr
sbrc temp,ln4_rsena
call load_ln4r
lds temp,dsp_s8regr
sbrc temp,ln5_rsena
call load_ln5r
lds temp,dsp_s8regr
sbrc temp,ln6_rsena
call load_ln6r

call ln1_txt_dsp
call ln2_txt_dsp
call ln3_txt_dsp
call ln4_txt_dsp
call ln5_txt_dsp
call ln6_txt_dsp
call lnu_txt_dsp
call lnm_txt_dsp
call lnd_txt_dsp
call lnbu_txt_dsp
call lnbd_txt_dsp
ret

ln_effect_en:
lds temp,dsp_effreg
sbrc temp,ln1_eff
call ln_effect
lds temp,dsp_effreg
sbrc temp,ln2_eff
call ln_effect
lds temp,dsp_effreg
sbrc temp,ln3_eff
call ln_effect
lds temp,dsp_effreg
sbrc temp,ln4_eff
call ln_effect
lds temp,dsp_effreg
sbrc temp,ln5_eff
call ln_effect
lds temp,dsp_effreg
sbrc temp,ln6_eff
call ln_effect
ret

ln_effect:
lds temp,flag_reg0
sbrs temp,ln_efspeed
ret
cbr temp,0x08
sts flag_reg0,temp

lds temp,flag_reg0
sbrs temp,ln_eff
call inc_lnef
lds temp,flag_reg0
sbrc temp,ln_eff
call dec_lnef

lds temp,lnef_cnt
cpi temp,15
breq set_eff
cpi temp,0
breq clr_eff
ret
clr_eff:
lds temp,flag_reg0
cbr temp,0x10
sts flag_reg0,temp
ret
set_eff:
lds temp,flag_reg0
sbr temp,0x10
sts flag_reg0,temp
tst temp
ret

inc_lnef:
lds temp,lnef_cnt
inc temp
sts lnef_cnt,temp
sts dsp_i,temp
call dsp_seti_ln
ret
dec_lnef:
lds temp,lnef_cnt
dec temp
sts lnef_cnt,temp
sts dsp_i,temp
call dsp_seti_ln
ret


logo_print:
lds temp,dsp_invreg
cbr temp,0x01
sts dsp_invreg,temp
call print128x48p
ret
logo_printi:
lds temp,dsp_invreg
sbr temp,0x01
sts dsp_invreg,temp
call print128x48p
ret
print128x48p:
sbi portb,led_
ldi zl,byte3(table_US_128x48*2)
out RAMPZ,ZL
ldi zh,high(table_US_128x48*2)
ldi zl,low(table_US_128x48*2)
lds temp4,dsp_invreg
ldi temp,1
ln1_ploop128x48:
sts max7291_adr,temp
clr temp3
l1:
elpm temp2,z+
sbrc temp4,logo_i
com temp2
sts max7291_data,temp2
call send_16b
inc temp3
cpi temp3,16
brne l1
call ln1_en
inc temp
cpi temp,9
brne ln1_ploop128x48
ldi temp,1
ln2_ploop128x48:
sts max7291_adr,temp
clr temp3
l2:
elpm temp2,z+
sbrc temp4,logo_i
com temp2
sts max7291_data,temp2
call send_16b
inc temp3
cpi temp3,16
brne l2
call ln2_en
inc temp
cpi temp,9
brne ln2_ploop128x48
ldi temp,1
ln3_ploop128x48:
sts max7291_adr,temp
clr temp3
l3:
elpm temp2,z+
sbrc temp4,logo_i
com temp2
sts max7291_data,temp2
call send_16b
inc temp3
cpi temp3,16
brne l3
call ln3_en
inc temp
cpi temp,9
brne ln3_ploop128x48
ldi temp,1
ln4_ploop128x48:
sts max7291_adr,temp
clr temp3
l4:
elpm temp2,z+
sbrc temp4,logo_i
com temp2
sts max7291_data,temp2
call send_16b
inc temp3
cpi temp3,16
brne l4
call ln4_en
inc temp
cpi temp,9
brne ln4_ploop128x48
ldi temp,1
ln5_ploop128x48:
sts max7291_adr,temp
clr temp3
l5:
elpm temp2,z+
sbrc temp4,logo_i
com temp2
sts max7291_data,temp2
call send_16b
inc temp3
cpi temp3,16
brne l5
call ln5_en
inc temp
cpi temp,9
brne ln5_ploop128x48
ldi temp,1
ln6_ploop128x48:
sts max7291_adr,temp
clr temp3
l6:
elpm temp2,z+
sbrc temp4,logo_i
com temp2
sts max7291_data,temp2
call send_16b
inc temp3
cpi temp3,16
brne l6
call ln6_en
inc temp
cpi temp,9
brne ln6_ploop128x48
ret


ln24x48_txts:
lds temp,dsp_st16reg2
sbrs temp,lng_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call ln24x48_txtl
ret
ln24x48_txtrs:
lds temp,dsp_st16reg2
sbrs temp,lng_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call ln24x48_txtr
ret

ln16x32u_txts:
lds temp,dsp_st16reg0
sbrs temp,lnbu_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call ln16x32u_txtl
ret
ln16x32u_txtrs:
lds temp,dsp_st16reg1
sbrs temp,lnbu_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call ln16x32u_txtr
ret

ln16x32d_txts:
lds temp,dsp_st16reg0
sbrs temp,lnbd_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln3_speedf
ret
cbr temp,0x20
sts dsp_speedreg,temp
sbi portb,led_
call ln16x32d_txtl
ret
ln16x32d_txtrs:
lds temp,dsp_st16reg1
sbrs temp,lnbd_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln3_speedf
ret
cbr temp,0x20
sts dsp_speedreg,temp
sbi portb,led_
call ln16x32d_txtr
ret

lnu_txts:
lds temp,dsp_st16reg0
sbrs temp,lnu_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call lnu_txtl
ret
lnu_txtrs:
lds temp,dsp_st16reg1
sbrs temp,lnu_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call lnu_txtr
ret

lnm_txts:
lds temp,dsp_st16reg0
sbrs temp,lnm_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln3_speedf
ret
cbr temp,0x20
sts dsp_speedreg,temp
sbi portb,led_
call lnm_txtl
ret
lnm_txtrs:
lds temp,dsp_st16reg1
sbrs temp,lnm_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln3_speedf
ret
cbr temp,0x20
sts dsp_speedreg,temp
sbi portb,led_
call lnm_txtr
ret

lnd_txts:
lds temp,dsp_st16reg0
sbrs temp,lnd_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln5_speedf
ret
cbr temp,0x08
sts dsp_speedreg,temp
sbi portb,led_
call lnd_txtl
ret
lnd_txtrs:
lds temp,dsp_st16reg1
sbrs temp,lnd_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln5_speedf
ret
cbr temp,0x08
sts dsp_speedreg,temp
sbi portb,led_
call lnd_txtr
ret

clock_update:
lds temp,_sec
cpi temp,30
brne ntime_sinc
call time_sinc
ntime_sinc:
clr fbin1
clr fbin2
lds fbin0,_hour
call bin3bcd
mov temp,tbcd0
andi temp,0x0f
ori temp,0x30
sts hour_bcd,temp
mov temp,tbcd0
swap temp
andi temp,0x0f
ori temp,0x30
sts hour_bcd+1,temp
clr fbin1
clr fbin2
lds fbin0,_min
call bin3bcd
mov temp,tbcd0
andi temp,0x0f
ori temp,0x30
sts min_bcd,temp
mov temp,tbcd0
swap temp
andi temp,0x0f
ori temp,0x30
sts min_bcd+1,temp
clr fbin1
clr fbin2
lds fbin0,_sec
call bin3bcd
mov temp,tbcd0
andi temp,0x0f
ori temp,0x30
sts sec_bcd,temp
mov temp,tbcd0
swap temp
andi temp,0x0f
ori temp,0x30
sts sec_bcd+1,temp
ret
time_sinc:
lds temp,gps_char
cpi temp,'A'
brne time_false
lds temp,temp_sec
sts _sec,temp
lds temp,temp_min
sts _min,temp
lds temp,temp_hour
sts _hour,temp
lds temp,temp_day
sts day_bcd,temp
lds temp,temp_day+1
sts day_bcd+1,temp
lds temp,temp_month
sts month_bcd,temp
lds temp,temp_month+1
sts month_bcd+1,temp
lds temp,temp_year
sts year_bcd,temp
lds temp,temp_year+1
sts year_bcd+1,temp
call sumt_adj
time_false:
ret
sumt_adj:
lds temp,month_bcd
andi temp,0x0f
swap temp
lds temp2,month_bcd+1
andi temp2,0x0f
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,4
brge sumt_on
cpi temp,10
brge wint_on
jmp wint_on
sumt_on:
ldi temp,1
sts sum,temp
ret
wint_on:
clr temp
sts sum,temp
ret

temp_update:
lds temp,flag_reg0
sbrs temp,refresh_temp
ret
cbr temp,0x04
sts flag_reg0,temp
sbi portb,led_
call read_temp
call temp_load
ret

refresh_screen:
lds temp,flag_reg0
sbrs temp,refresh_scr
ret
cbr temp,0x01
sts flag_reg0,temp
sbi portb,led_
call clock_update
lds temp,dsp_tempreg
sbrc temp,ln1_t
call s1_disp
lds temp,dsp_tempreg
sbrc temp,ln2_t
call s2_disp
lds temp,dsp_tempreg
sbrc temp,ln3_t
call s3_disp
lds temp,dsp_tempreg
sbrc temp,ln4_t
call s4_disp
lds temp,dsp_tempreg
sbrc temp,ln5_t
call s5_disp
lds temp,dsp_tempreg
sbrc temp,ln6_t
call s6_disp
;--------------------------
lds temp,dsp_clkreg
sbrc temp,ln1_c
call o1_disp
lds temp,dsp_clkreg
sbrc temp,ln2_c
call o2_disp
lds temp,dsp_clkreg
sbrc temp,ln3_c
call o3_disp
lds temp,dsp_clkreg
sbrc temp,ln4_c
call o4_disp
lds temp,dsp_clkreg
sbrc temp,ln5_c
call o5_disp
lds temp,dsp_clkreg
sbrc temp,ln6_c
call o6_disp
;-----------------------------
lds temp,dsp_datereg
sbrc temp,ln1_d
call d1_disp
lds temp,dsp_datereg
sbrc temp,ln2_d
call d2_disp
lds temp,dsp_datereg
sbrc temp,ln3_d
call d3_disp
lds temp,dsp_datereg
sbrc temp,ln4_d
call d4_disp
lds temp,dsp_datereg
sbrc temp,ln5_d
call d5_disp
lds temp,dsp_datereg
sbrc temp,ln6_d
call d6_disp
;-----------------------------
ret

ln1_txts:
lds temp,dsp_s8reg
sbrs temp,ln1_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call ln1_txtl
ret
ln1_txtrs:
lds temp,dsp_s8regr
sbrs temp,ln1_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln1_speedf
ret
cbr temp,0x80
sts dsp_speedreg,temp
sbi portb,led_
call ln1_txtr
ret
ln2_txts:
lds temp,dsp_s8reg
sbrs temp,ln2_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln2_speedf
ret
cbr temp,0x40
sts dsp_speedreg,temp
sbi portb,led_
call ln2_txtl
ret
ln2_txtrs:
lds temp,dsp_s8regr
sbrs temp,ln2_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln2_speedf
ret
cbr temp,0x40
sts dsp_speedreg,temp
sbi portb,led_
call ln2_txtr
ret
ln3_txts:
lds temp,dsp_s8reg
sbrs temp,ln3_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln3_speedf
ret
cbr temp,0x20
sts dsp_speedreg,temp
sbi portb,led_
call ln3_txtl
ret
ln3_txtrs:
lds temp,dsp_s8regr
sbrs temp,ln3_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln3_speedf
ret
cbr temp,0x20
sts dsp_speedreg,temp
sbi portb,led_
call ln3_txtr
ret
ln4_txts:
lds temp,dsp_s8reg
sbrs temp,ln4_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln4_speedf
ret
cbr temp,0x10
sts dsp_speedreg,temp
sbi portb,led_
call ln4_txtl
ret
ln4_txtrs:
lds temp,dsp_s8regr
sbrs temp,ln4_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln4_speedf
ret
cbr temp,0x10
sts dsp_speedreg,temp
sbi portb,led_
call ln4_txtr
ret
ln5_txts:
lds temp,dsp_s8reg
sbrs temp,ln5_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln5_speedf
ret
cbr temp,0x08
sts dsp_speedreg,temp
sbi portb,led_
call ln5_txtl
ret
ln5_txtrs:
lds temp,dsp_s8regr
sbrs temp,ln5_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln5_speedf
ret
cbr temp,0x08
sts dsp_speedreg,temp
sbi portb,led_
call ln5_txtr
ret
ln6_txts:
lds temp,dsp_s8reg
sbrs temp,ln6_sena
ret
lds temp,dsp_speedreg
sbrs temp,ln6_speedf
ret
cbr temp,0x04
sts dsp_speedreg,temp
sbi portb,led_
call ln6_txtl
ret
ln6_txtrs:
lds temp,dsp_s8regr
sbrs temp,ln6_rsena
ret
lds temp,dsp_speedreg
sbrs temp,ln6_speedf
ret
cbr temp,0x04
sts dsp_speedreg,temp
sbi portb,led_
call ln6_txtr
ret

gps_rxok:
lds temp,flag_reg2
sbrs temp,gps_rx
ret
cbr temp,0x40
sts flag_reg2,temp
sbi portb,led_
ldi zl,low(gps_buf+1)
ldi zh,high(gps_buf+1)
ld temp,z+
cpi temp,'G'
brne no_string_gps
ld temp,z+
cpi temp,'P'
brne no_string_gps
ld temp,z+
cpi temp,'R'
brne no_string_gps
ld temp,z+
cpi temp,'M'
brne no_string_gps
ld temp,z+
cpi temp,'C'
brne no_string_gps
rjmp string_gps
no_string_gps:
call clr_gps_sram
ret
string_gps:
ldi zl,low(gps_buf+7)
ldi zh,high(gps_buf+7)
ld temp,z+
andi temp,0x0f
swap temp
ld temp2,z
andi temp2,0x0f
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
inc tbin0
inc tbin0
lds temp2,sum
cpi temp2,1
breq sum_tim
jmp win_tim
sum_tim:
inc tbin0
win_tim:
mov temp,tbin0
cpi temp,24
brne noth_2x
clr temp
noth_2x:
cpi temp,25
brne noth_2y
ldi temp,1
noth_2y:
cpi temp,26
brne noth_3y
ldi temp,2
noth_3y:
sts temp_hour,temp		;gps hour
ldi zl,low(gps_buf+9)
ldi zh,high(gps_buf+9)
ld temp,z+
andi temp,0x0f
swap temp
ld temp2,z
andi temp2,0x0f
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
sts temp_min,tbin0		;gps minute
ldi zl,low(gps_buf+11)
ldi zh,high(gps_buf+11)
ld temp,z+
andi temp,0x0f
swap temp
ld temp2,z
andi temp2,0x0f
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
sts temp_sec,tbin0		;gps second
ldi zl,low(gps_buf+17)
ldi zh,high(gps_buf+17)
ld temp,z
sts gps_char,temp		;gps char
ldi zl,low(gps_buf)
ldi zh,high(gps_buf)
CLR TEMP2
date_loop:
ld temp,z+
cpi temp,','
BREQ MSGP
RJMP DATE_LOOP
MSGP:
INC TEMP2
CPI TEMP2,9
breq got_date
rjmp date_loop
got_date:
ld temp,z+
sts temp_day,temp		;gps day
ld temp,z+
sts temp_day+1,temp		;gps day
ld temp,z+
sts temp_month,temp		;gps month
ld temp,z+
sts temp_month+1,temp	;gps month
ld temp,z+
sts temp_year,temp		;gps year
ld temp,z
sts temp_year+1,temp	;gps year
call clr_gps_sram
ret

;***************!!!!!!!!!!
clr_gps_sram:
clr temp
ldi yl,low(gps_buf)
ldi yh,high(gps_buf)
ldi xl,low(gps_buf+80)
ldi xh,high(gps_buf+80)
wipe_gps_sram:
st -x,temp
cp xl,yl
cpc xh,yh
brne wipe_gps_sram
ret 
;***************!!!!!!!!!!

blu_rxerr:
lds temp,flag_reg2
sbrs temp,blu_err
ret
cbr temp,0x80
sts flag_reg2,temp
call clr_blu_sram
call send_erbl
ret

blu_rxok:
lds temp,flag_reg2
sbrs temp,blu_rx
ret
cbr temp,0x08
sts flag_reg2,temp
sbi portb,led_
ldi zl,low(blu_buf)
ldi zh,high(blu_buf)
ld temp,z+
cpi temp,'t'
breq soft_test
cpi temp,'r'
breq soft_reset
cpi temp,'x'
breq clr_all
cpi temp,'i'
breq set_intensity
cpi temp,'?'
breq version
cpi temp,'l'
brne no_string
ld temp,z
cpi temp,'n'
brne no_string
jmp string
no_string:
call send_erbl
call clr_blu_sram
ret
version:
call send_version
call clr_blu_sram
ret
set_intensity:
call set_iall
call clr_blu_sram
ret
clr_all:
call send_okbl
call dsp_clr
call clr_blu_sram
ret
soft_reset:
call wdt_on
call send_okbl
call send_reset
jmp res_wait
soft_test:
call send_okbl
call dsp_sftest
delay 30
call wdt_on
call send_reset
reset_w:
jmp reset_w
string:
ldi zl,low(blu_buf+2)
ldi zh,high(blu_buf+2)
ld temp,z+
cpi temp,'b'
breq ln_b
cpi temp,'u'
breq ln_u
cpi temp,'m'
breq ln_m
cpi temp,'d'
breq ln_d
andi temp,0x0f
cpi temp,1
breq ln1_blu
cpi temp,2
breq ln2_blu
cpi temp,3
breq ln3_blu
cpi temp,4
breq ln4_blu
cpi temp,5
breq ln5_blu
cpi temp,6
breq ln6_blu
call clr_blu_sram
call send_erbl
ret
ln1_blu:
jmp ln1_bluexe
ln2_blu:
jmp ln2_bluexe
ln3_blu:
jmp ln3_bluexe
ln4_blu:
jmp ln4_bluexe
ln5_blu:
jmp ln5_bluexe
ln6_blu:
jmp ln6_bluexe
ln_u:
jmp lnu_bluexe
ln_m:
jmp lnm_bluexe
ln_d:
jmp lnd_bluexe
ln_b:
ld temp,z
cpi temp,'u'
breq lnb_u
cpi temp,'d'
breq lnb_d
cpi temp,'3'
breq lnb_3
call clr_blu_sram
call send_erbl
ret
lnb_u:
jmp lnbu_bluexe
lnb_d:
jmp lnbd_bluexe
lnb_3:
jmp lnb3_bluexe

lnbu_bluexe:
ldi zl,low(blu_buf+5)
ldi zh,high(blu_buf+5)
ld temp,z
cpi temp,'r'
breq lnbu_rscroll
cpi temp,'l'
breq lnbu_scroll
cpi temp,'t'
breq lnbu_txtdsp
call clr_blu_sram
call send_erbl
ret
lnbu_rscroll:
call send_okbl
jmp lnbu_rscroll_exe
lnbu_txtdsp:
call send_okbl
jmp lnbu_txt
;---------------------------------------------------
lnbu_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b11011001		;lnu-m scroll&txt off
sbr temp,0x02			;lnbu scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11110111		;lnbu-d txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b11110000		;ln1-4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b11110000		;ln1-4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b11110000		;ln1-4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b11110000		;ln1-4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b11110000		;ln1-4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b11110000		;ln1-4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+7)
ldi zh,high(blu_buf+7)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedbu_ok
call clr_blu_sram
call send_erbl
ret
speedbu_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+10)
ldi yh,high(blu_buf+10)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eelnbu:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnbu_bufovf
cpi temp,0x0d
brne write_eelnbu
sbiw x,1
lnbu_bufovf:
ldi temp,0xff
call eeprom_write
call load_ln16x32u
call clr_blu_sram
ret
;---------------------------------------------------
lnbu_rscroll_exe:
lds temp,dsp_st16reg0
cbr temp,0b11011011		;lnu-m scroll&txt off
;sbr temp,0x02			;lnbu-d scroll off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11110011		;lnbu-d txt off
sbr temp,0x04			;lnbu rscroll on
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b11110000		;ln1-4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b11110000		;ln1-4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b11110000		;ln1-4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b11110000		;ln1-4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b11110000		;ln1-4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b11110000		;ln1-4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+7)
ldi zh,high(blu_buf+7)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedbur_ok
call clr_blu_sram
call send_erbl
ret
speedbur_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+10)
ldi yh,high(blu_buf+10)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eelnbur:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnbur_bufovf
cpi temp,0x0d
brne write_eelnbur
sbiw x,1
lnbur_bufovf:
ldi temp,0xff
call eeprom_write
call load_ln16x32ur
call clr_blu_sram
ret
;----------------------------------------------
lnbu_txt:
lds temp,dsp_st16reg0
cbr temp,0b11011011		;lnu-m scroll&txt off
;cbr temp,0x02			;lnbu scroll off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01110111		;lnbd txt off
sbr temp,0x80			;lnbu txt on
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b11110000		;ln1-4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b11110000		;ln1-4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b11110000		;ln1-4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b11110000		;ln1-4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b11110000		;ln1-4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b11110000		;ln1-4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+7)
ldi yh,high(blu_buf+7)
ldi xh,high(table_ln1text)
ldi xl,low(table_ln1text)
ldi temp2,9
write_eetlnbu:
ld temp,y+
call eeprom_write
adiw x,1
dec temp2
tst temp2
breq lnbu_eof
cpi temp,0x0d
brne write_eetlnbu
lnbu_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call lnbu_txt_dsp
call clr_blu_sram
ret
;---------------------------------------------------
lnbd_bluexe:
ldi zl,low(blu_buf+5)
ldi zh,high(blu_buf+5)
ld temp,z
cpi temp,'r'
breq lnbd_rscroll
cpi temp,'l'
breq lnbd_scroll
cpi temp,'t'
breq lnbd_txtdsp
call clr_blu_sram
call send_erbl
ret
lnbd_txtdsp:
call send_okbl
jmp lnbd_txt
lnbd_rscroll:
call send_okbl
jmp lnbd_rscroll_exe
;---------------------------------------------------
lnbd_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b01101110		;lnm-d scroll&txt off
sbr temp,0x01			;lnbd scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11011110		;lnbu-d txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b00111100		;ln3-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b00111100		;ln3-6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b00111100		;ln3-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b00111100		;ln3-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b00111100		;ln3-6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b00111100		;ln3-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+7)
ldi zh,high(blu_buf+7)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedbd_ok
call clr_blu_sram
call send_erbl
ret
speedbd_ok:
sts ln3_speed,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_write
ldi yl,low(blu_buf+10)
ldi yh,high(blu_buf+10)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
clr temp2
write_eelnbd:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnbd_bufovf
cpi temp,0x0d
brne write_eelnbd
sbiw x,1
lnbd_bufovf:
ldi temp,0xff
call eeprom_write
call load_ln16x32d
call clr_blu_sram
ret
;----------------------------------------------
lnbd_rscroll_exe:
lds temp,dsp_st16reg0
cbr temp,0b01101111		;lnm-d scroll&txt off
;sbr temp,0x02			;lnbu-d scroll off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11011100		;lnbu-d txt off
sbr temp,0x02			;lnbd rscroll on
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b00111100		;ln3-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b00111100		;ln3-6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b00111100		;ln3-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b00111100		;ln3-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b00111100		;ln3-6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b00111100		;ln3-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+7)
ldi zh,high(blu_buf+7)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedbdr_ok
call clr_blu_sram
call send_erbl
ret
speedbdr_ok:
sts ln3_speed,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_write
ldi yl,low(blu_buf+10)
ldi yh,high(blu_buf+10)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
clr temp2
write_eelnbdr:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnbdr_bufovf
cpi temp,0x0d
brne write_eelnbdr
sbiw x,1
lnbdr_bufovf:
ldi temp,0xff
call eeprom_write
call load_ln16x32dr
call clr_blu_sram
ret
;----------------------------------------------
lnbd_txt:
lds temp,dsp_st16reg0
cbr temp,0b01101111		;lnm-d scroll&txt off
;cbr temp,0x01			;lnbd scroll off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10011111		;lnbu txt off
sbr temp,0x40			;lnbd txt on
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b00111100		;ln3-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b00111100		;ln3-6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b00111100		;ln3-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b00111100		;ln3-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b00111100		;ln3-6 off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b00111100		;ln3-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+7)
ldi yh,high(blu_buf+7)
ldi xh,high(table_ln3text)
ldi xl,low(table_ln3text)
ldi temp2,9
write_eetlnbd:
ld temp,y+
call eeprom_write
adiw x,1
dec temp2
tst temp2
breq lnbd_eof
cpi temp,0x0d
brne write_eetlnbd
lnbd_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call lnbd_txt_dsp
call clr_blu_sram
ret
;-------------------------------------------------------
lnb3_bluexe:
ldi zl,low(blu_buf+5)
ldi zh,high(blu_buf+5)
ld temp,z
cpi temp,'l'
breq lnb3_scroll
cpi temp,'r'
breq lnb3_rscroll
call clr_blu_sram
call send_erbl
ret
lnb3_rscroll:
jmp lnb3_rscroll_exe

lnb3_scroll:
call send_okbl
lds temp,dsp_st16reg0
clr temp				;lnu-d scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
clr temp				;lnbu-d txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
sbr temp,0b10000000				;lnbg scroll on
cbr temp,0b01000000				;lnbg reverse scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b11111100		;ln1-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b11111100		;ln1-6 reverse scroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b11111100		;ln1-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b11111100		;ln1-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b11111100		;ln1-6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b11111100		;ln1-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+7)
ldi zh,high(blu_buf+7)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedbg_ok
call clr_blu_sram
call send_erbl
ret
speedbg_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+10)
ldi yh,high(blu_buf+10)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eelnbg:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnbg_bufovf
cpi temp,0x0d
brne write_eelnbg
sbiw x,1
lnbg_bufovf:
ldi temp,0xff
call eeprom_write
call load_ln24x48
call clr_blu_sram
ret

lnb3_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
clr temp				;lnu-d scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
clr temp				;lnbu-d txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
sbr temp,0b01000000				;lnbg rscroll on
cbr temp,0b10000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b11111100		;ln1-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b11111100		;ln1-6 reverse scroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b11111100		;ln1-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b11111100		;ln1-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b11111100		;ln1-6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b11111100		;ln1-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+7)
ldi zh,high(blu_buf+7)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedbgr_ok
call clr_blu_sram
call send_erbl
ret
speedbgr_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+10)
ldi yh,high(blu_buf+10)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eelnbgr:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnbgr_bufovf
cpi temp,0x0d
brne write_eelnbgr
sbiw x,1
lnbgr_bufovf:
ldi temp,0xff
call eeprom_write
call load_ln24x48r
call clr_blu_sram
ret
;----------------------------------------------------------
lnu_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq lnu_scroll
cpi temp,'r'
breq lnu_rscroll
cpi temp,'t'
breq lnu_txtdsp
call clr_blu_sram
call send_erbl
ret
lnu_rscroll:
jmp lnu_rscroll_exe
lnu_txtdsp:
call send_okbl
jmp lnu_txt
;---------------------------------------------------------------
lnu_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b00010010		;lnbu scroll&txt off
sbr temp,0x80		;lnu scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0x80		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0xc0		;ln1-2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0xc0		;ln1-2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0xc0		;ln1-2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0xc0		;ln1-2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0xc0		;ln1-2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedu_ok
call clr_blu_sram
call send_erbl
ret
speedu_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eelnu:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnu_bufovf
cpi temp,0x0d
brne write_eelnu
lnu_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_lnu
call clr_blu_sram
ret
;---------------------------------------------------------------
lnu_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbu scroll&txt off
;sbr temp,0x80			;lnu scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10000100		;lnbu txt off
sbr temp,0x20
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0xc0		;ln1-2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0xc0		;ln1-2 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0xc0		;ln1-2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0xc0		;ln1-2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0xc0		;ln1-2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0xc0		;ln1-2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedur_ok
call clr_blu_sram
call send_erbl
ret
speedur_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eelnur:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnur_bufovf
cpi temp,0x0d
brne write_eelnur
lnur_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_lnur
call clr_blu_sram
ret
;-----------------------------------------------------------
lnu_txt:
lds temp,dsp_st16reg0
cbr temp,0b10000010		;lnbu scroll&txt off
sbr temp,0x10		;lnu txt on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0x80		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0xc0		;ln1-2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0xc0		;ln1-2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0xc0		;ln1-2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0xc0		;ln1-2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0xc0		;ln1-2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln1text)
ldi xl,low(table_ln1text)
ldi temp2,9
write_eetlnu:
ld temp,y+
call eeprom_write
adiw x,1
dec temp2
tst temp2
breq lnu_eof
cpi temp,0x0d
brne write_eetlnu
lnu_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call lnu_txt_dsp
call clr_blu_sram
ret
;----------------------------------------------------------
lnm_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq lnm_scroll
cpi temp,'r'
breq lnm_rscroll
cpi temp,'t'
breq lnm_txtdsp
call clr_blu_sram
call send_erbl
ret
lnm_rscroll:
jmp lnm_rscroll_exe
lnm_txtdsp:
call send_okbl
jmp lnm_txt
;---------------------------------------------------------------
lnm_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b00001011		;lnbu-d scroll&txt off
sbr temp,0x40		;lnm scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11000000		;lnbu-d txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b00110000		;ln3-4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b00110000		;ln3-4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b00110000		;ln3-4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b00110000		;ln3-4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b00110000		;ln3-4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedm_ok
call clr_blu_sram
call send_erbl
ret
speedm_ok:
sts ln3_speed,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
clr temp2
write_eelnm:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnm_bufovf
cpi temp,0x0d
brne write_eelnm
lnm_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_lnm
call clr_blu_sram
ret
;---------------------------------------------------------------
lnm_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b01001011		;lnbu-d scroll&txt off
;sbr temp,0x40			;lnm scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11000110		;lnbu-d txt off
sbr temp,0x10
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b00110000		;ln3-4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0b00110000		;ln3-4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b00110000		;ln3-4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b00110000		;ln3-4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b00110000		;ln3-4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b00110000		;ln3-4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedmr_ok
call clr_blu_sram
call send_erbl
ret
speedmr_ok:
sts ln3_speed,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
clr temp2
write_eelnmr:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnmr_bufovf
cpi temp,0x0d
brne write_eelnmr
lnmr_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_lnmr
call clr_blu_sram
ret
;-----------------------------------------------------------
lnm_txt:
lds temp,dsp_st16reg0
cbr temp,0b01000011		;lnbu-d scroll&txt off
sbr temp,0x08		;lnm txt on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11000000		;lnbu-d txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0b00110000		;ln3-4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0b00110000		;ln3-4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0b00110000		;ln3-4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0b00110000		;ln3-4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0b00110000		;ln3-4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln3text)
ldi xl,low(table_ln3text)
ldi temp2,9
write_eetlnm:
ld temp,y+
call eeprom_write
adiw x,1
dec temp2
tst temp2
breq lnm_eof
cpi temp,0x0d
brne write_eetlnm
lnm_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call lnm_txt_dsp
call clr_blu_sram
ret
;-----------------------------------------------------
lnd_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq lnd_scroll
cpi temp,'r'
breq lnd_rscroll
cpi temp,'t'
breq lnd_txtdsp
call clr_blu_sram
call send_erbl
ret
lnd_rscroll:
jmp lnd_rscroll_exe
lnd_txtdsp:
call send_okbl
jmp lnd_txt
;------------------------------------------------------
lnd_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0x05		;lnbd scroll&txt off
sbr temp,0x20		;lnd scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0x40		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x0c		;ln5-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x0c		;ln5-6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x0c		;ln5-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x0c		;ln5-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x0c		;ln5-6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x0c		;ln5-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speedd_ok
call clr_blu_sram
call send_erbl
ret
speedd_ok:
sts ln5_speed,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
clr temp2
write_eelnd:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lnd_bufovf
cpi temp,0x0d
brne write_eelnd
lnd_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_lnd
call clr_blu_sram
ret
;------------------------------------------------------
lnd_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
;sbr temp,0x20			;lnd scroll on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01000010		;lnbd txt off
sbr temp,0x08
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x0c		;ln5-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x0c		;ln5-6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x0c		;ln5-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x0c		;ln5-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x0c		;ln5-6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x0c		;ln5-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speeddr_ok
call clr_blu_sram
call send_erbl
ret
speeddr_ok:
sts ln5_speed,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
clr temp2
write_eelndr:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq lndr_bufovf
cpi temp,0x0d
brne write_eelndr
lndr_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_lndr
call clr_blu_sram
ret
;------------------------------------------------------
lnd_txt:
lds temp,dsp_st16reg0
cbr temp,0x21		;lnbd scroll&txt off
sbr temp,0x04		;lnd txt on
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0x40		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x0c		;ln5-6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x0c		;ln5-6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x0c		;ln5-6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x0c		;ln5-6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x0c		;ln5-6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln5text)
ldi xl,low(table_ln5text)
ldi temp2,9
write_eetlnd:
ld temp,y+
call eeprom_write
adiw x,1
dec temp2
tst temp2
breq lnd_eof
cpi temp,0x0d
brne write_eetlnd
lnd_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call lnd_txt_dsp
call clr_blu_sram
ret
;------------------------------------------------------------------------
ln1_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq ln1_scroll
cpi temp,'r'
breq ln1_rscroll
cpi temp,'t'
breq ln1_txtdsp
cpi temp,'c'
breq ln1_tempd
cpi temp,'o'
breq ln1_clk
cpi temp,'d'
breq ln1_date
cpi temp,'e'
breq ln1_ef
cpi temp,'i'
breq ln1_inv
call clr_blu_sram
call send_erbl
ret
ln1_rscroll:
jmp ln1_rscroll_exe
ln1_date:
call send_okbl
jmp ln1_datexe
ln1_clk:
call send_okbl
jmp ln1_clkexe
ln1_tempd:
call send_okbl
jmp ln1_tempexe
ln1_txtdsp:
call send_okbl
jmp ln1_txt
ln1_ef:
jmp ln1_efexe
ln1_inv:
jmp ln1_invexe
;---------------------------------------------------------
ln1_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnu-lnbu scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
sbr temp,0x80		;ln1 scroll on
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x80		;ln1 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x80		;ln1 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x80		;ln1 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x80		;ln1 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x80		;ln1 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed1_ok
call clr_blu_sram
call send_erbl
ret
speed1_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eeln1:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln1_bufovf
cpi temp,0x0d
brne write_eeln1
ln1_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln1
call clr_blu_sram
ret
;---------------------------------------------------
ln1_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnu-lnbu scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x80		;ln1 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
sbr temp,0x80		;ln1 rscroll on
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x80		;ln1 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x80		;ln1 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x80		;ln1 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x80		;ln1 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed1r_ok
call clr_blu_sram
call send_erbl
ret
speed1r_ok:
sts ln1_speed,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
clr temp2
write_eeln1r:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln1r_bufovf
cpi temp,0x0d
brne write_eeln1r
ln1r_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln1r
call clr_blu_sram
ret
;------------------------------------------------------
ln1_txt:
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x80		;ln1 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x80		;ln1 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
sbr temp,0x80		;ln1 txt on
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x80		;ln1 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x80		;ln1 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x80		;ln1 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln1text)
ldi xl,low(table_ln1text)
clr temp2
write_eetln1:
ld temp,y+
call eeprom_write
inc temp2
cpi temp2,17
breq wrln1_eof
adiw x,1
cpi temp,0x0d
brne write_eetln1
wrln1_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call ln1_txt_dsp
call clr_blu_sram
ret
;-------------------------------------------------------------
ln1_tempexe:
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x80		;ln1 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x80		;ln1 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x80		;ln1 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
sbr temp,0x80		;ln1 temp on
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x80		;ln1 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x80		;ln1 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------------
ln1_clkexe:
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x80		;ln1 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x80		;ln1 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x80		;ln1 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x80		;ln1 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
sbr temp,0x80		;ln1 clk on
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x80		;ln1 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------------
ln1_datexe:
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x80		;ln1 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x80		;ln1 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x80		;ln1 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x80		;ln1 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x80		;ln1 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
sbr temp,0x80		;ln1 date on
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
ln1_efexe:
call send_okbl
lds temp,dsp_effreg
sbrc temp,ln1_eff
jmp ln1_ef0
sbr temp,0x80		;ln1 effect on
sbrs temp,ln1_eff
ln1_ef0:
cbr temp,0x80		;ln1 effect off
sts dsp_effreg,temp
ldi xh,high(table_dsp_effreg)
ldi xl,low(table_dsp_effreg)
call eeprom_write
ret
ln1_invexe:
call send_okbl
lds temp,dsp_invreg
sbrc temp,ln1_if
jmp ln1_inv0
sbr temp,0x80		;ln1 inv on
sbrs temp,ln1_if
ln1_inv0:
cbr temp,0x80		;ln1 inv off
sts dsp_invreg,temp
ldi xh,high(table_dsp_invreg)
ldi xl,low(table_dsp_invreg)
call eeprom_write
ret
;-----------------------------------------------------------------
ln2_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq ln2_scroll
cpi temp,'r'
breq ln2_rscroll
cpi temp,'t'
breq ln2_txtdsp
cpi temp,'c'
breq ln2_tempd
cpi temp,'o'
breq ln2_clk
cpi temp,'d'
breq ln2_date
cpi temp,'e'
breq ln2_ef
cpi temp,'i'
breq ln2_inv
call clr_blu_sram
call send_erbl
ret
ln2_rscroll:
jmp ln2_rscroll_exe
ln2_date:
call send_okbl
jmp ln2_datexe
ln2_clk:
call send_okbl
jmp ln2_clkexe
ln2_tempd:
call send_okbl
jmp ln2_tempexe
ln2_txtdsp:
call send_okbl
jmp ln2_txt
ln2_ef:
jmp ln2_efexe
ln2_inv:
jmp ln2_invexe
;----------------------------------------------------------------
ln2_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
sbr temp,0x40		;ln2 scroll on
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x40		;ln2 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x40		;ln2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x40		;ln2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x40		;ln2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x40		;ln2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed2_ok
call clr_blu_sram
call send_erbl
ret
speed2_ok:
sts ln2_speed,temp
ldi xh,high(eeln2_speed)
ldi xl,low(eeln2_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln2txt)
ldi xl,low(table_ln2txt)
clr temp2
write_eeln2:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln2_bufovf
cpi temp,0x0d
brne write_eeln2
ln2_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln2
call clr_blu_sram
ret
;-------------------------------------------------------
ln2_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x40		;ln2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
sbr temp,0x40		;ln2 rscroll on
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x40		;ln2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x40		;ln2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x40		;ln2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x40		;ln2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed2r_ok
call clr_blu_sram
call send_erbl
ret
speed2r_ok:
sts ln2_speed,temp
ldi xh,high(eeln2_speed)
ldi xl,low(eeln2_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln2txt)
ldi xl,low(table_ln2txt)
clr temp2
write_eeln2r:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln2r_bufovf
cpi temp,0x0d
brne write_eeln2r
ln2r_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln2r
call clr_blu_sram
ret
;------------------------------------------------------------
ln2_txt:
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x40		;ln2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x40		;ln2 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
sbr temp,0x40		;ln2 txt on
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x40		;ln2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x40		;ln2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x40		;ln2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln2text)
ldi xl,low(table_ln2text)
clr temp2
write_eetln2:
ld temp,y+
call eeprom_write
inc temp2
cpi temp2,17
breq wrln2_eof
adiw x,1
cpi temp,0x0d
brne write_eetln2
wrln2_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call ln2_txt_dsp
call clr_blu_sram
ret
;-----------------------------------------------------------
ln2_tempexe:
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x40		;ln2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x40		;ln2 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x40		;ln2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
sbr temp,0x40		;ln2 temp on
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x40		;ln2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x40		;ln2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;---------------------------------------------------
ln2_clkexe:
lds temp,dsp_st16reg0
cbr temp,0b10010010		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x40		;ln2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x40		;ln2 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x40		;ln2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x40		;ln2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
sbr temp,0x40		;ln2 clk on
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x40		;ln2 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;---------------------------------------------------
ln2_datexe:
lds temp,dsp_st16reg0
cbr temp,0b10010010			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b10100100			;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x40		;ln2 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x40		;ln2 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x40		;ln2 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x40		;ln2 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x40		;ln2 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
sbr temp,0x40		;ln2 date on
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
ln2_efexe:
call send_okbl
lds temp,dsp_effreg
sbrc temp,ln2_eff
jmp ln2_ef0
sbr temp,0x40		;ln2 effect on
sbrs temp,ln2_eff
ln2_ef0:
cbr temp,0x40		;ln2 effect off
sts dsp_effreg,temp
ldi xh,high(table_dsp_effreg)
ldi xl,low(table_dsp_effreg)
call eeprom_write
ret
ln2_invexe:
call send_okbl
lds temp,dsp_invreg
sbrc temp,ln2_if
jmp ln2_inv0
sbr temp,0x40		;ln2 inv on
sbrs temp,ln2_if
ln2_inv0:
cbr temp,0x40		;ln2 inv off
sts dsp_invreg,temp
ldi xh,high(table_dsp_invreg)
ldi xl,low(table_dsp_invreg)
call eeprom_write
ret
;------------------------------------------------------
ln3_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq ln3_scroll
cpi temp,'r'
breq ln3_rscroll
cpi temp,'t'
breq ln3_txtdsp
cpi temp,'c'
breq ln3_tempd
cpi temp,'o'
breq ln3_clk
cpi temp,'d'
breq ln3_date
cpi temp,'e'
breq ln3_ef
cpi temp,'i'
breq ln3_inv
call clr_blu_sram
call send_erbl
ret
ln3_rscroll:
jmp ln3_rscroll_exe
ln3_date:
call send_okbl
jmp ln3_datexe
ln3_clk:
call send_okbl
jmp ln3_clkexe
ln3_tempd:
call send_okbl
jmp ln3_tempexe
ln3_txtdsp:
call send_okbl
jmp ln3_txt
ln3_ef:
jmp ln3_efexe
ln3_inv:
jmp ln3_invexe
;-------------------------------------------------------------
ln3_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b01001011			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110			;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
sbr temp,0x20		;ln3 scroll on
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x20		;ln3 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x20		;ln3 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x20		;ln3 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x20		;ln3 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x20		;ln3 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed3_ok
call clr_blu_sram
call send_erbl
ret
speed3_ok:
sts ln3_speed,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
clr temp2
write_eeln3:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln3_bufovf
cpi temp,0x0d
brne write_eeln3
ln3_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln3
call clr_blu_sram
ret
;--------------------------------------------------
ln3_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b01001011		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x20		;ln3 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
sbr temp,0x20		;ln3 rscroll on
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x20		;ln3 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x20		;ln3 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x20		;ln3 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x20		;ln3 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed3r_ok
call clr_blu_sram
call send_erbl
ret
speed3r_ok:
sts ln3_speed,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
clr temp2
write_eeln3r:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln3r_bufovf
cpi temp,0x0d
brne write_eeln3r
ln3r_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln3r
call clr_blu_sram
ret
;--------------------------------------------------
ln3_txt:
lds temp,dsp_st16reg0
cbr temp,0b01001011		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x20		;ln3 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x20		;ln3 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
sbr temp,0x20		;ln3 txt on
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x20		;ln3 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x20		;ln3 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x20		;ln3 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln3text)
ldi xl,low(table_ln3text)
clr temp2
write_eetln3:
ld temp,y+
call eeprom_write
inc temp2
cpi temp2,17
breq wrln3_eof
adiw x,1
cpi temp,0x0d
brne write_eetln3
wrln3_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call ln3_txt_dsp
call clr_blu_sram
ret
;-----------------------------------------------------
ln3_tempexe:
lds temp,dsp_st16reg0
cbr temp,0b01001011		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x20		;ln3 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x20		;ln3 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x20		;ln3 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
sbr temp,0x20		;ln3 temp on
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x20		;ln3 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x20		;ln3 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;---------------------------------------------------
ln3_clkexe:
lds temp,dsp_st16reg0
cbr temp,0b01001011		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x20		;ln3 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x20		;ln3 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x20		;ln3 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x20		;ln3 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
sbr temp,0x20		;ln3 clk on
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x20		;ln3 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;---------------------------------------------------
ln3_datexe:
lds temp,dsp_st16reg0
cbr temp,0b01001011		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x20		;ln3 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x20		;ln3 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x20		;ln3 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x20		;ln3 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x20		;ln3 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
sbr temp,0x20		;ln3 date on
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
ln3_efexe:
call send_okbl
lds temp,dsp_effreg
sbrc temp,ln3_eff
jmp ln3_ef0
sbr temp,0x20		;ln3 effect on
sbrs temp,ln3_eff
ln3_ef0:
cbr temp,0x20		;ln3 effect off
sts dsp_effreg,temp
ldi xh,high(table_dsp_effreg)
ldi xl,low(table_dsp_effreg)
call eeprom_write
ret
ln3_invexe:
call send_okbl
lds temp,dsp_invreg
sbrc temp,ln3_if
jmp ln3_inv0
sbr temp,0x20		;ln3 inv on
sbrs temp,ln3_if
ln3_inv0:
cbr temp,0x20		;ln3 inv off
sts dsp_invreg,temp
ldi xh,high(table_dsp_invreg)
ldi xl,low(table_dsp_invreg)
call eeprom_write
ret
;--------------------------------------------------------------
ln4_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq ln4_scroll
cpi temp,'r'
breq ln4_rscroll
cpi temp,'t'
breq ln4_txtdsp
cpi temp,'c'
breq ln4_tempd
cpi temp,'o'
breq ln4_clk
cpi temp,'d'
breq ln4_date
cpi temp,'e'
breq ln4_ef
cpi temp,'i'
breq ln4_inv
call clr_blu_sram
call send_erbl
ret
ln4_rscroll:
jmp ln4_rscroll_exe
ln4_date:
call send_okbl
jmp ln4_datexe
ln4_clk:
call send_okbl
jmp ln4_clkexe
ln4_tempd:
call send_okbl
jmp ln4_tempexe
ln4_txtdsp:
call send_okbl
jmp ln4_txt
ln4_ef:
jmp ln4_efexe
ln4_inv:
jmp ln4_invexe
;------------------------------------------------
ln4_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b01001011			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
sbr temp,0x10		;ln4 scroll on
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x10		;ln4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x10		;ln4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x10		;ln4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x10		;ln4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x10		;ln4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed4_ok
call clr_blu_sram
call send_erbl
ret
speed4_ok:
sts ln4_speed,temp
ldi xh,high(eeln4_speed)
ldi xl,low(eeln4_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln4txt)
ldi xl,low(table_ln4txt)
clr temp2
write_eeln4:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln4_bufovf
cpi temp,0x0d
brne write_eeln4
ln4_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln4
call clr_blu_sram
ret
;------------------------------------------------
ln4_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b01001011			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x10		;ln4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
sbr temp,0x10		;ln4 rscroll on
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x10		;ln4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x10		;ln4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x10		;ln4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x10		;ln4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed4r_ok
call clr_blu_sram
call send_erbl
ret
speed4r_ok:
sts ln4_speed,temp
ldi xh,high(eeln4_speed)
ldi xl,low(eeln4_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln4txt)
ldi xl,low(table_ln4txt)
clr temp2
write_eeln4r:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln4r_bufovf
cpi temp,0x0d
brne write_eeln4r
ln4r_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln4r
call clr_blu_sram
ret
;-----------------------------------------------------------
ln4_txt:
lds temp,dsp_st16reg0
cbr temp,0b01001011			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x10		;ln4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x10		;ln4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
sbr temp,0x10		;ln4 txt on
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x10		;ln4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x10		;ln4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x10		;ln4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln4text)
ldi xl,low(table_ln4text)
clr temp2
write_eetln4:
ld temp,y+
call eeprom_write
inc temp2
cpi temp2,17
breq wrln4_eof
adiw x,1
cpi temp,0x0d
brne write_eetln4
wrln4_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call ln4_txt_dsp
call clr_blu_sram
ret
;-------------------------------------------------------------------
ln4_tempexe:
lds temp,dsp_st16reg0
cbr temp,0b01001011			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x10		;ln4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x10		;ln4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x10		;ln4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
sbr temp,0x10		;ln4 temp on
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x10		;ln4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x10		;ln4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------
ln4_clkexe:
lds temp,dsp_st16reg0
cbr temp,0b01001011			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x10		;ln4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x10		;ln4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x10		;ln4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x10		;ln4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
sbr temp,0x10		;ln4 clk on
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x10		;ln4 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------
ln4_datexe:
lds temp,dsp_st16reg0
cbr temp,0b01001011			;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b11010110		;lnbu txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x10		;ln4 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x10		;ln4 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x10		;ln4 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x10		;ln4 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x10		;ln4 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
sbr temp,0x10		;ln4 date on
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
ln4_efexe:
call send_okbl
lds temp,dsp_effreg
sbrc temp,ln4_eff
jmp ln4_ef0
sbr temp,0x10		;ln4 effect on
sbrs temp,ln4_eff
ln4_ef0:
cbr temp,0x10		;ln4 effect off
sts dsp_effreg,temp
ldi xh,high(table_dsp_effreg)
ldi xl,low(table_dsp_effreg)
call eeprom_write
ret
ln4_invexe:
call send_okbl
lds temp,dsp_invreg
sbrc temp,ln4_if
jmp ln4_inv0
sbr temp,0x10		;ln4 inv on
sbrs temp,ln4_if
ln4_inv0:
cbr temp,0x10		;ln4 inv off
sts dsp_invreg,temp
ldi xh,high(table_dsp_invreg)
ldi xl,low(table_dsp_invreg)
call eeprom_write
ret
;--------------------------------------------------------------
ln5_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq ln5_scroll
cpi temp,'r'
breq ln5_rscroll
cpi temp,'t'
breq ln5_txtdsp
cpi temp,'c'
breq ln5_tempd
cpi temp,'o'
breq ln5_clk
cpi temp,'d'
breq ln5_date
cpi temp,'e'
breq ln5_ef
cpi temp,'i'
breq ln5_inv
call clr_blu_sram
call send_erbl
ret
ln5_rscroll:
jmp ln5_rscroll_exe
ln5_date:
call send_okbl
jmp ln5_datexe
ln5_clk:
call send_okbl
jmp ln5_clkexe
ln5_tempd:
call send_okbl
jmp ln5_tempexe
ln5_txtdsp:
call send_okbl
jmp ln5_txt
ln5_ef:
jmp ln5_efexe
ln5_inv:
jmp ln5_invexe
;------------------------------------------------
ln5_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
sbr temp,0x08		;ln5 scroll on
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x08		;ln5 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x08		;ln5 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x08		;ln5 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x08		;ln5 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x08		;ln5 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed5_ok
call clr_blu_sram
call send_erbl
ret
speed5_ok:
sts ln5_speed,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
clr temp2
write_eeln5:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln5_bufovf
cpi temp,0x0d
brne write_eeln5
ln5_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln5
call clr_blu_sram
ret
;------------------------------------------------
ln5_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x08		;ln5 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
sbr temp,0x08		;ln5 rscroll on
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x08		;ln5 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x08		;ln5 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x08		;ln5 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x08		;ln5 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed5r_ok
call clr_blu_sram
call send_erbl
ret
speed5r_ok:
sts ln5_speed,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
clr temp2
write_eeln5r:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln5r_bufovf
cpi temp,0x0d
brne write_eeln5r
ln5r_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln5r
call clr_blu_sram
ret
;-----------------------------------------------------------
ln5_txt:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x08		;ln5 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x08		;ln5 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
sbr temp,0x08		;ln5 txt on
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x08		;ln5 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x08		;ln5 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x08		;ln5 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln5text)
ldi xl,low(table_ln5text)
clr temp2
write_eetln5:
ld temp,y+
call eeprom_write
inc temp2
cpi temp2,17
breq wrln5_eof
adiw x,1
cpi temp,0x0d
brne write_eetln5
wrln5_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call ln5_txt_dsp
call clr_blu_sram
ret
;-------------------------------------------------------------------
ln5_tempexe:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010			;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x08		;ln5 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x08		;ln5 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x08		;ln5 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
sbr temp,0x08		;ln5 temp on
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x08		;ln5 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x08		;ln5 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------
ln5_clkexe:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010			;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x08		;ln5 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x08		;ln5 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x08		;ln5 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x08		;ln5 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
sbr temp,0x08		;ln5 clk on
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x08		;ln5 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------
ln5_datexe:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x08		;ln5 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x08		;ln5 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x08		;ln5 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x08		;ln5 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x08		;ln5 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
sbr temp,0x08		;ln5 date on
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
ln5_efexe:
call send_okbl
lds temp,dsp_effreg
sbrc temp,ln5_eff
jmp ln5_ef0
sbr temp,0x08		;ln5 effect on
sbrs temp,ln5_eff
ln5_ef0:
cbr temp,0x08		;ln5 effect off
sts dsp_effreg,temp
ldi xh,high(table_dsp_effreg)
ldi xl,low(table_dsp_effreg)
call eeprom_write
ret
ln5_invexe:
call send_okbl
lds temp,dsp_invreg
sbrc temp,ln5_if
jmp ln5_inv0
sbr temp,0x08		;ln5 inv on
sbrs temp,ln5_if
ln5_inv0:
cbr temp,0x08		;ln5 inv off
sts dsp_invreg,temp
ldi xh,high(table_dsp_invreg)
ldi xl,low(table_dsp_invreg)
call eeprom_write
ret
;--------------------------------------------------------------
ln6_bluexe:
ldi zl,low(blu_buf+4)
ldi zh,high(blu_buf+4)
ld temp,z
cpi temp,'l'
breq ln6_scroll
cpi temp,'r'
breq ln6_rscroll
cpi temp,'t'
breq ln6_txtdsp
cpi temp,'c'
breq ln6_tempd
cpi temp,'o'
breq ln6_clk
cpi temp,'d'
breq ln6_date
cpi temp,'e'
breq ln6_ef
cpi temp,'i'
breq ln6_inv
call clr_blu_sram
call send_erbl
ret
ln6_rscroll:
jmp ln6_rscroll_exe
ln6_date:
call send_okbl
jmp ln6_datexe
ln6_clk:
call send_okbl
jmp ln6_clkexe
ln6_tempd:
call send_okbl
jmp ln6_tempexe
ln6_txtdsp:
call send_okbl
jmp ln6_txt
ln6_ef:
jmp ln6_efexe
ln6_inv:
jmp ln6_invexe
;------------------------------------------------
ln6_scroll:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
sbr temp,0x04		;ln6 scroll on
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x04		;ln6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x04		;ln6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x04		;ln6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x04		;ln6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x04		;ln6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed6_ok
call clr_blu_sram
call send_erbl
ret
speed6_ok:
sts ln6_speed,temp
ldi xh,high(eeln6_speed)
ldi xl,low(eeln6_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln6txt)
ldi xl,low(table_ln6txt)
clr temp2
write_eeln6:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln6_bufovf
cpi temp,0x0d
brne write_eeln6
ln6_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln6
call clr_blu_sram
ret
;------------------------------------------------
ln6_rscroll_exe:
call send_okbl
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x04		;ln6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
sbr temp,0x04		;ln6 rscroll on
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x04		;ln6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x04		;ln6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x04		;ln6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x04		;ln6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi zl,low(blu_buf+6)
ldi zh,high(blu_buf+6)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,100
brlo speed6r_ok
call clr_blu_sram
call send_erbl
ret
speed6r_ok:
sts ln6_speed,temp
ldi xh,high(eeln6_speed)
ldi xl,low(eeln6_speed)
call eeprom_write
ldi yl,low(blu_buf+9)
ldi yh,high(blu_buf+9)
ldi xh,high(table_ln6txt)
ldi xl,low(table_ln6txt)
clr temp2
write_eeln6r:
ld temp,y+
call eeprom_write
adiw x,1
inc temp2
cpi temp2,200
breq ln6r_bufovf
cpi temp,0x0d
brne write_eeln6r
ln6r_bufovf:
sbiw x,1
ldi temp,0xff
call eeprom_write
call load_ln6r
call clr_blu_sram
ret
;-----------------------------------------------------------
ln6_txt:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x04		;ln6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x04		;ln6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
sbr temp,0x06		;ln6 txt on
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x04		;ln6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x04		;ln6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x04		;ln6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ldi yl,low(blu_buf+6)
ldi yh,high(blu_buf+6)
ldi xh,high(table_ln6text)
ldi xl,low(table_ln6text)
clr temp2
write_eetln6:
ld temp,y+
call eeprom_write
inc temp2
cpi temp2,17
breq wrln6_eof
adiw x,1
cpi temp,0x0d
brne write_eetln6
wrln6_eof:
sbiw x,1
ldi temp,0xff
call eeprom_write
call ln6_txt_dsp
call clr_blu_sram
ret
;-------------------------------------------------------------------
ln6_tempexe:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x04		;ln6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x04		;ln6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x04		;ln6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
sbr temp,0x04		;ln6 temp on
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x04		;ln6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x04		;ln6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------
ln6_clkexe:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x04		;ln6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x04		;ln6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x04		;ln6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x04		;ln6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
sbr temp,0x04		;ln6 clk on
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
cbr temp,0x04		;ln6 date off
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
;--------------------------------------------------------------
ln6_datexe:
lds temp,dsp_st16reg0
cbr temp,0b00100101		;lnbd scroll&txt off
sts dsp_st16reg0,temp
ldi xh,high(table_dsp_st16reg0)
ldi xl,low(table_dsp_st16reg0)
call eeprom_write
lds temp,dsp_st16reg1
cbr temp,0b01001010		;lnbd txt off
sts dsp_st16reg1,temp
ldi xh,high(table_dsp_st16reg1)
ldi xl,low(table_dsp_st16reg1)
call eeprom_write
lds temp,dsp_st16reg2
cbr temp,0b11000000				;lnbg scroll off
sts dsp_st16reg2,temp
ldi xh,high(table_dsp_st16reg2)
ldi xl,low(table_dsp_st16reg2)
call eeprom_write
lds temp,dsp_s8reg
cbr temp,0x04		;ln6 scroll off
sts dsp_s8reg,temp
ldi xh,high(table_dsp_s8reg)
ldi xl,low(table_dsp_s8reg)
call eeprom_write
lds temp,dsp_s8regr
cbr temp,0x04		;ln6 rscroll off
sts dsp_s8regr,temp
ldi xh,high(table_dsp_s8regr)
ldi xl,low(table_dsp_s8regr)
call eeprom_write
lds temp,dsp_t8reg
cbr temp,0x04		;ln6 txt off
sts dsp_t8reg,temp
ldi xh,high(table_dsp_t8reg)
ldi xl,low(table_dsp_t8reg)
call eeprom_write
lds temp,dsp_tempreg
cbr temp,0x04		;ln6 temp off
sts dsp_tempreg,temp
ldi xh,high(table_dsp_tempreg)
ldi xl,low(table_dsp_tempreg)
call eeprom_write
lds temp,dsp_clkreg
cbr temp,0x04		;ln6 clk off
sts dsp_clkreg,temp
ldi xh,high(table_dsp_clkreg)
ldi xl,low(table_dsp_clkreg)
call eeprom_write
lds temp,dsp_datereg
sbr temp,0x04		;ln6 date on
sts dsp_datereg,temp
ldi xh,high(table_dsp_datereg)
ldi xl,low(table_dsp_datereg)
call eeprom_write
ret
ln6_efexe:
call send_okbl
lds temp,dsp_effreg
sbrc temp,ln6_eff
jmp ln6_ef0
sbr temp,0x04		;ln4 effect on
sbrs temp,ln6_eff
ln6_ef0:
cbr temp,0x04		;ln4 effect off
sts dsp_effreg,temp
ldi xh,high(table_dsp_effreg)
ldi xl,low(table_dsp_effreg)
call eeprom_write
ret
ln6_invexe:
call send_okbl
lds temp,dsp_invreg
sbrc temp,ln6_if
jmp ln6_inv0
sbr temp,0x04		;ln6 inv on
sbrs temp,ln6_if
ln6_inv0:
cbr temp,0x04		;ln6 inv off
sts dsp_invreg,temp
ldi xh,high(table_dsp_invreg)
ldi xl,low(table_dsp_invreg)
call eeprom_write
ret

set_iall:
ldi zl,low(blu_buf+2)
ldi zh,high(blu_buf+2)
ld temp,z+
andi temp,0x0f
swap temp
sts blu_temp,temp
ld temp,z
andi temp,0x0f
lds temp2,blu_temp
or temp,temp2
mov fbcd0,temp
clr fbcd1
clr fbcd2
clr fbcd3
call bcd3bin
mov temp,tbin0
cpi temp,16
brsh ierr
sts dsp_i,temp
ldi xh,high(table_dspi)
ldi xl,low(table_dspi)
call eeprom_write
call dsp_seti
call send_okbl
ret
ierr:
call send_erbl
ret

send_okbl:
ldi zl,byte3(table_bluok*2)
out RAMPZ,ZL
ldi zh,high(table_bluok*2)
ldi zl,low(table_bluok*2)
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh
blok_loop:
elpm temp,z+
st y+,temp
cpi temp,0xff
brne blok_loop
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
ld temp,y+
sts udr1,temp
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh
ret

send_reset:
ldi zl,byte3(table_blureset*2)
out RAMPZ,ZL
ldi zh,high(table_blureset*2)
ldi zl,low(table_blureset*2)
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh
blres_loop:
elpm temp,z+
st y+,temp
cpi temp,0xff
brne blres_loop
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
ld temp,y+
sts udr1,temp
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh
ret

send_erbl:
ldi zl,byte3(table_blucmderr*2)
out RAMPZ,ZL
ldi zh,high(table_blucmderr*2)
ldi zl,low(table_blucmderr*2)
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh
blerr_loop:
elpm temp,z+
st y+,temp
cpi temp,0xff
brne blerr_loop
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
ld temp,y+
sts udr1,temp
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh
ret

send_version:
call dsp_clr
ldi zl,byte3(table_bluver*2)
out RAMPZ,ZL
ldi zh,high(table_bluver*2)
ldi zl,low(table_bluver*2)
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh
blvers_loop:
elpm temp,z+
st y+,temp
cpi temp,0xff
brne blvers_loop
ldi yh,high(blutx1_buf)
ldi yl,low(blutx1_buf)
ld temp,y+
sts udr1,temp
sts blutx1_ptr,yl
sts blutx1_ptr+1,yh

ldi zl,byte3(table_ver1*2)
out RAMPZ,ZL
ldi zh,high(table_ver1*2)
ldi zl,low(table_ver1*2)
ldi yh,high(ln_str)
ldi yl,low(ln_str)
call ldv_ch
lds temp,dsp_8reg
sbr temp,0x80 ; ln1 putstring
sts dsp_8reg,temp
call print_str16
ldi zl,byte3(table_ver2*2)
out RAMPZ,ZL
ldi zh,high(table_ver2*2)
ldi zl,low(table_ver2*2)
ldi yh,high(ln_str)
ldi yl,low(ln_str)
call ldv_ch
lds temp,dsp_8reg
sbr temp,0x20 ; ln3 putstring
sts dsp_8reg,temp
call print_str16
ldi zl,byte3(table_ver3*2)
out RAMPZ,ZL
ldi zh,high(table_ver3*2)
ldi zl,low(table_ver3*2)
ldi yh,high(ln_str)
ldi yl,low(ln_str)
call ldv_ch
lds temp,dsp_8reg
sbr temp,0x10 ; ln4 putstring
sts dsp_8reg,temp
call print_str16
ldi zl,byte3(table_ver4*2)
out RAMPZ,ZL
ldi zh,high(table_ver4*2)
ldi zl,low(table_ver4*2)
ldi yh,high(ln_str)
ldi yl,low(ln_str)
call ldv_ch
lds temp,dsp_8reg
sbr temp,0x08 ; ln5 putstring
sts dsp_8reg,temp
call print_str16
delay 15
call dsp_clr
ret

ldv_ch:
elpm temp,z+
st y+,temp
cpi temp,0xff
breq chv_eof
jmp ldv_ch
chv_eof:
ret

res_wait:
call dsp_clr
ldi xh,high(table_dspi)
ldi xl,low(table_dspi)
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0xff
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
adiw x,1
ldi temp,0x00
call eeprom_write
cli
reset_trap:
nop
jmp reset_trap

USART_Transmit:
; Wait for empty transmit buffer
lds temp2,UCSR1A
sbrs temp2,UDRE1
rjmp USART_Transmit
; Put data (r16) into buffer, sends the data
sts UDR1,temp
ret


;***************!!!!!!!!!!
clr_blu_sram:
clr temp
ldi yl,low(blu_buf)
ldi yh,high(blu_buf)
ldi xl,low(blu_buf+140)
ldi xh,high(blu_buf+140)
wipe_blu_sram:
st -x,temp
cp xl,yl
cpc xh,yh
brne wipe_blu_sram
ret 
;***************!!!!!!!!!!

clr_sram:
clr temp
ldi yl,low(sram_start)
ldi yh,high(sram_start)
ldi xl,low(ramend)
ldi xh,high(ramend)
wipe_sram:
st y+,temp
cp yl,xl
cpc yh,xh
brne wipe_sram
ret

WDT_on:
; Turn off global interrupt
cli
; Reset Watchdog Timer
wdr
; Start timed sequence
lds r16, WDTCSR
ori r16, (1<<WDCE) | (1<<WDE)
sts WDTCSR, r16
; -- Got four cycles to set the new values from here -
; Set new prescaler(time-out) value = 64K cycles (~0.5 s)
ldi r16, (1<<WDE) | (1<<WDP2) | (1<<WDP0) | (1<<WDP1)
sts WDTCSR, r16
; -- Finished setting new values, used 2 cycles -
; Turn on global interrupt
sei
ret

WDT_off:
; Turn off global interrupt
cli
; Reset Watchdog Timer
wdr
; Clear WDRF in MCUSR
lds r16, MCUSR
andi r16, ~(1<<WDRF)
out MCUSR, r16
; Write logical one to WDCE and WDE
; Keep old prescaler setting to prevent unintentional time-out
ldi r16, WDTCSR
ori r16, (1<<WDCE) | (1<<WDE)
sts WDTCSR, r16
; Turn off WDT
ldi r16, (0<<WDE)
sts WDTCSR, r16
; Turn on global interrupt
sei
ret

EEPROM_read:
; Wait for completion of previous write
sbic EECR,EEPE
rjmp EEPROM_read
; Set up address (r18:r17) in address register
out EEARH, xh
out EEARL, xl
; Start eeprom read by writing EERE
sbi EECR,EERE
; Read data from data register
in temp,EEDR
ret 
EEPROM_write:
; Wait for completion of previous write
sbic EECR,EEPE
rjmp EEPROM_write
; Set up address (r18:r17) in address register
out EEARH, xh
out EEARL, xl
; Write data (r16) to data register
out EEDR,temp
; Write logical one to EEMWE
sbi EECR,EEMPE
; Start eeprom write by setting EEWE
sbi EECR,EEPE
ret

.include "interrupts.inc"
.include "max7291.inc"
.include "ds18_routines.inc"
;.include "lcd_routines.inc"
;.include "i2c_clk_routines.inc"
.include "math_routines.inc"
.include "delay_routines.inc"
.include "lcd_strings.inc"
.include "ascii_table.inc"
.include "image_table.inc"
.include "eeprom_seg.inc"

