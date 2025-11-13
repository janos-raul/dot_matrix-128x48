/*
 * max7291.inc
 *
 *  Created: 25-Dec-22 08:59:37
 *   Author: janos
 */ 

temp_uart:
ldi xh,high(temp_str)
ldi xl,low(temp_str)
ld temp,x+
call usart_transmit
ld temp,x+
call usart_transmit
ld temp,x+
call usart_transmit
ld temp,x+
call usart_transmit
ld temp,x+
call usart_transmit
ld temp,x
call usart_transmit
ldi temp,0x0d
call usart_transmit
ldi temp,0x0a
call usart_transmit
ret
load_tempstring:
ldi yh,high(ln_str)
ldi yl,low(ln_str)
ldi xh,high(temp_str)
ldi xl,low(temp_str)
ldi temp,' '
st y+,temp
ldi temp2,6
s_strloop:
ld temp,x+
st y+,temp
dec temp2
tst temp2
brne s_strloop
ldi temp,0xff
st y,temp
ret
s1_disp:
call load_tempstring
lds temp,dsp_8reg
sbr temp,0x80 ; ln1 putstring
sts dsp_8reg,temp
call print_str16
ret
s2_disp:
call load_tempstring
lds temp,dsp_8reg
sbr temp,0x40 ; ln2 putstring
sts dsp_8reg,temp
call print_str16
ret
s3_disp:
call load_tempstring
lds temp,dsp_8reg
sbr temp,0x20 ; ln3 putstring
sts dsp_8reg,temp
call print_str16
ret
s4_disp:
call load_tempstring
lds temp,dsp_8reg
sbr temp,0x10 ; ln4 putstring
sts dsp_8reg,temp
call print_str16
ret
s5_disp:
call load_tempstring
lds temp,dsp_8reg
sbr temp,0x08 ; ln5 putstring
sts dsp_8reg,temp
call print_str16
ret
s6_disp:
call load_tempstring
lds temp,dsp_8reg
sbr temp,0x04 ; ln6 putstring
sts dsp_8reg,temp
call print_str16
ret
s16_disp:
call load_tempstring
lds temp,dsp_16reg
sbr temp,0x20 ; lnd putstring
sts dsp_16reg,temp
call print_str16x16
ret

load_clkstring:
ldi yh,high(ln_str)
ldi yl,low(ln_str)
lds temp,hour_bcd+1
st y+,temp
lds temp,hour_bcd
st y+,temp
ldi temp,':'
st y+,temp
lds temp,min_bcd+1
st y+,temp
lds temp,min_bcd
st y+,temp
ldi temp,':'
st y+,temp
lds temp,sec_bcd+1
st y+,temp
lds temp,sec_bcd
st y+,temp
ldi temp,' '
st y+,temp
ldi xh,high(temp_str)
ldi xl,low(temp_str)
ldi temp2,6
o1_strl:
ld temp,x+
st y+,temp
dec temp2
tst temp2
brne o1_strl
ldi temp,0xff
st y,temp
ret
o1_disp:
call load_clkstring
lds temp,dsp_8reg
sbr temp,0x80 ; ln1 putstring
sts dsp_8reg,temp
call print_str16
ret
o2_disp:
call load_clkstring
lds temp,dsp_8reg
sbr temp,0x40 ; ln2 putstring
sts dsp_8reg,temp
call print_str16
ret
o3_disp:
call load_clkstring
lds temp,dsp_8reg
sbr temp,0x20 ; ln3 putstring
sts dsp_8reg,temp
call print_str16
ret
o4_disp:
call load_clkstring
lds temp,dsp_8reg
sbr temp,0x10 ; ln4 putstring
sts dsp_8reg,temp
call print_str16
ret
o5_disp:
call load_clkstring
lds temp,dsp_8reg
sbr temp,0x08 ; ln5 putstring
sts dsp_8reg,temp
call print_str16
ret
o6_disp:
call load_clkstring
lds temp,dsp_8reg
sbr temp,0x04 ; ln6 putstring
sts dsp_8reg,temp
call print_str16
ret
o16_disp:
call load_clkstring
lds temp,dsp_16reg
sbr temp,0x80 ; lnu putstring
sts dsp_16reg,temp
call print_str16x16
ret

load_datestring:
ldi yh,high(ln_str)
ldi yl,low(ln_str)
lds temp,day_bcd
st y+,temp
lds temp,day_bcd+1
st y+,temp
ldi temp,'/'
st y+,temp
lds temp,month_bcd
st y+,temp
lds temp,month_bcd+1
st y+,temp
ldi temp,'/'
st y+,temp
lds temp,year_bcd
st y+,temp
lds temp,year_bcd+1
st y+,temp
ldi temp,0xff
st y,temp
ret
d1_disp:
call load_datestring
lds temp,dsp_8reg
sbr temp,0x80 ; ln1 putstring
sts dsp_8reg,temp
call print_str16
ret
d2_disp:
call load_datestring
lds temp,dsp_8reg
sbr temp,0x40 ; ln2 putstring
sts dsp_8reg,temp
call print_str16
ret
d3_disp:
call load_datestring
lds temp,dsp_8reg
sbr temp,0x20 ; ln3 putstring
sts dsp_8reg,temp
call print_str16
ret
d4_disp:
call load_datestring
lds temp,dsp_8reg
sbr temp,0x10 ; ln4 putstring
sts dsp_8reg,temp
call print_str16
ret
d5_disp:
call load_datestring
lds temp,dsp_8reg
sbr temp,0x08 ; ln5 putstring
sts dsp_8reg,temp
call print_str16
ret
d6_disp:
call load_datestring
lds temp,dsp_8reg
sbr temp,0x04 ; ln6 putstring
sts dsp_8reg,temp
call print_str16
ret
d16_disp:
call load_datestring
lds temp,dsp_16reg
sbr temp,0x40 ; lnm putstring
sts dsp_16reg,temp
call print_str16x16
ret

lnbu_txt_dsp:
lds temp,dsp_st16reg1
sbrs temp,lnbu_tena
ret
ldi xh,high(table_ln1text)
ldi xl,low(table_ln1text)
ldi temp5,1
sts ln_char,temp5
lnbu_txtloop:
lds temp,dsp_16reg
sbr temp,0x10 ;lnbu chrprint
sts dsp_16reg,temp
call eeprom_read
adiw x,1
cpi temp,0xff
breq lnbu_txteof
call dsp_16x32
inc temp5
sts ln_char,temp5
cpi temp5,9
brne lnbu_txtloop
lnbu_txteof:
ret
lnbd_txt_dsp:
lds temp,dsp_st16reg1
sbrs temp,lnbd_tena
ret
ldi xh,high(table_ln3text)
ldi xl,low(table_ln3text)
ldi temp5,1
sts ln_char,temp5
lnbd_txtloop:
lds temp,dsp_16reg
sbr temp,0x08 ;lnbd chrprint
sts dsp_16reg,temp
call eeprom_read
adiw x,1
cpi temp,0xff
breq lnbd_txteof
call dsp_16x32
inc temp5
sts ln_char,temp5
cpi temp5,9
brne lnbd_txtloop
lnbd_txteof:
ret
lnu_txt_dsp:
lds temp,dsp_st16reg0
sbrs temp,lnu_tena
ret
clr temp ; dsp16 chrf clear
sts dsp_16reg,temp
ldi xh,high(table_ln1text)
ldi xl,low(table_ln1text)
ldi temp5,1
sts ln_char,temp5
lnu_txtloop:
lds temp,dsp_16reg
sbr temp,0x80 ;lnu chrprint
sts dsp_16reg,temp
call eeprom_read
adiw x,1
cpi temp,0xff
breq lnu_txteof
call dsp_16x16
inc temp5
sts ln_char,temp5
cpi temp5,9
brne lnu_txtloop
lnu_txteof:
ret
lnm_txt_dsp:
lds temp,dsp_st16reg0
sbrs temp,lnm_tena
ret
clr temp ; dsp16 chrf clear
sts dsp_16reg,temp
ldi xh,high(table_ln3text)
ldi xl,low(table_ln3text)
ldi temp5,1
sts ln_char,temp5
lnm_txtloop:
lds temp,dsp_16reg
sbr temp,0x40 ;lnm chrprint
sts dsp_16reg,temp
call eeprom_read
adiw x,1
cpi temp,0xff
breq lnm_txteof
call dsp_16x16
inc temp5
sts ln_char,temp5
cpi temp5,9
brne lnm_txtloop
lnm_txteof:
ret
lnd_txt_dsp:
lds temp,dsp_st16reg0
sbrs temp,lnd_tena
ret
clr temp ; dsp16 chrf clear
sts dsp_16reg,temp
ldi xh,high(table_ln5text)
ldi xl,low(table_ln5text)
ldi temp5,1
sts ln_char,temp5
lnd_txtloop:
lds temp,dsp_16reg
sbr temp,0x20 ;lnd chrprint
sts dsp_16reg,temp
call eeprom_read
adiw x,1
cpi temp,0xff
breq lnd_txteof
call dsp_16x16
inc temp5
sts ln_char,temp5
cpi temp5,9
brne lnd_txtloop
lnd_txteof:
ret
ln1_txt_dsp:
lds temp,dsp_t8reg
sbrs temp,ln1_tena
ret
ldi yh,high(ln_str)
ldi yl,low(ln_str)
ldi xh,high(table_ln1text)
ldi xl,low(table_ln1text)
ldi temp2,16
reads_eeln1:
call eeprom_read
adiw x,1
st y+,temp
dec temp2
tst temp2
breq ee1_eof
cpi temp,0xff
brne reads_eeln1
ee1_eof:
ldi temp,0xff
st y,temp
lds temp,dsp_8reg
sbr temp,0x80 ; ln1 putstring
sts dsp_8reg,temp
call print_str16
ret
ln2_txt_dsp:
lds temp,dsp_t8reg
sbrs temp,ln2_tena
ret
ldi yh,high(ln_str)
ldi yl,low(ln_str)
ldi xh,high(table_ln2text)
ldi xl,low(table_ln2text)
ldi temp2,16
reads_eeln2:
call eeprom_read
adiw x,1
st y+,temp
dec temp2
tst temp2
breq ee2_eof
cpi temp,0xff
brne reads_eeln2
ee2_eof:
ldi temp,0xff
st y,temp
lds temp,dsp_8reg
sbr temp,0x40 ; ln2 putstring
sts dsp_8reg,temp
call print_str16
ret
ln3_txt_dsp:
lds temp,dsp_t8reg
sbrs temp,ln3_tena
ret
ldi yh,high(ln_str)
ldi yl,low(ln_str)
ldi xh,high(table_ln3text)
ldi xl,low(table_ln3text)
ldi temp2,16
reads_eeln3:
call eeprom_read
adiw x,1
st y+,temp
dec temp2
tst temp2
breq ee3_eof
cpi temp,0xff
brne reads_eeln3
ee3_eof:
ldi temp,0xff
st y,temp
lds temp,dsp_8reg
sbr temp,0x20 ; ln3 putstring
sts dsp_8reg,temp
call print_str16
ret
ln4_txt_dsp:
lds temp,dsp_t8reg
sbrs temp,ln4_tena
ret
ldi yh,high(ln_str)
ldi yl,low(ln_str)
ldi xh,high(table_ln4text)
ldi xl,low(table_ln4text)
ldi temp2,16
reads_eeln4:
call eeprom_read
adiw x,1
st y+,temp
dec temp2
tst temp2
breq ee4_eof
cpi temp,0xff
brne reads_eeln4
ee4_eof:
ldi temp,0xff
st y,temp
lds temp,dsp_8reg
sbr temp,0x10 ; ln4 putstring
sts dsp_8reg,temp
call print_str16
ret
ln5_txt_dsp:
lds temp,dsp_t8reg
sbrs temp,ln5_tena
ret
ldi yh,high(ln_str)
ldi yl,low(ln_str)
ldi xh,high(table_ln5text)
ldi xl,low(table_ln5text)
ldi temp2,16
reads_eeln5:
call eeprom_read
adiw x,1
st y+,temp
dec temp2
tst temp2
breq ee5_eof
cpi temp,0xff
brne reads_eeln5
ee5_eof:
ldi temp,0xff
st y,temp
lds temp,dsp_8reg
sbr temp,0x08 ; ln5 putstring
sts dsp_8reg,temp
call print_str16
ret
ln6_txt_dsp:
lds temp,dsp_t8reg
sbrs temp,ln6_tena
ret
ldi yh,high(ln_str)
ldi yl,low(ln_str)
ldi xh,high(table_ln6text)
ldi xl,low(table_ln6text)
ldi temp2,16
reads_eeln6:
call eeprom_read
adiw x,1
st y+,temp
dec temp2
tst temp2
breq ee6_eof
cpi temp,0xff
brne reads_eeln6
ee6_eof:
ldi temp,0xff
st y,temp
lds temp,dsp_8reg
sbr temp,0x04 ; ln6 putstring
sts dsp_8reg,temp
call print_str16
ret

