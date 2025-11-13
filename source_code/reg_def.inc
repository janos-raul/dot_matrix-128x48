/*
 * reg_def.inc
 *
 *  Created: 26.06.2019 11:45:57
 *   Author: janos
 */ 

                                    .def	fbin0	=r16	; binary value byte 0 (LSB)
                                    .def	fbin1	=r17	; binary value byte 1
                                    .def	fbin2	=r18	; binary value byte 2 (MSB)
                                    .def	tBCD0	=r20	; BCD value digits 0 and 1
                                    .def	tBCD1	=r21	; BCD value digits 2 and 3
                                    .def	tBCD2	=r22	; BCD value digits 4 and 5
                                    .def	tBCD3	=r23	; BCD value digits 6 and 7 (MSD)
				                    .def	fBCD0	=r16	; BCD value digits 0 and 1
                                    .def	fBCD1	=r17	; BCD value digits 2 and 3
                                    .def	fBCD2	=r18	; BCD value digits 4 and 5
                                    .def	fBCD3	=r19	; BCD value digits 6 and 7 (MSD is 0|1)
                                    .def	tbin0	=r20	; binary value byte 0 (LSB)
                                    .def	tbin1	=r21	; binary value byte 1
                                    .def	tbin2	=r22	; binary value byte 2 (MSB)

.equ PAGESIZEB = PAGESIZE*2

.def temp	=r16
.def temp2	=r17
.def temp3	=r18
.def temp4	=r19
.def temp5	=r20
.def temp6	=r21
.def templ	=r22
.def temph	=r23
.def regl	=r24
.def regh	=r25
.def _xl = r26
.def _xh = r27
.def _yl = r28
.def _yh = r29
.def _zl = r30
.def _zh = r31

.equ lcde 			= pb1
.equ lcdrs			= pb2

.equ DO_			= pa0 
.equ CLK_			= pa1
.equ CS_1			= pd4
.equ CS_2			= pb4 
.equ CS_3			= pb2
.equ CS_4			= pc6
.equ CS_5			= pc3
.equ CS_6			= pc1

.equ led_			= pb5
.equ lcd_			= pd7
.equ wtr_			= pa5
.equ one_wire		= pb0

.equ out_1			= pc0
.equ out_2			= pc1
.equ out_3			= pc2
.equ out_4			= pc3
.equ out_5			= pc4
.equ out_6			= pc5
.equ out_7			= pc6
.equ out_8			= pc7

.equ i2c_START			=0x08
.equ i2c_MT_SLA_ACK		=0x18
.equ i2c_MT_DATA_ACK	=0x28
.equ sla_w			=0b10100000
.equ sla_r			=0b10100001
.equ ac_cnt =0x04

.equ ic2_scl		= pa7
.equ ic2_sda		= pa6
.equ i2c_read		= 0b10100001
.equ i2c_write		= 0b10100000

.equ tim0_val = 0x14	;6.2 ms
.equ tim2_val = 0xd9	;1.9968 mSec
.equ tim1_val = 0xc2f7	;
.equ cp2 = 1000

;****flags reg0
.equ key_deb		= 7 ;0x80
.equ min_p			= 6 ;0x40
.equ tx1c_f			= 5 ;0x20
.equ ln_eff 		= 4 ;0x10
.equ ln_efspeed 	= 3 ;0x08
.equ refresh_temp 	= 2 ;0x04
.equ rehfresh_clk	= 1 ;0x02
.equ refresh_scr	= 0 ;0x01 

;****flags reg1
.equ adv_f			= 7 ;0x80
.equ key_presf		= 6 ;0x40
.equ key_esc		= 5 ;0x20
.equ key_menu		= 4 ;0x10
.equ key_up		 	= 3 ;0x08
.equ key_down	 	= 2 ;0x04
.equ tim_1			= 1 ;0x02
.equ key_int		= 0 ;0x01

;****flags reg2
.equ blu_err			= 7 ;0x80
.equ gps_rx				= 6 ;0x40
.equ osec_d				= 5 ;0x20
.equ cnt_fx				= 4 ;0x10
.equ blu_rx		 		= 3 ;0x08
.equ got_time			= 2 ;0x04
.equ min_scr			= 1 ;0x02
.equ cnt_out1			= 0 ;0x01


