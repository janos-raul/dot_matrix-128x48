/*
 * delay_routines.inc
 *
 *  Created: 25-Dec-22 09:34:51
 *   Author: janos
 */ 

wait_1000ms:
push r17
push r18
push r19
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 20 000 000 cycles
; 1s at 20 MHz
    ldi  r17, 102
    ldi  r18, 118
    ldi  r19, 194
L1000ms: dec  r19
    brne L1000ms
    dec  r18
    brne L1000ms
    dec  r17
    brne L1000ms
pop r19
pop r18
pop r17
ret

wait_20ms:
push r17
push r18
push r19
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 400 000 cycles
; 20ms at 20 MHz
    ldi  r17, 3
    ldi  r18, 8
    ldi  r19, 120
L20ms: dec  r19
    brne L20ms
    dec  r18
    brne L20ms
    dec  r17
    brne L20ms
pop r19
pop r18
pop r17
ret

wait_1ms:
push r17
push r18
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 20 000 cycles
; 1ms at 20 MHz
    ldi  r17, 26
    ldi  r18, 249
L1ms: dec  r18
    brne L1ms
    dec  r17
    brne L1ms
pop r18
pop r17
ret