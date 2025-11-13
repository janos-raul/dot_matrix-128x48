/*
 * lcd_strings.inc
 *
 *  Created: 26.06.2019 14:51:52
 *   Author: janos
 */ 
table_ver1:
.db "-=LED-DISPLAY=-",0XFF
table_ver2:
.db "VERSION:1.0-2023",0XFF
table_ver3:
.db "  +40749476260",0XFF
table_ver4:
.db "    128x48-p",0XFF
table_bluver:
.db "LED DISPLAY-128x48p",0X0D,0X0A,"VERSION: 1.0-2023",0X0D,0X0A,"CPU: ATMega1284P @ 20Mhz",0X0D,0X0A,"janos.szabo@gmail.com +40749476260",0X0D,0X0A,0x0ff
table_blucmderr:
.db "-input ERROR !",0X0D,0X0A,0xff
table_blureset:
.db "-reseting device !",0X0D,0X0A," please wait ...",0X0D,0X0A,0xff
table_bluok:
.db "-OK !",0X0D,0X0A,0xff


/*
table_tout:
.db "out:",0x00  
table_tagt:
.db "agt:",0x00 
table_tret:
.db "ret:",0x00 
table_tliv:
.db "liv:",0x00
table_traul:
.db "raul:",0x00
table_treni:
.db "reni:",0x00
table_time:
.db "--:--",0x00
table_date:
.db "--/--",0x00
table_s1rom:
.db 0x28,0xC7,0xEC,0xB7,0x09,0x00,0x00,0x66 ;living TEMP
table_s2rom:
.db 0x28,0XD2,0X69,0XB8,0X09,0X00,0X00,0X55
table_s3rom:
.db 0x28,0XD4,0XF3,0XB7,0X09,0X00,0X00,0X77
table_s4rom:
.db 0x28,0X0F,0X70,0XB8,0X09,0X00,0X00,0X54
table_s5rom:
.db 0x28,0X7F,0X76,0XB8,0X09,0X00,0X00,0X50 ;agt  temp
table_s6rom:
.db 0x28,0X73,0XDE,0XB2,0X09,0X00,0X00,0X3B ;out temp
table_s7rom:
.db 0x28,0XD4,0XF9,0XB7,0X09,0X00,0X00,0XCA ;RETUR temp
table_sxrom:
.db 0x28,0XE6,0XB4,0XB7,0X09,0X00,0X00,0X4C
*/