;****dsp_speedreg  sram
.equ ln1_speedf				= 7 ;0x80
.equ ln2_speedf				= 6 ;0x40
.equ ln3_speedf				= 5 ;0x20
.equ ln4_speedf    			= 4 ;0x10
.equ ln5_speedf		 		= 3 ;0x08
.equ ln6_speedf				= 2 ;0x04
;.equ lnd_sena333			= 1 ;0x02
;.equ lnd_tena333			= 0 ;0x01

;****dsp_effreg  sram+eeprom
.equ ln1_eff				= 7 ;0x80
.equ ln2_eff				= 6 ;0x40
.equ ln3_eff				= 5 ;0x20
.equ ln4_eff    			= 4 ;0x10
.equ ln5_eff		 		= 3 ;0x08
.equ ln6_eff				= 2 ;0x04
;.equ lnd_sena333			= 1 ;0x02
;.equ lnd_tena333			= 0 ;0x01

;****dsp_16reg  sram
.equ lnu_chrf 				= 7 ;0x80 
.equ lnm_chrf				= 6 ;0x40 
.equ lnd_chrf				= 5 ;0x20
.equ lnbu_chrf				= 4 ;0x10
.equ lnbd_chrf				= 3 ;0x08
;.equ un_used0				= 2 ;0x04
;.equ un_used1				= 1 ;0x02
;.equ un_used2				= 0 ;0x01

;****dsp_8reg  sram
.equ ln1_strf 				= 7 ;0x80 
.equ ln2_strf				= 6 ;0x40 
.equ ln3_strf				= 5 ;0x20
.equ ln4_strf				= 4 ;0x10
.equ ln5_strf				= 3 ;0x08
.equ ln6_strf				= 2 ;0x04
;.equ un_used4				= 1 ;0x02
;.equ un_used5				= 0 ;0x01

;****dsp_invreg  sram+eeprom
.equ ln1_if 			= 7 ;0x80 
.equ ln2_if				= 6 ;0x40 
.equ ln3_if				= 5 ;0x20
.equ ln4_if				= 4 ;0x10
.equ ln5_if				= 3 ;0x08
.equ ln6_if				= 2 ;0x04
;.equ ln3_oi				= 1 ;0x02
.equ logo_i				= 0 ;0x01