load_ln24x48:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eel24x48:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eel24x48
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call ln24x48_txt_init
ret
load_ln24x48r:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eel24x48r:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eel24x48r
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call ln24x48r_txt_init
ret
load_ln16x32u:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eel16x32u:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eel16x32u
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call ln16x32u_txt_init
ret
load_ln16x32ur:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eel16x32ur:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eel16x32ur
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call ln16x32ur_txt_init
ret
load_ln16x32d:
ldi yh,high(ln3_textch)
ldi yl,low(ln3_textch)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
read_eel16x32d:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eel16x32d
st y,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_read
sts ln3_speed,temp
call ln16x32d_txt_init
ret
load_ln16x32dr:
ldi yh,high(ln3_textch)
ldi yl,low(ln3_textch)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
read_eel16x32dr:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eel16x32dr
st y,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_read
sts ln3_speed,temp
call ln16x32dr_txt_init
ret

load_lnu:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eelnu:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eelnu
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call lnu_txt_init
ret
load_lnur:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eelnur:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eelnur
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call lnu_txt_initr
ret
load_lnm:
ldi yh,high(ln3_textch)
ldi yl,low(ln3_textch)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
read_eelnm:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eelnm
st y,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_read
sts ln3_speed,temp
call lnm_txt_init
ret
load_lnmr:
ldi yh,high(ln3_textch)
ldi yl,low(ln3_textch)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
read_eelnmr:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eelnmr
st y,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_read
sts ln3_speed,temp
call lnm_txt_initr
ret
load_lnd:
ldi yh,high(ln5_textch)
ldi yl,low(ln5_textch)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
read_eelnd:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eelnd
st y,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_read
sts ln5_speed,temp
call lnd_txt_init
ret
load_lndr:
ldi yh,high(ln5_textch)
ldi yl,low(ln5_textch)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
read_eelndr:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eelndr
st y,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_read
sts ln5_speed,temp
call lnd_txt_initr
ret

load_ln1:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eeln1:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln1
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call ln1_txt_init
ret
load_ln1r:
ldi yh,high(ln1_textch)
ldi yl,low(ln1_textch)
ldi xh,high(table_ln1txt)
ldi xl,low(table_ln1txt)
read_eeln1r:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln1r
st y,temp
ldi xh,high(eeln1_speed)
ldi xl,low(eeln1_speed)
call eeprom_read
sts ln1_speed,temp
call ln1r_txt_init
ret
load_ln2:
ldi yh,high(ln2_textch)
ldi yl,low(ln2_textch)
ldi xh,high(table_ln2txt)
ldi xl,low(table_ln2txt)
read_eeln2:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln2
st y,temp
ldi xh,high(eeln2_speed)
ldi xl,low(eeln2_speed)
call eeprom_read
sts ln2_speed,temp
call ln2_txt_init
ret
load_ln2r:
ldi yh,high(ln2_textch)
ldi yl,low(ln2_textch)
ldi xh,high(table_ln2txt)
ldi xl,low(table_ln2txt)
read_eeln2r:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln2r
st y,temp
ldi xh,high(eeln2_speed)
ldi xl,low(eeln2_speed)
call eeprom_read
sts ln2_speed,temp
call ln2r_txt_init
ret
load_ln3:
ldi yh,high(ln3_textch)
ldi yl,low(ln3_textch)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
read_eeln3:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln3
st y,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_read
sts ln3_speed,temp
call ln3_txt_init
ret
load_ln3r:
ldi yh,high(ln3_textch)
ldi yl,low(ln3_textch)
ldi xh,high(table_ln3txt)
ldi xl,low(table_ln3txt)
read_eeln3r:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln3r
st y,temp
ldi xh,high(eeln3_speed)
ldi xl,low(eeln3_speed)
call eeprom_read
sts ln3_speed,temp
call ln3r_txt_init
ret
load_ln4:
ldi yh,high(ln4_textch)
ldi yl,low(ln4_textch)
ldi xh,high(table_ln4txt)
ldi xl,low(table_ln4txt)
read_eeln4:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln4
st y,temp
ldi xh,high(eeln4_speed)
ldi xl,low(eeln4_speed)
call eeprom_read
sts ln4_speed,temp
call ln4_txt_init
ret
load_ln4r:
ldi yh,high(ln4_textch)
ldi yl,low(ln4_textch)
ldi xh,high(table_ln4txt)
ldi xl,low(table_ln4txt)
read_eeln4r:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln4r
st y,temp
ldi xh,high(eeln4_speed)
ldi xl,low(eeln4_speed)
call eeprom_read
sts ln4_speed,temp
call ln4r_txt_init
ret
load_ln5:
ldi yh,high(ln5_textch)
ldi yl,low(ln5_textch)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
read_eeln5:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln5
st y,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_read
sts ln5_speed,temp
call ln5_txt_init
ret
load_ln5r:
ldi yh,high(ln5_textch)
ldi yl,low(ln5_textch)
ldi xh,high(table_ln5txt)
ldi xl,low(table_ln5txt)
read_eeln5r:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln5r
st y,temp
ldi xh,high(eeln5_speed)
ldi xl,low(eeln5_speed)
call eeprom_read
sts ln5_speed,temp
call ln5r_txt_init
ret
load_ln6:
ldi yh,high(ln6_textch)
ldi yl,low(ln6_textch)
ldi xh,high(table_ln6txt)
ldi xl,low(table_ln6txt)
read_eeln6:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln6
st y,temp
ldi xh,high(eeln6_speed)
ldi xl,low(eeln6_speed)
call eeprom_read
sts ln6_speed,temp
call ln6_txt_init
ret
load_ln6r:
ldi yh,high(ln6_textch)
ldi yl,low(ln6_textch)
ldi xh,high(table_ln6txt)
ldi xl,low(table_ln6txt)
read_eeln6r:
call eeprom_read
adiw x,1
st y+,temp
cpi temp,0xff
brne read_eeln6r
st y,temp
ldi xh,high(eeln6_speed)
ldi xl,low(eeln6_speed)
call eeprom_read
sts ln6_speed,temp
call ln6r_txt_init
ret

load_mem2x32:
ldi zl,byte3(ascii_table16x32*2)
out RAMPZ,ZL
ldi zh,high(ascii_table16x32*2)
ldi zl,low(ascii_table16x32*2)
ldi temp4,96
search16x32_ch:
elpm temp,z
cp temp2,temp
breq ch16x32_found
adiw z,60
adiw z,6
dec temp4
tst temp4
brne search16x32_ch
ldi zl,byte3(ascii_tablex16*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex16*2)
ldi zl,low(ascii_tablex16*2)
ch16x32_found:
adiw z,1
clr temp
ln16x32_byte:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,64
brne ln16x32_byte
ret

load_mem2x32rev:
ldi zl,byte3(ascii_table16x32*2)
out RAMPZ,ZL
ldi zh,high(ascii_table16x32*2)
ldi zl,low(ascii_table16x32*2)
ldi temp4,96
search16x32_chr:
elpm temp,z
cp temp2,temp
breq ch16x32r_found
adiw z,60
adiw z,6
dec temp4
tst temp4
brne search16x32_chr
ldi zl,byte3(ascii_tablex16*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex16*2)
ldi zl,low(ascii_tablex16*2)
ch16x32r_found:
adiw z,1
clr temp
sbiw y,60
sbiw y,4
ln16x32_byter:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,64
brne ln16x32_byter
sbiw y,60
sbiw y,4
ret

load_mem3x48:
ldi zl,byte3(ascii_table24x48*2)
out RAMPZ,ZL
ldi zh,high(ascii_table24x48*2)
ldi zl,low(ascii_table24x48*2)
ldi temp4,96
search24x48_ch:
elpm temp,z
cp temp2,temp
breq ch24x48_found
adiw z,60
adiw z,60
adiw z,26
dec temp4
tst temp4
brne search24x48_ch
ldi zl,byte3(ascii_tablex16*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex16*2)
ldi zl,low(ascii_tablex16*2)
ch24x48_found:
adiw z,1
clr temp
ln24x48_byte:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,144
brne ln24x48_byte
ret

load_mem3x48rev:
ldi zl,byte3(ascii_table24x48*2)
out RAMPZ,ZL
ldi zh,high(ascii_table24x48*2)
ldi zl,low(ascii_table24x48*2)
ldi temp4,96
search24x48_chr:
elpm temp,z
cp temp2,temp
breq ch24x48_foundr
adiw z,60
adiw z,60
adiw z,26
dec temp4
tst temp4
brne search24x48_chr
ldi zl,byte3(ascii_tablex16*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex16*2)
ldi zl,low(ascii_tablex16*2)
ch24x48_foundr:
adiw z,1
clr temp
sbiw y,60
sbiw y,60
sbiw y,24
ln24x48_byter:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,144
brne ln24x48_byter
sbiw y,60
sbiw y,60
sbiw y,24
ret

ln24x48r_txt_init:
clr temp
sts ln1_cnt,temp
ldi yH,high(ln1_textch)
ldi yL,low(ln1_textch)
mov temph,yh
mov templ,yl
sch48:
ld temp,y+
cpi temp,0xff
brne sch48
sbiw y,1
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
ldchr48:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr48
ldi temp,0xff
st -x,temp
ldi yh,high(ln1_text+1024)
ldi yl,low(ln1_text+1024)
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
clr temp3
load_chrmem24x48r:
ld temp2,-x
call load_mem3x48rev
inc temp3
cpi temp3,7
breq chrmem_exit24x48r
jmp load_chrmem24x48r
chrmem_exit24x48r:
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret

ln24x48_txtr:
ldi yh,high(ln1_text+160)
ldi yl,low(ln1_text+160)
lds temp6,dsp_invreg
ldi temp,1
ln24x48_ploop1r:
sts max7291_adr,temp
call print_24x48b1r
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop1r
ldi temp,1
ln24x48_ploop2r:
sts max7291_adr,temp
call print_24x48b2r
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop2r
ldi temp,1
ln24x48_ploop3r:
sts max7291_adr,temp
call print_24x48b3r
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop3r
ldi temp,1
ln24x48_ploop4r:
sts max7291_adr,temp
call print_24x48b4r
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop4r
ldi temp,1
ln24x48_ploop5r:
sts max7291_adr,temp
call print_24x48b5r
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop5r
ldi temp,1
ln24x48_ploop6r:
sts max7291_adr,temp
call print_24x48b6r
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop6r
ldi yh,high(ln1_text+16)     ;6chr(3x48) bytes buffer length
ldi yl,low(ln1_text+16)
movw z,y
clr temp4
shift_sraml24x48r:
clr temp2
ldi temp3,7				; load 7 chars 3 x 48 bytes
sram_loop24x48r:
ld temp,y+     
ld temp5,y+
ld temp6,y
lsr temp2
ror temp
ror temp5
ror temp6
brcc caryclrlngr
ldi temp2,0x01
caryclrlngr:
st y,temp6
st -y,temp5
st -y,temp
adiw y,60
adiw y,60
adiw y,24
dec temp3   
tst temp3 
brne sram_loop24x48r
movw y,z
adiw y,3
movw z,y
inc temp4
cpi temp4,48				;take all 48 bytes from 1 char
brne shift_sraml24x48r
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,24					;shift left all 24 bits of data
breq ln24x48r_loadchr		;when buffer empty load next 6 chars
ret
ln24x48r_loadchr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+160)
ldi yl,low(ln1_text+160)
lds xl,ln16x32_ptr
lds xh,ln16x32_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln24x48r_reload
call load_mem3x48rev
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln24x48r_reload:
call ln24x48r_txt_init
ret
print_24x48b1r:
clr temp3
print24x48_loop1r:
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop1r
call ln1_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b2r:
clr temp3
print24x48_loop2r:
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop2r
call ln2_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b3r:
clr temp3
print24x48_loop3r:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop3r
call ln3_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b4r:
clr temp3
print24x48_loop4r:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop4r
call ln4_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b5r:
clr temp3
print24x48_loop5r:
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop5r
call ln5_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b6r:
clr temp3
print24x48_loop6r:
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop6r
call ln6_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
;-----------------------------------------------------------
ln24x48_txt_init:
clr temp
sts ln1_cnt,temp
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
ldi xH,high(ln1_textch)
ldi xL,low(ln1_textch)
clr temp3
load_chrmem24x48:
ld temp2,x+
call load_mem3x48
inc temp3
cpi temp3,7
breq chrmem_exit24x48
jmp load_chrmem24x48
chrmem_exit24x48:
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln24x48_txtl:
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
lds temp6,dsp_invreg
ldi temp,1
ln24x48_ploop1:
sts max7291_adr,temp
call print_24x48b1
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop1
ldi temp,1
ln24x48_ploop2:
sts max7291_adr,temp
call print_24x48b2
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop2
ldi temp,1
ln24x48_ploop3:
sts max7291_adr,temp
call print_24x48b3
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop3
ldi temp,1
ln24x48_ploop4:
sts max7291_adr,temp
call print_24x48b4
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop4
ldi temp,1
ln24x48_ploop5:
sts max7291_adr,temp
call print_24x48b5
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop5
ldi temp,1
ln24x48_ploop6:
sts max7291_adr,temp
call print_24x48b6
adiw y,3
inc temp
cpi temp,9
brne ln24x48_ploop6
ldi yh,high(ln1_text+864)     ;6chr(3x48) bytes buffer length
ldi yl,low(ln1_text+864)
movw z,y
clr temp4
shift_sraml24x48:
clr temp2
ldi temp3,7				; load 7 chars 3 x 48 bytes
sram_loop24x48:
ld temp,y+     
ld temp5,y+
ld temp6,y
lsl temp2
rol temp6
rol temp5
rol temp
brcc caryclrlng
ldi temp2,0x80
caryclrlng:
st y,temp6
st -y,temp5
st -y,temp
sbiw y,60
sbiw y,60
sbiw y,24
dec temp3   
tst temp3 
brne sram_loop24x48
movw y,z
adiw y,3
movw z,y
inc temp4
cpi temp4,48				;take all 48 bytes from 1 char
brne shift_sraml24x48
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,24					;shift left all 24 bits of data
breq ln24x48_loadchr		;when buffer empty load next 6 chars
ret
ln24x48_loadchr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+864)
ldi yl,low(ln1_text+864)
lds xl,ln16x32_ptr
lds xh,ln16x32_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln24x48_reload
call load_mem3x48
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln24x48_reload:
call ln24x48_txt_init
ret
print_24x48b1:
clr temp3
print24x48_loop1:
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop1
call ln1_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b2:
clr temp3
print24x48_loop2:
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop2
call ln2_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b3:
clr temp3
print24x48_loop3:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop3
call ln3_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b4:
clr temp3
print24x48_loop4:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop4
call ln4_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b5:
clr temp3
print24x48_loop5:
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop5
call ln5_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
print_24x48b6:
clr temp3
print24x48_loop6:
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,60
adiw y,22
inc temp3
cpi temp3,6
brne print24x48_loop6
call ln6_en
ldi templ,low(864)
ldi temph,high(864)
sub yl,templ
sbc yh,temph
ret
;-----------------------------------------------------------
ln16x32ur_txt_init:
clr temp
sts ln1_cnt,temp
ldi yH,high(ln1_textch)
ldi yL,low(ln1_textch)
mov temph,yh
mov templ,yl
sch32u:
ld temp,y+
cpi temp,0xff
brne sch32u
sbiw y,1
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
ldchr32u:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr32u
ldi temp,0xff
st -x,temp
ldi yh,high(ln1_text+1024)
ldi yl,low(ln1_text+1024)
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
clr temp3
load_chrmem16x32ur:
ld temp2,-x
call load_mem2x32rev
inc temp3
cpi temp3,9
breq chrmem_exit16x32ur
jmp load_chrmem16x32ur
chrmem_exit16x32ur:
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32u_txtr:
ldi yh,high(ln1_text+512)
ldi yl,low(ln1_text+512)
lds temp6,dsp_invreg
ldi temp,1
ln16x32u_ploop1r:
sts max7291_adr,temp
call print_u16x32b1r
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop1r
ldi temp,1
ln16x32u_ploop2r:
sts max7291_adr,temp
call print_u16x32b2r
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop2r
ldi temp,1
ln16x32u_ploop3r:
sts max7291_adr,temp
call print_u16x32b3r
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop3r
ldi temp,1
ln16x32u_ploop4r:
sts max7291_adr,temp
call print_u16x32b4r
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop4r
ldi yh,high(ln1_text+448)     ;8chr(2x32) bytes buffer length
ldi yl,low(ln1_text+448)
movw z,y
clr temp4
shift_sraml16x32ur:
clr temp2
ldi temp3,9				; load 9 chars 2 x 32 bytes
sram_loop16x32ur:
ld temp,y+     ;
ld temp5,y
lsr temp2
ror temp
ror temp5
brcc caryclrlnbur
ldi temp2,0x01
caryclrlnbur:
st y,temp5
st -y,temp
adiw y,60
adiw y,4
dec temp3   ;ln_textl
tst temp3 
brne sram_loop16x32ur
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,32				;take all 32 bytes from 1 char
brne shift_sraml16x32ur
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,16					;shift left all 16 bits of data
breq ln16x32ur_loadchr		;when buffer empty load next 5 chars
ret
ln16x32ur_loadchr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+512)
ldi yl,low(ln1_text+512)
lds xl,ln16x32_ptr
lds xh,ln16x32_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln16x32ur_reload
call load_mem2x32rev
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32ur_reload:
call ln16x32ur_txt_init
ret
print_u16x32b1r:
clr temp3
print16x32u_loop1r:
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop1r
call ln1_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_u16x32b2r:
clr temp3
print16x32u_loop2r:
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop2r
call ln2_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_u16x32b3r:
clr temp3
print16x32u_loop3r:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop3r
call ln3_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_u16x32b4r:
clr temp3
print16x32u_loop4r:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop4r
call ln4_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
;-----------------------------------------------------------
ln16x32u_txt_init:
clr temp
sts ln1_cnt,temp
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
ldi xH,high(ln1_textch)
ldi xL,low(ln1_textch)
clr temp3
load_chrmem16x32u:
ld temp2,x+
call load_mem2x32
inc temp3
cpi temp3,9
breq chrmem_exit16x32u
jmp load_chrmem16x32u
chrmem_exit16x32u:
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32u_txtl:
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
lds temp6,dsp_invreg
ldi temp,1
ln16x32u_ploop1:
sts max7291_adr,temp
call print_u16x32b1
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop1
ldi temp,1
ln16x32u_ploop2:
sts max7291_adr,temp
call print_u16x32b2
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop2
ldi temp,1
ln16x32u_ploop3:
sts max7291_adr,temp
call print_u16x32b3
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop3
ldi temp,1
ln16x32u_ploop4:
sts max7291_adr,temp
call print_u16x32b4
adiw y,2
inc temp
cpi temp,9
brne ln16x32u_ploop4
ldi yh,high(ln1_text+512)     ;8chr(2x32) bytes buffer length
ldi yl,low(ln1_text+512)
movw z,y
clr temp4
shift_sraml16x32u:
clr temp2
ldi temp3,9				; load 9 chars 2 x 32 bytes
sram_loop16x32u:
ld temp,y+     ;
ld temp5,y
lsl temp2
rol temp5
rol temp
brcc caryclrlnbu
ldi temp2,0x80
caryclrlnbu:
st y,temp5
st -y,temp
sbiw y,60
sbiw y,4
dec temp3   ;ln_textl
tst temp3 
brne sram_loop16x32u
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,32				;take all 32 bytes from 1 char
brne shift_sraml16x32u
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,16					;shift left all 16 bits of data
breq ln16x32u_loadchr		;when buffer empty load next 5 chars
ret
ln16x32u_loadchr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+512)
ldi yl,low(ln1_text+512)
lds xl,ln16x32_ptr
lds xh,ln16x32_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln16x32u_reload
call load_mem2x32
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32u_reload:
call ln16x32u_txt_init
ret
print_u16x32b1:
clr temp3
print16x32u_loop1:
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop1
call ln1_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_u16x32b2:
clr temp3
print16x32u_loop2:
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop2
call ln2_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_u16x32b3:
clr temp3
print16x32u_loop3:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop3
call ln3_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_u16x32b4:
clr temp3
print16x32u_loop4:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32u_loop4
call ln4_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
;-----------------------------------------------------------
ln16x32dr_txt_init:
clr temp
sts ln3_cnt,temp
ldi yH,high(ln3_textch)
ldi yL,low(ln3_textch)
mov temph,yh
mov templ,yl
sch32d:
ld temp,y+
cpi temp,0xff
brne sch32d
sbiw y,1
ldi xH,high(ln3_textrch+200)
ldi xL,low(ln3_textrch+200)
ldchr32d:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr32d
ldi temp,0xff
st -x,temp
ldi yh,high(ln3_text+1024)
ldi yl,low(ln3_text+1024)
ldi xH,high(ln3_textrch+200)
ldi xL,low(ln3_textrch+200)
clr temp3
load_chrmem16x32dr:
ld temp2,-x
call load_mem2x32rev
inc temp3
cpi temp3,9
breq chrmem_exit16x32dr
jmp load_chrmem16x32dr
chrmem_exit16x32dr:
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32d_txtr:
ldi yh,high(ln3_text+512)
ldi yl,low(ln3_text+512)
lds temp6,dsp_invreg
ldi temp,1
ln16x32d_ploop1r:
sts max7291_adr,temp
call print_d16x32b1r
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop1r
ldi temp,1
ln16x32d_ploop2r:
sts max7291_adr,temp
call print_d16x32b2r
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop2r
ldi temp,1
ln16x32d_ploop3r:
sts max7291_adr,temp
call print_d16x32b3r
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop3r
ldi temp,1
ln16x32d_ploop4r:
sts max7291_adr,temp
call print_d16x32b4r
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop4r
ldi yh,high(ln3_text+448)     ;8chr(2x32) bytes buffer length
ldi yl,low(ln3_text+448)
movw z,y
clr temp4
shift_sraml16x32dr:
clr temp2
ldi temp3,9				; load 9 chars 2 x 32 bytes
sram_loop16x32dr:
ld temp,y+     ;
ld temp5,y
lsr temp2
ror temp
ror temp5
brcc caryclrlnbdr
ldi temp2,0x01
caryclrlnbdr:
st y,temp5
st -y,temp
adiw y,60
adiw y,4
dec temp3   ;ln_textl
tst temp3 
brne sram_loop16x32dr
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,32				;take all 32 bytes from 1 char
brne shift_sraml16x32dr
lds temp,ln3_cnt
inc temp 
sts ln3_cnt,temp
cpi temp,16					;shift left all 16 bits of data
breq ln16x32dr_loadchr		;when buffer empty load next 5 chars
ret
ln16x32dr_loadchr:
clr temp 
sts ln3_cnt,temp
ldi yh,high(ln3_text+512)
ldi yl,low(ln3_text+512)
lds xl,ln16x32_ptr
lds xh,ln16x32_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln16x32dr_reload
call load_mem2x32rev
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32dr_reload:
call ln16x32dr_txt_init
ret
print_d16x32b1r:
clr temp3
print16x32d_loop1r:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32d_loop1r
call ln3_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_d16x32b2r:
clr temp3
print16x32d_loop2r:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32d_loop2r
call ln4_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_d16x32b3r:
clr temp3
print16x32d_loop3r:
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32d_loop3r
call ln5_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_d16x32b4r:
clr temp3
print16x32d_loop4r:
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,60
adiw y,3
inc temp3
cpi temp3,8
brne print16x32d_loop4r
call ln6_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
;-----------------------------------------------------------
ln16x32d_txt_init:
clr temp
sts ln3_cnt,temp
ldi yh,high(ln3_text)
ldi yl,low(ln3_text)
ldi xH,high(ln3_textch)
ldi xL,low(ln3_textch)
clr temp3
load_chrmem16x32d:
ld temp2,x+
call load_mem2x32
inc temp3
cpi temp3,9
breq chrmem_exit16x32d
jmp load_chrmem16x32d
chrmem_exit16x32d:
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32d_txtl:
ldi yh,high(ln3_text)
ldi yl,low(ln3_text)
lds temp6,dsp_invreg
ldi temp,1
ln16x32d_ploop1:
sts max7291_adr,temp
call print_d16x32b1
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop1
ldi temp,1
ln16x32d_ploop2:
sts max7291_adr,temp
call print_d16x32b2
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop2
ldi temp,1
ln16x32d_ploop3:
sts max7291_adr,temp
call print_d16x32b3
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop3
ldi temp,1
ln16x32d_ploop4:
sts max7291_adr,temp
call print_d16x32b4
adiw y,2
inc temp
cpi temp,9
brne ln16x32d_ploop4
ldi yh,high(ln3_text+512)     ;8chr(2x32) bytes buffer length
ldi yl,low(ln3_text+512)
movw z,y
clr temp4
shift_sraml16x32d:
clr temp2
ldi temp3,9				; load 9 chars 2 x 32 bytes
sram_loop16x32d:
ld temp,y+     ;
ld temp5,y
lsl temp2
rol temp5
rol temp
brcc caryclrlnbd
ldi temp2,0x80
caryclrlnbd:
st y,temp5
st -y,temp
sbiw y,60
sbiw y,4
dec temp3   ;ln_textl
tst temp3 
brne sram_loop16x32d
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,32				;take all 32 bytes from 1 char
brne shift_sraml16x32d
lds temp,ln3_cnt
inc temp 
sts ln3_cnt,temp
cpi temp,16					;shift left all 16 bits of data
breq ln16x32d_loadchr		;when buffer empty load next 5 chars
ret
ln16x32d_loadchr:
clr temp 
sts ln3_cnt,temp
ldi yh,high(ln3_text+512)
ldi yl,low(ln3_text+512)
lds xl,ln16x32_ptr
lds xh,ln16x32_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln16x32d_reload
call load_mem2x32
sts ln16x32_ptr,xl
sts ln16x32_ptr+1,xh
ret
ln16x32d_reload:
call ln16x32d_txt_init
ret
print_d16x32b1:
clr temp3
print16x32d_loop1:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,63
inc temp3
cpi temp3,8
brne print16x32d_loop1
call ln3_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_d16x32b2:
clr temp3
print16x32d_loop2:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,63
inc temp3
cpi temp3,8
brne print16x32d_loop2
call ln4_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_d16x32b3:
clr temp3
print16x32d_loop3:
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,63
inc temp3
cpi temp3,8
brne print16x32d_loop3
call ln5_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
print_d16x32b4:
clr temp3
print16x32d_loop4:
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,63
inc temp3
cpi temp3,8
brne print16x32d_loop4
call ln6_en
ldi templ,low(512)
ldi temph,high(512)
sub yl,templ
sbc yh,temph
ret
;--------------------------------------
lnu_txt_initr:
clr temp
sts ln1_cnt,temp
ldi yH,high(ln1_textch)
ldi yL,low(ln1_textch)
mov temph,yh
mov templ,yl
sch16u:
ld temp,y+
cpi temp,0xff
brne sch16u
sbiw y,1
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
ldchr16u:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr16u
ldi temp,0xff
st -x,temp
ldi yh,high(ln1_text+1024)
ldi yl,low(ln1_text+1024)
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
clr temp3
load_chrmem16ur:
ld temp2,-x
call load_mem2x16rev
inc temp3
cpi temp3,9
breq chrmem_exit16ur
jmp load_chrmem16ur
chrmem_exit16ur:
sts lnu_ptr,xl
sts lnu_ptr+1,xh
ret
lnu_txtr:
ldi yh,high(ln1_text+768)
ldi yl,low(ln1_text+768)
lds temp6,dsp_invreg
ldi temp,1
lnur_ploop1:
sts max7291_adr,temp
call printur_16b1
adiw y,2
inc temp
cpi temp,9
brne lnur_ploop1
ldi temp,1
lnur_ploop2:
sts max7291_adr,temp
call printur_16b2
adiw y,2
inc temp
cpi temp,9
brne lnur_ploop2
ldi yh,high(ln1_text+736) ;8chr(2x16)
ldi yl,low(ln1_text+736)
movw z,y					;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
clr temp4
shift_sramlur:
clr temp2
ldi temp3,9
sram_loopur:
ld temp,y+     ;
ld temp5,y
lsr temp2
ror temp
ror temp5
brcc caryclrlnur
ldi temp2,0x01
caryclrlnur:
st y,temp5
st -y,temp
adiw y,32
dec temp3   ;ln_textl
tst temp3 
brne sram_loopur
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,16
brne shift_sramlur
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,16
breq lnur_load_chr
ret
lnur_load_chr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+768)
ldi yl,low(ln1_text+768)
lds xl,lnu_ptr
lds xh,lnu_ptr+1
ld temp2,-x
cpi temp2,0xff
breq lnur_reload
call load_mem2x16rev
sts lnu_ptr,xl
sts lnu_ptr+1,xh
ret
lnur_reload:
call lnu_txt_initr
ret
printur_16b1:
clr temp3
printur_loop1:
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printur_loop1
call ln1_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
printur_16b2:
clr temp3
printur_loop2:
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printur_loop2
call ln2_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
;--------------------------------------
lnu_txt_init:
clr temp
sts ln1_cnt,temp
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
ldi xH,high(ln1_textch)
ldi xL,low(ln1_textch)
clr temp3
load_ichrmemlnu:
ld temp2,x+
call load_mem2x16
inc temp3
cpi temp3,9
breq chrmem_iexitlnu
jmp load_ichrmemlnu
chrmem_iexitlnu:
sts lnu_ptr,xl
sts lnu_ptr+1,xh
ret
lnu_txtl:
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
lds temp6,dsp_invreg
ldi temp,1
lnu_ploop1:
sts max7291_adr,temp
call printu_16b1
adiw y,2
inc temp
cpi temp,9
brne lnu_ploop1
ldi temp,1
lnu_ploop2:
sts max7291_adr,temp
call printu_16b2
adiw y,2
inc temp
cpi temp,9
brne lnu_ploop2
ldi yh,high(ln1_text+256) ;8chr(2x16)
ldi yl,low(ln1_text+256)
movw z,y
clr temp4
shift_sramlu:
clr temp2
ldi temp3,9
sram_loopu:
ld temp,y+     ;
ld temp5,y
lsl temp2
rol temp5
rol temp
brcc caryclrlnu
ldi temp2,0x80
caryclrlnu:
st y,temp5
st -y,temp
sbiw y,32
dec temp3   ;ln_textl
tst temp3 
brne sram_loopu
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,16
brne shift_sramlu
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,16
breq lnu_load_chr
ret
lnu_load_chr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+256)
ldi yl,low(ln1_text+256)
lds xl,lnu_ptr
lds xh,lnu_ptr+1
ld temp2,x+
cpi temp2,0xff
breq lnu_reload
call load_mem2x16
sts lnu_ptr,xl
sts lnu_ptr+1,xh
ret
lnu_reload:
call lnu_txt_init
ret
printu_16b1:
clr temp3
printu_loop1:
ld temp2,y+
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printu_loop1
call ln1_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
printu_16b2:
clr temp3
printu_loop2:
ld temp2,y+
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printu_loop2
call ln2_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
;--------------------------------------
lnm_txt_initr:
clr temp
sts ln3_cnt,temp
ldi yH,high(ln3_textch)
ldi yL,low(ln3_textch)
mov temph,yh
mov templ,yl
sch16m:
ld temp,y+
cpi temp,0xff
brne sch16m
sbiw y,1
ldi xH,high(ln3_textrch+200)
ldi xL,low(ln3_textrch+200)
ldchr16m:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr16m
ldi temp,0xff
st -x,temp
ldi yh,high(ln3_text+1024)
ldi yl,low(ln3_text+1024)
ldi xH,high(ln3_textrch+200)
ldi xL,low(ln3_textrch+200)
clr temp3
load_chrmem16mr:
ld temp2,-x
call load_mem2x16rev
inc temp3
cpi temp3,9
breq chrmem_exit16mr
jmp load_chrmem16mr
chrmem_exit16mr:
sts lnm_ptr,xl
sts lnm_ptr+1,xh
ret
lnm_txtr:
ldi yh,high(ln3_text+768)
ldi yl,low(ln3_text+768)
lds temp6,dsp_invreg
ldi temp,1
lnmr_ploop1:
sts max7291_adr,temp
call printmr_16b1
adiw y,2
inc temp
cpi temp,9
brne lnmr_ploop1
ldi temp,1
lnmr_ploop2:
sts max7291_adr,temp
call printmr_16b2
adiw y,2
inc temp
cpi temp,9
brne lnmr_ploop2
ldi yh,high(ln3_text+736) ;8chr(2x16)
ldi yl,low(ln3_text+736)
movw z,y					;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
clr temp4
shift_sramlmr:
clr temp2
ldi temp3,9
sram_loopmr:
ld temp,y+     ;
ld temp5,y
lsr temp2
ror temp
ror temp5
brcc caryclrlnmr
ldi temp2,0x01
caryclrlnmr:
st y,temp5
st -y,temp
adiw y,32
dec temp3   ;ln_textl
tst temp3 
brne sram_loopmr
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,16
brne shift_sramlmr
lds temp,ln3_cnt
inc temp 
sts ln3_cnt,temp
cpi temp,16
breq lnmr_load_chr
ret
lnmr_load_chr:
clr temp 
sts ln3_cnt,temp
ldi yh,high(ln3_text+768)
ldi yl,low(ln3_text+768)
lds xl,lnm_ptr
lds xh,lnm_ptr+1
ld temp2,-x
cpi temp2,0xff
breq lnmr_reload
call load_mem2x16rev
sts lnm_ptr,xl
sts lnm_ptr+1,xh
ret
lnmr_reload:
call lnm_txt_initr
ret
printmr_16b1:
clr temp3
printmr_loop1:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printmr_loop1
call ln3_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
printmr_16b2:
clr temp3
printmr_loop2:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printmr_loop2
call ln4_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
;--------------------------------------
lnm_txt_init:
clr temp
sts ln3_cnt,temp
ldi yh,high(ln3_text)
ldi yl,low(ln3_text)
ldi xH,high(ln3_textch)
ldi xL,low(ln3_textch)
clr temp3
load_ichrmemlnm:
ld temp2,x+
call load_mem2x16
inc temp3
cpi temp3,9
breq chrmem_iexitlnm
jmp load_ichrmemlnm
chrmem_iexitlnm:
sts lnm_ptr,xl
sts lnm_ptr+1,xh
ret
lnm_txtl:
ldi yh,high(ln3_text)
ldi yl,low(ln3_text)
lds temp6,dsp_invreg
ldi temp,1
lnm_ploop1:
sts max7291_adr,temp
call printm_16b1
adiw y,2
inc temp
cpi temp,9
brne lnm_ploop1
ldi temp,1
lnm_ploop2:
sts max7291_adr,temp
call printm_16b2
adiw y,2
inc temp
cpi temp,9
brne lnm_ploop2
ldi yh,high(ln3_text+256) ;8chr(2x16)
ldi yl,low(ln3_text+256)
movw z,y
clr temp4
shift_sramlm:
clr temp2
ldi temp3,9
sram_loopm:
ld temp,y+     ;
ld temp5,y
lsl temp2
rol temp5
rol temp
brcc caryclrlnm
ldi temp2,0x80
caryclrlnm:
st y,temp5
st -y,temp
sbiw y,32
dec temp3   ;ln_textl
tst temp3 
brne sram_loopm
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,16
brne shift_sramlm
lds temp,ln3_cnt
inc temp 
sts ln3_cnt,temp
cpi temp,16
breq lnm_load_chr
ret
lnm_load_chr:
clr temp 
sts ln3_cnt,temp
ldi yh,high(ln3_text+256)
ldi yl,low(ln3_text+256)
lds xl,lnm_ptr
lds xh,lnm_ptr+1
ld temp2,x+
cpi temp2,0xff
breq lnm_reload
call load_mem2x16
sts lnm_ptr,xl
sts lnm_ptr+1,xh
ret
lnm_reload:
call lnm_txt_init
ret
printm_16b1:
clr temp3
printm_loop1:
ld temp2,y+
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printm_loop1
call ln3_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
printm_16b2:
clr temp3
printm_loop2:
ld temp2,y+
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printm_loop2
call ln4_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
;-------------------------------------------------
lnd_txt_initr:
clr temp
sts ln5_cnt,temp
ldi yH,high(ln5_textch)
ldi yL,low(ln5_textch)
mov temph,yh
mov templ,yl
sch16d:
ld temp,y+
cpi temp,0xff
brne sch16d
sbiw y,1
ldi xH,high(ln5_textrch+200)
ldi xL,low(ln5_textrch+200)
ldchr16d:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr16d
ldi temp,0xff
st -x,temp
ldi yh,high(ln5_text+1024)
ldi yl,low(ln5_text+1024)
ldi xH,high(ln5_textrch+200)
ldi xL,low(ln5_textrch+200)
clr temp3
load_chrmem16dr:
ld temp2,-x
call load_mem2x16rev
inc temp3
cpi temp3,9
breq chrmem_exit16dr
jmp load_chrmem16dr
chrmem_exit16dr:
sts lnd_ptr,xl
sts lnd_ptr+1,xh
ret
lnd_txtr:
ldi yh,high(ln5_text+768)
ldi yl,low(ln5_text+768)
lds temp6,dsp_invreg
ldi temp,1
lndr_ploop1:
sts max7291_adr,temp
call printdr_16b1
adiw y,2
inc temp
cpi temp,9
brne lndr_ploop1
ldi temp,1
lndr_ploop2:
sts max7291_adr,temp
call printdr_16b2
adiw y,2
inc temp
cpi temp,9
brne lndr_ploop2
ldi yh,high(ln5_text+736) ;8chr(2x16)
ldi yl,low(ln5_text+736)
movw z,y					;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
clr temp4
shift_sramldr:
clr temp2
ldi temp3,9
sram_loopdr:
ld temp,y+     ;
ld temp5,y
lsr temp2
ror temp
ror temp5
brcc caryclrlndr
ldi temp2,0x01
caryclrlndr:
st y,temp5
st -y,temp
adiw y,32
dec temp3   ;ln_textl
tst temp3 
brne sram_loopdr
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,16
brne shift_sramldr
lds temp,ln5_cnt
inc temp 
sts ln5_cnt,temp
cpi temp,16
breq lndr_load_chr
ret
lndr_load_chr:
clr temp 
sts ln5_cnt,temp
ldi yh,high(ln5_text+768)
ldi yl,low(ln5_text+768)
lds xl,lnd_ptr
lds xh,lnd_ptr+1
ld temp2,-x
cpi temp2,0xff
breq lndr_reload
call load_mem2x16rev
sts lnd_ptr,xl
sts lnd_ptr+1,xh
ret
lndr_reload:
call lnd_txt_initr
ret
printdr_16b1:
clr temp3
printdr_loop1:
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printdr_loop1
call ln5_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
printdr_16b2:
clr temp3
printdr_loop2:
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printdr_loop2
call ln6_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
;--------------------------------------
lnd_txt_init:
clr temp
sts ln5_cnt,temp
ldi yh,high(ln5_text)
ldi yl,low(ln5_text)
ldi xH,high(ln5_textch)
ldi xL,low(ln5_textch)
clr temp3
load_ichrmemlnd:
ld temp2,x+
call load_mem2x16
inc temp3
cpi temp3,9
breq chrmem_iexitlnd
jmp load_ichrmemlnd
chrmem_iexitlnd:
sts lnd_ptr,xl
sts lnd_ptr+1,xh
ret
lnd_txtl:
ldi yh,high(ln5_text)
ldi yl,low(ln5_text)
lds temp6,dsp_invreg
ldi temp,1
lnd_ploop1:
sts max7291_adr,temp
call printd_16b1
adiw y,2
inc temp
cpi temp,9
brne lnd_ploop1
ldi temp,1
lnd_ploop2:
sts max7291_adr,temp
call printd_16b2
adiw y,2
inc temp
cpi temp,9
brne lnd_ploop2
ldi yh,high(ln5_text+256)
ldi yl,low(ln5_text+256)
movw z,y
clr temp4
shift_sramld:
clr temp2
ldi temp3,9
sram_loopd:
ld temp,y+     ;
ld temp5,y
lsl temp2
rol temp5
rol temp
brcc caryclrlnd
ldi temp2,0x80
caryclrlnd:
st y,temp5
st -y,temp
sbiw y,32
dec temp3   ;ln_textl
tst temp3 
brne sram_loopd
movw y,z
adiw y,2
movw z,y
inc temp4
cpi temp4,16
brne shift_sramld
lds temp,ln5_cnt
inc temp 
sts ln5_cnt,temp
cpi temp,16
breq lnd_load_chr
ret
lnd_load_chr:
clr temp 
sts ln5_cnt,temp
ldi yh,high(ln5_text+256)
ldi yl,low(ln5_text+256)
lds xl,lnd_ptr
lds xh,lnd_ptr+1
ld temp2,x+
cpi temp2,0xff
breq lnd_reload
call load_mem2x16
sts lnd_ptr,xl
sts lnd_ptr+1,xh
ret
lnd_reload:
call lnd_txt_init
ret
printd_16b1:
clr temp3
printd_loop1:
ld temp2,y+
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printd_loop1
call ln5_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret
printd_16b2:
clr temp3
printd_loop2:
ld temp2,y+
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
sbrc temp6,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printd_loop2
call ln6_en
ldi templ,low(256)
ldi temph,high(256)
sub yl,templ
sbc yh,temph
ret

