;
; Print hex output
;
[org 0x7c00]

mov dx, 0x1fb6      ; store value to print in dx
call print_hex      ; call the function

jmp $

; Include print functions
%include "print_hex.asm"

; Pad with 0's and add magic number
times 510-($-$$) db 0
dw 0xaa55
