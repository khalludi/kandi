; Read sectors from disk using disk_read function
[org 0x7c00]

mov [BOOT_DRIVE], dl    ; BIOS stores boot drive in
                        ; DL

mov bp, 0x8000          ; Set stack
mov sp, bp

mov bx, 0x9000          ; Load 5 sectors to 0x0000:
mov dh, 5               ; 0x9000 from boot disk
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]        ; Print out first word
call print_hex

mov dx, [0x9000 + 512]  ; Print word in second sector
call print_hex

jmp $

%include "print_hex.asm"
%include "disk_load.asm"

; Global variables
BOOT_DRIVE: db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

; Simulate two sectors of data
times 256 dw 0xdada
times 256 dw 0xface