load_mem2x16:
ldi zl,byte3(ascii_table16*2)
out RAMPZ,ZL
ldi zh,high(ascii_table16*2)
ldi zl,low(ascii_table16*2)
ldi temp4,96
searchd_ch:
elpm temp,z
cp temp2,temp
breq chd_found
adiw z,34
dec temp4
tst temp4
brne searchd_ch
ldi zl,byte3(ascii_tablex16*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex16*2)
ldi zl,low(ascii_tablex16*2)
chd_found:
adiw z,1
clr temp
ld_byte:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,32
brne ld_byte
ret

load_mem2x16rev:
ldi zl,byte3(ascii_table16*2)
out RAMPZ,ZL
ldi zh,high(ascii_table16*2)
ldi zl,low(ascii_table16*2)
ldi temp4,96
searchd_chr:
elpm temp,z
cp temp2,temp
breq chd_foundr
adiw z,34
dec temp4
tst temp4
brne searchd_chr
ldi zl,byte3(ascii_tablex16*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex16*2)
ldi zl,low(ascii_tablex16*2)
chd_foundr:
adiw z,1
sbiw y,32
clr temp
ld_byter:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,32
brne ld_byter
sbiw y,32
ret

ln1_txtl:
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
lds temp5,dsp_invreg
ldi temp,1
ln1_ploop1:
sts max7291_adr,temp
call print1_16b
adiw y,1
inc temp
cpi temp,9
brne ln1_ploop1
ldi yh,high(ln1_text+128)
ldi yl,low(ln1_text+128)
movw z,y
clr temp4
shift_sraml1:
clr temp2
ldi temp3,17
sram_loop1:
ld temp,y    ;
lsl temp2
rol temp
brcc caryclr1
ldi temp2,0x80
caryclr1:
st y,temp
sbiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop1
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml1
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,8
breq ln1_load_chr
ret
ln1_load_chr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+128)
ldi yl,low(ln1_text+128)
lds xl,ln1_ptr
lds xh,ln1_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln1_reload
call load_mem8x8
sts ln1_ptr,xl
sts ln1_ptr+1,xh
ret
ln1_reload:
call ln1_txt_init
ret
print1_16b:
clr temp3
print1_loop:
ld temp2,y
sbrc temp5,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print1_loop
call ln1_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln1_txt_init:
clr temp
sts ln1_cnt,temp
ldi yh,high(ln1_text)
ldi yl,low(ln1_text)
ldi xH,high(ln1_textch)
ldi xL,low(ln1_textch)
clr temp3
load_chrmem1:
ld temp2,x+
call load_mem8x8
inc temp3
cpi temp3,17
breq chrmem_exit1
jmp load_chrmem1
chrmem_exit1:
sts ln1_ptr,xl
sts ln1_ptr+1,xh
ret