;****dsp_s8reg  sram+eeprom
.equ ln1_sena				= 7 ;0x80 
.equ ln2_sena				= 6 ;0x40 
.equ ln3_sena				= 5 ;0x20
.equ ln4_sena				= 4 ;0x10
.equ ln5_sena				= 3 ;0x08
.equ ln6_sena				= 2 ;0x04
;.equ ln4_senamm			= 1 ;0x02
;.equ ln4_tenamm			= 0 ;0x01
;****dsp_s8regr  sram+eeprom
.equ ln1_rsena				= 7 ;0x80 
.equ ln2_rsena				= 6 ;0x40 
.equ ln3_rsena				= 5 ;0x20
.equ ln4_rsena				= 4 ;0x10
.equ ln5_rsena				= 3 ;0x08
.equ ln6_rsena				= 2 ;0x04
;.equ ln4_senamm			= 1 ;0x02
;.equ ln4_tenamm			= 0 ;0x01
;****dsp_t8reg  sram+eeprom
.equ ln1_tena				= 7 ;0x80 
.equ ln2_tena				= 6 ;0x40 
.equ ln3_tena				= 5 ;0x20
.equ ln4_tena				= 4 ;0x10
.equ ln5_tena				= 3 ;0x08
.equ ln6_tena				= 2 ;0x04
;.equ ln4_senaxx			= 1 ;0x02
;.equ ln4_tenaxx			= 0 ;0x01
;****dsp_st16reg0  sram+eeprom
.equ lnu_sena				= 7 ;0x80 
.equ lnm_sena				= 6 ;0x40 
.equ lnd_sena				= 5 ;0x20
.equ lnu_tena				= 4 ;0x10
.equ lnm_tena				= 3 ;0x08
.equ lnd_tena				= 2 ;0x04
.equ lnbu_sena				= 1 ;0x02
.equ lnbd_sena				= 0 ;0x01
;****dsp_st16reg1  sram+eeprom
.equ lnbu_tena				= 7 ;0x80 
.equ lnbd_tena				= 6 ;0x40 
.equ lnu_rsena				= 5 ;0x20
.equ lnm_rsena				= 4 ;0x10
.equ lnd_rsena				= 3 ;0x08
.equ lnbu_rsena				= 2 ;0x04
.equ lnbd_rsena				= 1 ;0x02
;.equ lng_tenaxx2			= 0 ;0x01
;****dsp_st16reg2  sram+eeprom
.equ lng_sena				= 7 ;0x80 
.equ lng_rsena				= 6 ;0x40 
;.equ lnu_rsena				= 5 ;0x20
;.equ lnm_rsena				= 4 ;0x10
;.equ lnd_rsena				= 3 ;0x08
;.equ lnbu_rsena			= 2 ;0x04
;.equ lnbd_rsena			= 1 ;0x02
;.equ ln4_tenaxx2			= 0 ;0x01
;****dsp_datereg sram+eeprom
.equ ln1_d					= 7 ;0x80 
.equ ln2_d					= 6 ;0x40
.equ ln3_d					= 5 ;0x20
.equ ln4_d		   			= 4 ;0x10
.equ ln5_d			 		= 3 ;0x08
.equ ln6_d					= 2 ;0x04
;.equ lnxxx1				= 1 ;0x02
;.equ lnxxx					= 0 ;0x01
;****dsp_tempreg  sram+eeprom
.equ ln1_t					= 7 ;0x80
.equ ln2_t					= 6 ;0x40
.equ ln3_t					= 5 ;0x20
.equ ln4_t		   			= 4 ;0x10
.equ ln5_t			 		= 3 ;0x08
.equ ln6_t					= 2 ;0x04
;.equ lnx12					= 1 ;0x02
;.equ lnx23					= 0 ;0x01
;****dsp_clkreg  sram+eeprom
.equ ln1_c					= 7 ;0x80 
.equ ln2_c					= 6 ;0x40 
.equ ln3_c					= 5 ;0x20
.equ ln4_c					= 4 ;0x10
.equ ln5_c					= 3 ;0x08
.equ ln6_c					= 2 ;0x04
;.equ ln3_ov				= 1 ;0x02
;.equ ln4_ov				= 0 ;0x01



.def	t0=	r4
.def	t1=	r5
.def	t2=	r6
.def	t3=	r7
.def	t4=	r8
.def	t5=	r9
.def	t6=	r26
.def	t7=	r27
.def   cnt= r31

.def	a0=	r18 ;a  axb=a(rez)
.def	a1=	r19 ;a  a:b=a(rez)
.def	a2=	r20
.def	a3=	r21
.def	a4=	r22
.def	a5=	r23
.def	a6=	r24
.def	a7=	r25

.def	b0=	r10 ;b
.def	b1=	r11
.def	b2=	r12
.def	b3=	r13
.def	b4=	r14
.def	b5=	r15
.def	b6=	r16
.def	b7=	r17






/*
lds temp,dsp_8reg
sbr temp,0x80 ; ln1 putstring
sts dsp_8reg,temp
ldi temp,14
sts ln_char,temp
ldi temp,'3'
call dsp_8x8
ty:
jmp ty
ldi temp,'R'
call ln16x32_ch1
ldi temp,'a'
call ln16x32_ch2
ldi temp,'u'
call ln16x32_ch3
ldi temp,'l'
call ln16x32_ch4
/*
ldi temp,'0'
call lnd_ch1
ldi temp,'1'
call lnd_ch2
ldi temp,'2'
call lnd_ch3

lds temp,dspstr_reg
sbr temp,0x80 ; ln1 putstring
sts dspstr_reg,temp
ldi temp,2
sts ln_char,temp
ldi temp,'3'
call dsp_8x8

/*
call load_ln1
call lnu_txt_init
ldi temp,0
rep:
push temp
call lnu_txtl
pop temp
inc temp
cpi temp,48
brne rep
tr:
jmp tr
*/

;tr:
;jmp tr

;call load_ln1
;call load_ln2
;call load_ln3
;call load_ln4