ln2_txtl:
ldi yh,high(ln2_text)
ldi yl,low(ln2_text)
lds temp5,dsp_invreg
ldi temp,1
ln2_ploop1:
sts max7291_adr,temp
call print2_16b
adiw y,1
inc temp
cpi temp,9
brne ln2_ploop1
ldi yh,high(ln2_text+128)
ldi yl,low(ln2_text+128)
movw z,y
clr temp4
shift_sraml2:
clr temp2
ldi temp3,17
sram_loop2:
ld temp,y    ;
lsl temp2
rol temp
brcc caryclr2
ldi temp2,0x80
caryclr2:
st y,temp
sbiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop2
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml2
lds temp,ln2_cnt
inc temp 
sts ln2_cnt,temp
cpi temp,8
breq ln2_load_chr
ret
ln2_load_chr:
clr temp 
sts ln2_cnt,temp
ldi yh,high(ln2_text+128)
ldi yl,low(ln2_text+128)
lds xl,ln2_ptr
lds xh,ln2_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln2_reload
call load_mem8x8
sts ln2_ptr,xl
sts ln2_ptr+1,xh
ret
ln2_reload:
call ln2_txt_init
ret
print2_16b:
clr temp3
print2_loop:
ld temp2,y
sbrc temp5,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print2_loop
call ln2_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln2_txt_init:
clr temp
sts ln2_cnt,temp
ldi yh,high(ln2_text)
ldi yl,low(ln2_text)
ldi xH,high(ln2_textch)
ldi xL,low(ln2_textch)
clr temp3
load_chrmem2:
ld temp2,x+
call load_mem8x8
inc temp3
cpi temp3,17
breq chrmem_exit2
jmp load_chrmem2
chrmem_exit2:
sts ln2_ptr,xl
sts ln2_ptr+1,xh
ret

ln3_txtl:
ldi yh,high(ln3_text)
ldi yl,low(ln3_text)
lds temp5,dsp_invreg
ldi temp,1
ln3_ploop1:
sts max7291_adr,temp
call print3_16b
adiw y,1
inc temp
cpi temp,9
brne ln3_ploop1
ldi yh,high(ln3_text+128)
ldi yl,low(ln3_text+128)
movw z,y
clr temp4
shift_sraml3:
clr temp2
ldi temp3,17
sram_loop3:
ld temp,y    ;
lsl temp2
rol temp
brcc caryclr3
ldi temp2,0x80
caryclr3:
st y,temp
sbiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop3
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml3
lds temp,ln3_cnt
inc temp 
sts ln3_cnt,temp
cpi temp,8
breq ln3_load_chr
ret
ln3_load_chr:
clr temp 
sts ln3_cnt,temp
ldi yh,high(ln3_text+128)
ldi yl,low(ln3_text+128)
lds xl,ln3_ptr
lds xh,ln3_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln3_reload
call load_mem8x8
sts ln3_ptr,xl
sts ln3_ptr+1,xh
ret
ln3_reload:
call ln3_txt_init
ret
print3_16b:
clr temp3
print3_loop:
ld temp2,y
sbrc temp5,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print3_loop
call ln3_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln3_txt_init:
clr temp
sts ln3_cnt,temp
ldi yh,high(ln3_text)
ldi yl,low(ln3_text)
ldi xH,high(ln3_textch)
ldi xL,low(ln3_textch)
clr temp3
load_chrmem3:
ld temp2,x+
call load_mem8x8
inc temp3
cpi temp3,17
breq chrmem_exit3
jmp load_chrmem3
chrmem_exit3:
sts ln3_ptr,xl
sts ln3_ptr+1,xh
ret

ln4_txtl:
ldi yh,high(ln4_text)
ldi yl,low(ln4_text)
lds temp5,dsp_invreg
ldi temp,1
ln4_ploop1:
sts max7291_adr,temp
call print4_16b
adiw y,1
inc temp
cpi temp,9
brne ln4_ploop1
ldi yh,high(ln4_text+128)
ldi yl,low(ln4_text+128)
movw z,y
clr temp4
shift_sraml4:
clr temp2
ldi temp3,17
sram_loop4:
ld temp,y    ;
lsl temp2
rol temp
brcc caryclr4
ldi temp2,0x80
caryclr4:
st y,temp
sbiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop4
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml4
lds temp,ln4_cnt
inc temp 
sts ln4_cnt,temp
cpi temp,8
breq ln4_load_chr
ret
ln4_load_chr:
clr temp 
sts ln4_cnt,temp
ldi yh,high(ln4_text+128)
ldi yl,low(ln4_text+128)
lds xl,ln4_ptr
lds xh,ln4_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln4_reload
call load_mem8x8
sts ln4_ptr,xl
sts ln4_ptr+1,xh
ret
ln4_reload:
call ln4_txt_init
ret
print4_16b:
clr temp3
print4_loop:
ld temp2,y
sbrc temp5,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print4_loop
call ln4_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln4_txt_init:
clr temp
sts ln4_cnt,temp
ldi yh,high(ln4_text)
ldi yl,low(ln4_text)
ldi xH,high(ln4_textch)
ldi xL,low(ln4_textch)
clr temp3
load_chrmem4:
ld temp2,x+
call load_mem8x8
inc temp3
cpi temp3,17
breq chrmem_exit4
jmp load_chrmem4
chrmem_exit4:
sts ln4_ptr,xl
sts ln4_ptr+1,xh
ret

ln5_txtl:
ldi yh,high(ln5_text)
ldi yl,low(ln5_text)
lds temp5,dsp_invreg
ldi temp,1
ln5_ploop:
sts max7291_adr,temp
call print5_16b
adiw y,1
inc temp
cpi temp,9
brne ln5_ploop
ldi yh,high(ln5_text+128)
ldi yl,low(ln5_text+128)
movw z,y
clr temp4
shift_sraml5:
clr temp2
ldi temp3,17
sram_loop5:
ld temp,y    ;
lsl temp2
rol temp
brcc caryclr5
ldi temp2,0x80
caryclr5:
st y,temp
sbiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop5
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml5
lds temp,ln5_cnt
inc temp 
sts ln5_cnt,temp
cpi temp,8
breq ln5_load_chr
ret
ln5_load_chr:
clr temp 
sts ln5_cnt,temp
ldi yh,high(ln5_text+128)
ldi yl,low(ln5_text+128)
lds xl,ln5_ptr
lds xh,ln5_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln5_reload
call load_mem8x8
sts ln5_ptr,xl
sts ln5_ptr+1,xh
ret
ln5_reload:
call ln5_txt_init
ret
print5_16b:
clr temp3
print5_loop:
ld temp2,y
sbrc temp5,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print5_loop
call ln5_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln5_txt_init:
clr temp
sts ln5_cnt,temp
ldi yh,high(ln5_text)
ldi yl,low(ln5_text)
ldi xH,high(ln5_textch)
ldi xL,low(ln5_textch)
clr temp3
load_chrmem5:
ld temp2,x+
call load_mem8x8
inc temp3
cpi temp3,17
breq chrmem_exit5
jmp load_chrmem5
chrmem_exit5:
sts ln5_ptr,xl
sts ln5_ptr+1,xh
ret

ln6_txtl:
ldi yh,high(ln6_text)
ldi yl,low(ln6_text)
lds temp5,dsp_invreg
ldi temp,1
ln6_ploop:
sts max7291_adr,temp
call print6_16b
adiw y,1
inc temp
cpi temp,9
brne ln6_ploop
ldi yh,high(ln6_text+128)
ldi yl,low(ln6_text+128)
movw z,y
clr temp4
shift_sraml6:
clr temp2
ldi temp3,17
sram_loop6:
ld temp,y    ;
lsl temp2
rol temp
brcc caryclr6
ldi temp2,0x80
caryclr6:
st y,temp
sbiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop6
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml6
lds temp,ln6_cnt
inc temp 
sts ln6_cnt,temp
cpi temp,8
breq ln6_load_chr
ret
ln6_load_chr:
clr temp 
sts ln6_cnt,temp
ldi yh,high(ln6_text+128)
ldi yl,low(ln6_text+128)
lds xl,ln6_ptr
lds xh,ln6_ptr+1
ld temp2,x+
cpi temp2,0xff
breq ln6_reload
call load_mem8x8
sts ln6_ptr,xl
sts ln6_ptr+1,xh
ret
ln6_reload:
call ln6_txt_init
ret
print6_16b:
clr temp3
print6_loop:
ld temp2,y
sbrc temp5,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print6_loop
call ln6_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln6_txt_init:
clr temp
sts ln6_cnt,temp
ldi yh,high(ln6_text)
ldi yl,low(ln6_text)
ldi xH,high(ln6_textch)
ldi xL,low(ln6_textch)
clr temp3
load_chrmem6:
ld temp2,x+
call load_mem8x8
inc temp3
cpi temp3,17
breq chrmem_exit6
jmp load_chrmem6
chrmem_exit6:
sts ln6_ptr,xl
sts ln6_ptr+1,xh
ret

ln1_txtr:
ldi yh,high(ln1_text+896)
ldi yl,low(ln1_text+896)
lds temp5,dsp_invreg
ldi temp,1
ln1r_ploop1:
sts max7291_adr,temp
call print1_16br
adiw y,1
inc temp
cpi temp,9
brne ln1r_ploop1
ldi yh,high(ln1_text+888)
ldi yl,low(ln1_text+888)
movw z,y
clr temp4
shift_sraml1r:
clr temp2
ldi temp3,17
sram_loop1r:
ld temp,y    ;
lsr temp2
ror temp
brcc caryclr1r
ldi temp2,0x01
caryclr1r:
st y,temp
adiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop1r
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml1r
lds temp,ln1_cnt
inc temp 
sts ln1_cnt,temp
cpi temp,8
breq ln1r_load_chr
ret
ln1r_load_chr:
clr temp 
sts ln1_cnt,temp
ldi yh,high(ln1_text+896)
ldi yl,low(ln1_text+896)
lds xl,ln1_ptr
lds xh,ln1_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln1r_reload
call load_mem8x8rev
sts ln1_ptr,xl
sts ln1_ptr+1,xh
ret
ln1r_reload:
call ln1r_txt_init
ret
print1_16br:
clr temp3
print1_loopr:
ld temp2,y
sbrc temp5,ln1_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print1_loopr
call ln1_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln1r_txt_init:
ldi yH,high(ln1_textch)
ldi yL,low(ln1_textch)
mov temph,yh
mov templ,yl
sch1:
ld temp,y+
cpi temp,0xff
brne sch1
sbiw y,1
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
ldchr1:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr1
ldi temp,0xff
st -x,temp
clr temp
sts ln1_cnt,temp
ldi yh,high(ln1_text+1024)
ldi yl,low(ln1_text+1024)
ldi xH,high(ln1_textrch+200)
ldi xL,low(ln1_textrch+200)
clr temp3
load_chrmem1r:
ld temp2,-x
call load_mem8x8rev
inc temp3
cpi temp3,17
breq chrmem_exit1r
jmp load_chrmem1r
chrmem_exit1r:
sts ln1_ptr,xl
sts ln1_ptr+1,xh
ret

ln2_txtr:
ldi yh,high(ln2_text+896)
ldi yl,low(ln2_text+896)
lds temp5,dsp_invreg
ldi temp,1
ln2r_ploop1:
sts max7291_adr,temp
call print2_16br
adiw y,1
inc temp
cpi temp,9
brne ln2r_ploop1
ldi yh,high(ln2_text+888)
ldi yl,low(ln2_text+888)
movw z,y
clr temp4
shift_sraml2r:
clr temp2
ldi temp3,17
sram_loop2r:
ld temp,y    ;
lsr temp2
ror temp
brcc caryclr2r
ldi temp2,0x01
caryclr2r:
st y,temp
adiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop2r
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml2r
lds temp,ln2_cnt
inc temp 
sts ln2_cnt,temp
cpi temp,8
breq ln2r_load_chr
ret
ln2r_load_chr:
clr temp 
sts ln2_cnt,temp
ldi yh,high(ln2_text+896)
ldi yl,low(ln2_text+896)
lds xl,ln2_ptr
lds xh,ln2_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln2r_reload
call load_mem8x8rev
sts ln2_ptr,xl
sts ln2_ptr+1,xh
ret
ln2r_reload:
call ln2r_txt_init
ret
print2_16br:
clr temp3
print2_loopr:
ld temp2,y
sbrc temp5,ln2_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print2_loopr
call ln2_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln2r_txt_init:
ldi yH,high(ln2_textch)
ldi yL,low(ln2_textch)
mov temph,yh
mov templ,yl
sch2:
ld temp,y+
cpi temp,0xff
brne sch2
sbiw y,1
ldi xH,high(ln2_textrch+200)
ldi xL,low(ln2_textrch+200)
ldchr2:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr2
ldi temp,0xff
st -x,temp
clr temp
sts ln2_cnt,temp
ldi yh,high(ln2_text+1024)
ldi yl,low(ln2_text+1024)
ldi xH,high(ln2_textrch+200)
ldi xL,low(ln2_textrch+200)
clr temp3
load_chrmem2r:
ld temp2,-x
call load_mem8x8rev
inc temp3
cpi temp3,17
breq chrmem_exit2r
jmp load_chrmem2r
chrmem_exit2r:
sts ln2_ptr,xl
sts ln2_ptr+1,xh
ret

ln3_txtr:
ldi yh,high(ln3_text+896)
ldi yl,low(ln3_text+896)
lds temp5,dsp_invreg
ldi temp,1
ln3r_ploop1:
sts max7291_adr,temp
call print3_16br
adiw y,1
inc temp
cpi temp,9
brne ln3r_ploop1
ldi yh,high(ln3_text+888)
ldi yl,low(ln3_text+888)
movw z,y
clr temp4
shift_sraml3r:
clr temp2
ldi temp3,17
sram_loop3r:
ld temp,y    ;
lsr temp2
ror temp
brcc caryclr3r
ldi temp2,0x01
caryclr3r:
st y,temp
adiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop3r
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml3r
lds temp,ln3_cnt
inc temp 
sts ln3_cnt,temp
cpi temp,8
breq ln3r_load_chr
ret
ln3r_load_chr:
clr temp 
sts ln3_cnt,temp
ldi yh,high(ln3_text+896)
ldi yl,low(ln3_text+896)
lds xl,ln3_ptr
lds xh,ln3_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln3r_reload
call load_mem8x8rev
sts ln3_ptr,xl
sts ln3_ptr+1,xh
ret
ln3r_reload:
call ln3r_txt_init
ret
print3_16br:
clr temp3
print3_loopr:
ld temp2,y
sbrc temp5,ln3_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print3_loopr
call ln3_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln3r_txt_init:
ldi yH,high(ln3_textch)
ldi yL,low(ln3_textch)
mov temph,yh
mov templ,yl
sch3:
ld temp,y+
cpi temp,0xff
brne sch3
sbiw y,1
ldi xH,high(ln3_textrch+200)
ldi xL,low(ln3_textrch+200)
ldchr3:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr3
ldi temp,0xff
st -x,temp
clr temp
sts ln3_cnt,temp
ldi yh,high(ln3_text+1024)
ldi yl,low(ln3_text+1024)
ldi xH,high(ln3_textrch+200)
ldi xL,low(ln3_textrch+200)
clr temp3
load_chrmem3r:
ld temp2,-x
call load_mem8x8rev
inc temp3
cpi temp3,17
breq chrmem_exit3r
jmp load_chrmem3r
chrmem_exit3r:
sts ln3_ptr,xl
sts ln3_ptr+1,xh
ret

ln4_txtr:
ldi yh,high(ln4_text+896)
ldi yl,low(ln4_text+896)
lds temp5,dsp_invreg
ldi temp,1
ln4r_ploop1:
sts max7291_adr,temp
call print4_16br
adiw y,1
inc temp
cpi temp,9
brne ln4r_ploop1
ldi yh,high(ln4_text+888)
ldi yl,low(ln4_text+888)
movw z,y
clr temp4
shift_sraml4r:
clr temp2
ldi temp3,17
sram_loop4r:
ld temp,y    ;
lsr temp2
ror temp
brcc caryclr4r
ldi temp2,0x01
caryclr4r:
st y,temp
adiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop4r
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml4r
lds temp,ln4_cnt
inc temp 
sts ln4_cnt,temp
cpi temp,8
breq ln4r_load_chr
ret
ln4r_load_chr:
clr temp 
sts ln4_cnt,temp
ldi yh,high(ln4_text+896)
ldi yl,low(ln4_text+896)
lds xl,ln4_ptr
lds xh,ln4_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln4r_reload
call load_mem8x8rev
sts ln4_ptr,xl
sts ln4_ptr+1,xh
ret
ln4r_reload:
call ln4r_txt_init
ret
print4_16br:
clr temp3
print4_loopr:
ld temp2,y
sbrc temp5,ln4_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print4_loopr
call ln4_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln4r_txt_init:
ldi yH,high(ln4_textch)
ldi yL,low(ln4_textch)
mov temph,yh
mov templ,yl
sch4:
ld temp,y+
cpi temp,0xff
brne sch4
sbiw y,1
ldi xH,high(ln4_textrch+200)
ldi xL,low(ln4_textrch+200)
ldchr4:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr4
ldi temp,0xff
st -x,temp
clr temp
sts ln4_cnt,temp
ldi yh,high(ln4_text+1024)
ldi yl,low(ln4_text+1024)
ldi xH,high(ln4_textrch+200)
ldi xL,low(ln4_textrch+200)
clr temp3
load_chrmem4r:
ld temp2,-x
call load_mem8x8rev
inc temp3
cpi temp3,17
breq chrmem_exit4r
jmp load_chrmem4r
chrmem_exit4r:
sts ln4_ptr,xl
sts ln4_ptr+1,xh
ret

ln5_txtr:
ldi yh,high(ln5_text+896)
ldi yl,low(ln5_text+896)
lds temp5,dsp_invreg
ldi temp,1
ln5r_ploop1:
sts max7291_adr,temp
call print5_16br
adiw y,1
inc temp
cpi temp,9
brne ln5r_ploop1
ldi yh,high(ln5_text+888)
ldi yl,low(ln5_text+888)
movw z,y
clr temp4
shift_sraml5r:
clr temp2
ldi temp3,17
sram_loop5r:
ld temp,y    ;
lsr temp2
ror temp
brcc caryclr5r
ldi temp2,0x01
caryclr5r:
st y,temp
adiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop5r
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml5r
lds temp,ln5_cnt
inc temp 
sts ln5_cnt,temp
cpi temp,8
breq ln5r_load_chr
ret
ln5r_load_chr:
clr temp 
sts ln5_cnt,temp
ldi yh,high(ln5_text+896)
ldi yl,low(ln5_text+896)
lds xl,ln5_ptr
lds xh,ln5_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln5r_reload
call load_mem8x8rev
sts ln5_ptr,xl
sts ln5_ptr+1,xh
ret
ln5r_reload:
call ln5r_txt_init
ret
print5_16br:
clr temp3
print5_loopr:
ld temp2,y
sbrc temp5,ln5_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print5_loopr
call ln5_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln5r_txt_init:
ldi yH,high(ln5_textch)
ldi yL,low(ln5_textch)
mov temph,yh
mov templ,yl
sch5:
ld temp,y+
cpi temp,0xff
brne sch5
sbiw y,1
ldi xH,high(ln5_textrch+200)
ldi xL,low(ln5_textrch+200)
ldchr5:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr5
ldi temp,0xff
st -x,temp
clr temp
sts ln5_cnt,temp
ldi yh,high(ln5_text+1024)
ldi yl,low(ln5_text+1024)
ldi xH,high(ln5_textrch+200)
ldi xL,low(ln5_textrch+200)
clr temp3
load_chrmem5r:
ld temp2,-x
call load_mem8x8rev
inc temp3
cpi temp3,17
breq chrmem_exit5r
jmp load_chrmem5r
chrmem_exit5r:
sts ln5_ptr,xl
sts ln5_ptr+1,xh
ret

ln6_txtr:
ldi yh,high(ln6_text+896)
ldi yl,low(ln6_text+896)
lds temp5,dsp_invreg
ldi temp,1
ln6r_ploop1:
sts max7291_adr,temp
call print6_16br
adiw y,1
inc temp
cpi temp,9
brne ln6r_ploop1
ldi yh,high(ln6_text+888)
ldi yl,low(ln6_text+888)
movw z,y
clr temp4
shift_sraml6r:
clr temp2
ldi temp3,17
sram_loop6r:
ld temp,y    ;
lsr temp2
ror temp
brcc caryclr6r
ldi temp2,0x01
caryclr6r:
st y,temp
adiw y,8
dec temp3   ;ln_textl
tst temp3 
brne sram_loop6r
movw y,z
adiw y,1
movw z,y
inc temp4
cpi temp4,8
brne shift_sraml6r
lds temp,ln6_cnt
inc temp 
sts ln6_cnt,temp
cpi temp,8
breq ln6r_load_chr
ret
ln6r_load_chr:
clr temp 
sts ln6_cnt,temp
ldi yh,high(ln6_text+896)
ldi yl,low(ln6_text+896)
lds xl,ln6_ptr
lds xh,ln6_ptr+1
ld temp2,-x
cpi temp2,0xff
breq ln6r_reload
call load_mem8x8rev
sts ln6_ptr,xl
sts ln6_ptr+1,xh
ret
ln6r_reload:
call ln6r_txt_init
ret
print6_16br:
clr temp3
print6_loopr:
ld temp2,y
sbrc temp5,ln6_if
com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne print6_loopr
call ln6_en
ldi templ,low(128)
ldi temph,high(128)
sub yl,templ
sbc yh,temph
ret
ln6r_txt_init:
ldi yH,high(ln6_textch)
ldi yL,low(ln6_textch)
mov temph,yh
mov templ,yl
sch6:
ld temp,y+
cpi temp,0xff
brne sch6
sbiw y,1
ldi xH,high(ln6_textrch+200)
ldi xL,low(ln6_textrch+200)
ldchr6:
ld temp,-y
st -x,temp
cp yl,templ
cpc yh,temph
brne ldchr6
ldi temp,0xff
st -x,temp
clr temp
sts ln6_cnt,temp
ldi yh,high(ln6_text+1024)
ldi yl,low(ln6_text+1024)
ldi xH,high(ln6_textrch+200)
ldi xL,low(ln6_textrch+200)
clr temp3
load_chrmem6r:
ld temp2,-x
call load_mem8x8rev
inc temp3
cpi temp3,17
breq chrmem_exit6r
jmp load_chrmem6r
chrmem_exit6r:
sts ln6_ptr,xl
sts ln6_ptr+1,xh
ret

load_mem8x8rev:
ldi zl,byte3(ascii_table*2)
out RAMPZ,ZL
ldi zh,high(ascii_table*2)
ldi zl,low(ascii_table*2)
ldi temp4,96
search2_chr:
elpm temp,z
cp temp2,temp
breq ch2r_found
adiw z,10
dec temp4
tst temp4
brne search2_chr
ldi zl,byte3(ascii_tablex*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex*2)
ldi zl,low(ascii_tablex*2)
ch2r_found:
adiw z,1
clr temp
sbiw y,8
l2r_byte:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,8
brne l2r_byte
sbiw y,8
ret

load_mem8x8:
ldi zl,byte3(ascii_table*2)
out RAMPZ,ZL
ldi zh,high(ascii_table*2)
ldi zl,low(ascii_table*2)
ldi temp4,96
search4_ch:
elpm temp,z
cp temp2,temp
breq ch4_found
adiw z,10
dec temp4
tst temp4
brne search4_ch
ldi zl,byte3(ascii_tablex*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex*2)
ldi zl,low(ascii_tablex*2)
ch4_found:
adiw z,1
clr temp
l4_byte:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,8
brne l4_byte
ret

dsp_16x32:
ldi ZL, byte3(ascii_table16x32*2) ; Initialize Z-pointer
out RAMPZ, ZL
ldi ZH, high(ascii_table16x32*2)
ldi ZL, low(ascii_table16x32*2)
ldi temp3,96
search_chr16x32:
elpm temp2,z
cp temp,temp2
breq chr16x32_found
adiw z,60
adiw z,6
dec temp3
tst temp3
brne search_chr16x32
ldi zl,byte3(ascii_tablex*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex*2)
ldi zl,low(ascii_tablex*2)
chr16x32_found:
adiw z,1
clr temp
ldi yh,high(data_64byte)
ldi yl,low(data_64byte)
ld16x32_chr:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,64
brne ld16x32_chr
ldi temp,1
sts max7291_adr,temp
ldi yh,high(data_64byte)
ldi yl,low(data_64byte)
dsp16x32_loop1:
ld temp2,y+
sts max7291_data,temp2
call send_16b
ld temp2,y+
sts max7291_data,temp2
call send_16b
ldi temp4,16
lds temp2,ln_char
rol temp2
sub temp4,temp2
ln16x32_0loop1:
tst temp4
breq ln16x32_0exit1
call send_16b0
dec temp4
tst temp4
brne ln16x32_0loop1
ln16x32_0exit1:
lds temp6,dsp_16reg
sbrc temp6,lnbu_chrf
call ln1_en
sbrc temp6,lnbd_chrf
call ln3_en
call shiftout16
inc temp
sts max7291_adr,temp
cpi temp,9
brne dsp16x32_loop1
ldi temp,1
sts max7291_adr,temp
dsp16x32_loop2:
ld temp2,y+
sts max7291_data,temp2
call send_16b
ld temp2,y+
sts max7291_data,temp2
call send_16b
ldi temp4,16
lds temp2,ln_char
rol temp2
sub temp4,temp2
ln16x32_0loop2:
tst temp4
breq ln16x32_0exit2
call send_16b0
dec temp4
tst temp4
brne ln16x32_0loop2
ln16x32_0exit2:
lds temp6,dsp_16reg
sbrc temp6,lnbu_chrf
call ln2_en
sbrc temp6,lnbd_chrf
call ln4_en
call shiftout16
inc temp
sts max7291_adr,temp
cpi temp,9
brne dsp16x32_loop2
ldi temp,1
sts max7291_adr,temp
dsp16x32_loop3:
ld temp2,y+
sts max7291_data,temp2
call send_16b
ld temp2,y+
sts max7291_data,temp2
call send_16b
ldi temp4,16
lds temp2,ln_char
rol temp2
sub temp4,temp2
ln16x32_0loop3:
tst temp4
breq ln16x32_0exit3
call send_16b0
dec temp4
tst temp4
brne ln16x32_0loop3
ln16x32_0exit3:
lds temp6,dsp_16reg
sbrc temp6,lnbu_chrf
call ln3_en
sbrc temp6,lnbd_chrf
call ln5_en
call shiftout16
inc temp
sts max7291_adr,temp
cpi temp,9
brne dsp16x32_loop3
ldi temp,1
sts max7291_adr,temp
dsp16x32_loop4:
ld temp2,y+
sts max7291_data,temp2
call send_16b
ld temp2,y+
sts max7291_data,temp2
call send_16b
ldi temp4,16
lds temp2,ln_char
rol temp2
sub temp4,temp2
ln16x32_0loop4:
tst temp4
breq ln16x32_0exit4
call send_16b0
dec temp4
tst temp4
brne ln16x32_0loop4
ln16x32_0exit4:
lds temp6,dsp_16reg
sbrc temp6,lnbu_chrf
call ln4_en
sbrc temp6,lnbd_chrf
call ln6_en
call shiftout16
inc temp
sts max7291_adr,temp
cpi temp,9
brne dsp16x32_loop4
clr temp ; dsp chrf clear
sts dsp_16reg,temp
ret
;------------------------------------------
dsp_16x16:
ldi ZL, byte3(ascii_table16*2) ; Initialize Z-pointer
out RAMPZ, ZL
ldi ZH, high(ascii_table16*2)
ldi ZL, low(ascii_table16*2)
ldi temp3,96
search_chr16:
elpm temp2,z
cp temp,temp2
breq chr16_found
adiw z,34
dec temp3
tst temp3
brne search_chr16
ldi zl,byte3(ascii_tablex*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex*2)
ldi zl,low(ascii_tablex*2)
chr16_found:
adiw z,1
clr temp
ldi yh,high(data_32byte)
ldi yl,low(data_32byte)
ld_chr32:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,32
brne ld_chr32
ldi temp,1
sts max7291_adr,temp
ldi yh,high(data_32byte)
ldi yl,low(data_32byte)
dsp16x16_loop1:
ld temp2,y+
;com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
;com temp2
sts max7291_data,temp2
call send_16b
ldi temp4,16
lds temp2,ln_char
rol temp2
sub temp4,temp2
ln16_0loop1:
tst temp4
breq ln16_0exit1
call send_16b0
dec temp4
tst temp4
brne ln16_0loop1
ln16_0exit1:
lds temp6,dsp_16reg
sbrc temp6,lnu_chrf
call ln1_en
sbrc temp6,lnm_chrf
call ln3_en
sbrc temp6,lnd_chrf
call ln5_en
call shiftout16
inc temp
sts max7291_adr,temp
cpi temp,9
brne dsp16x16_loop1
ldi temp,1
sts max7291_adr,temp
dsp16x16_loop2:
ld temp2,y+
;com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y+
;com temp2
sts max7291_data,temp2
call send_16b
ldi temp4,16
lds temp2,ln_char
rol temp2
sub temp4,temp2
ln16_0loop2:
tst temp4
breq ln16_0exit2
call send_16b0
dec temp4
tst temp4
brne ln16_0loop2
ln16_0exit2:
lds temp6,dsp_16reg
sbrc temp6,lnu_chrf
call ln2_en
sbrc temp6,lnm_chrf
call ln4_en
sbrc temp6,lnd_chrf
call ln6_en
call shiftout16
inc temp
sts max7291_adr,temp
cpi temp,9
brne dsp16x16_loop2
clr temp ; dsp16 chrf clear
sts dsp_16reg,temp
ret

dsp_8x8:
ldi ZL, byte3(ascii_table*2) ; Initialize Z-pointer
out RAMPZ, ZL
ldi ZH, high(ascii_table*2)
ldi ZL, low(ascii_table*2)
ldi temp3,95
search_chr8:
elpm temp2,z
cp temp,temp2
breq chr8_found
adiw z,10
dec temp3
tst temp3
brne search_chr8
ldi zl,byte3(ascii_tablex*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex*2)
ldi zl,low(ascii_tablex*2)
chr8_found:
adiw z,1
clr temp
ldi yh,high(data_8byte)
ldi yl,low(data_8byte)
ld8_chr:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,8
brne ld8_chr
ldi temp3,1
sts max7291_adr,temp3
ldi yh,high(data_8byte)
ldi yl,low(data_8byte)
dsp8_loop:
ld temp2,y+
sts max7291_data,temp2
call send_16b
ldi temp4,16
lds temp2,ln_char
sub temp4,temp2
ln8_sloop:
tst temp4
breq ln8_0exit
call send_16b0
dec temp4
tst temp4
brne ln8_sloop
ln8_0exit:
lds temp,dsp_8reg
sbrc temp,ln1_strf
call ln1_en
sbrc temp,ln2_strf
call ln2_en
sbrc temp,ln3_strf
call ln3_en
sbrc temp,ln4_strf
call ln4_en
sbrc temp,ln5_strf
call ln5_en
sbrc temp,ln6_strf
call ln6_en
call shiftout16
inc temp3
sts max7291_adr,temp3
cpi temp3,9
brne dsp8_loop
clr temp ; dsp strf clear
sts dsp_8reg,temp
ret

print_str16x16:
ldi xH,high(ln_str)
ldi xL,low(ln_str)
ldi yH,high(ln_dstr16)
ldi yL,low(ln_dstr16)
clr temp3
load_chrstr16x16:
ld temp2,x+
cpi temp2,0xff
breq chrstr16x16_exit
call load_memstr16x16
inc temp3
cpi temp3,8
breq chrstr16x16_exit
jmp load_chrstr16x16
chrstr16x16_exit:
ldi yh,high(ln_dstr16)
ldi yl,low(ln_dstr16)
ldi temp,1
ln_pstr16x16loop1:
sts max7291_adr,temp
clr temp3
printstr16x16_loop1:
ld temp2,y+
;com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
;com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printstr16x16_loop1
lds temp6,dsp_16reg
sbrc temp6,lnu_chrf
call ln1_en
sbrc temp6,lnm_chrf
call ln3_en
sbrc temp6,lnd_chrf
call ln5_en
sbiw y,63
sbiw y,63
sbiw y,63
sbiw y,63
sbiw y,4
adiw y,2
inc temp
cpi temp,9
brne ln_pstr16x16loop1
ldi temp,1
ln_pstr16x16loop2:
sts max7291_adr,temp
clr temp3
printstr16x16_loop2:
ld temp2,y+
;com temp2
sts max7291_data,temp2
call send_16b
ld temp2,y
;com temp2
sts max7291_data,temp2
call send_16b
adiw y,31
inc temp3
cpi temp3,8
brne printstr16x16_loop2
lds temp6,dsp_16reg
sbrc temp6,lnu_chrf
call ln2_en
sbrc temp6,lnm_chrf
call ln4_en
sbrc temp6,lnd_chrf
call ln6_en
sbiw y,63
sbiw y,63
sbiw y,63
sbiw y,63
sbiw y,4
adiw y,2
inc temp
cpi temp,9
brne ln_pstr16x16loop2
ldi yH,high(ln_dstr16)
ldi yL,low(ln_dstr16)
ldi xH,high(ln_dstr16+256)
ldi xL,low(ln_dstr16+256)
clr temp
ln_dclr16:
st y+,temp
cp yl,xl
cpc yh,xh
brne ln_dclr16
clr temp ; dsp16 strf clear
sts dsp_16reg,temp
ret

print_str16:
ldi xH,high(ln_str)
ldi xL,low(ln_str)
ldi yH,high(ln_dstr)
ldi yL,low(ln_dstr)
clr temp3
load_chrstr16:
ld temp2,x+
cpi temp2,0xff
breq chrstr16_exit
call load_memstr8x8
inc temp3
cpi temp3,16
breq chrstr16_exit
jmp load_chrstr16
chrstr16_exit:
ldi yh,high(ln_dstr)
ldi yl,low(ln_dstr)
ldi temp,1
ln_pstr16loop:
sts max7291_adr,temp
clr temp3
printstr16_loop:
ld temp2,y
;com temp2
sts max7291_data,temp2
call send_16b
adiw y,8
inc temp3
cpi temp3,16
brne printstr16_loop
lds temp4,dsp_8reg
sbrc temp4,ln1_strf
call ln1_en
sbrc temp4,ln2_strf
call ln2_en
sbrc temp4,ln3_strf
call ln3_en
sbrc temp4,ln4_strf
call ln4_en
sbrc temp4,ln5_strf
call ln5_en
sbrc temp4,ln6_strf
call ln6_en
sbiw y,63
sbiw y,63
sbiw y,2
adiw y,1
inc temp
cpi temp,9
brne ln_pstr16loop
ldi yH,high(ln_dstr)
ldi yL,low(ln_dstr)
clr temp
clr temp2
ln_dclr:
st y+,temp
inc temp2
cpi temp2,128
brne ln_dclr
clr temp ; dsp strf clear
sts dsp_8reg,temp
ret

load_memstr8x8:
ldi zl,byte3(ascii_table*2)
out RAMPZ,ZL
ldi zh,high(ascii_table*2)
ldi zl,low(ascii_table*2)
ldi temp4,96
searchstr_ch:
elpm temp,z
cp temp2,temp
breq strch_found
adiw z,10
dec temp4
tst temp4
brne searchstr_ch
ldi zl,byte3(ascii_tablex*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex*2)
ldi zl,low(ascii_tablex*2)
strch_found:
adiw z,1
clr temp
load_strbyte:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,8
brne load_strbyte
ret

load_memstr16x16:
ldi zl,byte3(ascii_table16*2)
out RAMPZ,ZL
ldi zh,high(ascii_table16*2)
ldi zl,low(ascii_table16*2)
ldi temp4,96
searchstr16_ch:
elpm temp,z
cp temp2,temp
breq strch16_found
adiw z,34
dec temp4
tst temp4
brne searchstr16_ch
ldi zl,byte3(ascii_tablex*2)
out RAMPZ,ZL
ldi zh,high(ascii_tablex*2)
ldi zl,low(ascii_tablex*2)
strch16_found:
adiw z,1
clr temp
load_str16byte:
elpm temp2,z+
st y+,temp2
inc temp
cpi temp,32
brne load_str16byte
ret

dsp_init:
ldi temp,0x09 ;decode
sts max7291_adr,temp
ldi temp,0x00
sts max7291_data,temp
call send_16b16
call dsp_en
ldi temp,0x0a ;intensity
sts max7291_adr,temp
ldi temp,0x00
sts max7291_data,temp
call send_16b16
call dsp_en
ldi temp,0x0b ;scan limit
sts max7291_adr,temp
ldi temp,0x07
sts max7291_data,temp
call send_16b16
call dsp_en
ldi temp,0x0c ;shutdown
sts max7291_adr,temp
ldi temp,0x01
sts max7291_data,temp
call send_16b16
call dsp_en
ldi temp,0x0f ;test mode
sts max7291_adr,temp
ldi temp,0x00
sts max7291_data,temp
call send_16b16
call dsp_en
ret

dsp_seti:
ldi temp,0x0a ;intensity
sts max7291_adr,temp
lds temp,dsp_i
sts max7291_data,temp
call send_16b16
call dsp_en
ret

dsp_seti_ln:
ldi temp,0x0a ;intensity
sts max7291_adr,temp
lds temp,dsp_i
sts max7291_data,temp
call send_16b16
lds temp,dsp_effreg
sbrc temp,ln1_eff
call ln1_en
sbrc temp,ln2_eff
call ln2_en
sbrc temp,ln3_eff
call ln3_en
sbrc temp,ln4_eff
call ln4_en
sbrc temp,ln5_eff
call ln5_en
sbrc temp,ln6_eff
call ln6_en
ret

dsp_hwtest:		;148x48 = 36A dc 12v !!!
ldi temp,0x0f	;hw test mode
sts max7291_adr,temp
ldi temp,0x01
sts max7291_data,temp
call send_16b16
call dsp_en
ret

dsp_sftest:
ldi temp,0x0a ;intensity
sts max7291_adr,temp
ldi temp,2
sts max7291_data,temp
call send_16b16
call dsp_en
ldi temp,0xff
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
sf_testloop:
call send_16b16
call dsp_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne sf_testloop
ret

dsp_clr:
ldi temp,0x00
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
clr_loop:
call send_16b16
call dsp_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne clr_loop
ret

clr_ln1:
ldi temp,0x00
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
clr_loop1:
call send_16b16
call ln1_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne clr_loop1
ret
clr_ln2:
ldi temp,0x00
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
clr_loop2:
call send_16b16
call ln2_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne clr_loop2
ret
clr_ln3:
ldi temp,0x00
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
clr_loop3:
call send_16b16
call ln3_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne clr_loop3
ret
clr_ln4:
ldi temp,0x00
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
clr_loop4:
call send_16b16
call ln4_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne clr_loop4
ret
clr_ln5:
ldi temp,0x00
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
clr_loop5:
call send_16b16
call ln5_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne clr_loop5
ret
clr_ln6:
ldi temp,0x00
sts max7291_data,temp
ldi temp,1
sts max7291_adr,temp
clr_loop6:
call send_16b16
call ln6_en
inc temp
sts max7291_adr,temp
cpi temp,9
brne clr_loop6
ret

shiftout16:
ldi regh,16
ln_16loop:
call send_16b0
dec regh
tst regh
brne ln_16loop
ret

send_16b16:
push temp
ldi temp,16
b16_loopx:
call send_16b
dec temp
tst temp
brne b16_loopx
pop temp
ret

send_16b0:
clr regl
sbi porta,DO_
byte_loop0:
sbi porta,CLK_
nop
nop
cbi porta,CLK_
inc regl
cpi regl,16
brne byte_loop0
cbi porta,DO_
ret

send_16b:
lds regl,max7291_adr
clr regh
call send_byte
lds regl,max7291_data
clr regh
call send_byte
ret

send_byte:
lsl regl
brcc wrbit0
cbi porta,DO_
jmp wrbit1
wrbit0:
sbi porta,DO_
wrbit1:
sbi porta,CLK_
nop
nop
cbi porta,CLK_
inc regh
cpi regh,8
brne send_byte
cbi porta,DO_
ret

ln1_en:
sbi portd,cs_1
nop
nop
cbi portd,cs_1
ret
ln2_en:
sbi portb,cs_2
nop
nop
cbi portb,cs_2
ret
ln3_en:
sbi portb,cs_3
nop
nop
cbi portb,cs_3
ret
ln4_en:
sbi portc,cs_4
nop
nop
cbi portc,cs_4
ret
ln5_en:
sbi portc,cs_5
nop
nop
cbi portc,cs_5
ret
ln6_en:
sbi portc,cs_6
nop
nop
cbi portc,cs_6
ret
dsp_en:
push temp
ser temp
out portc,temp
sbi portd,cs_1
sbi portb,cs_2
sbi portb,cs_3
nop
nop
cbi portd,cs_1
cbi portb,cs_2
cbi portb,cs_3
clr temp
out portc,temp
pop temp
ret
