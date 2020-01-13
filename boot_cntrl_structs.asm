;
; Simple use of control structures
;

mov bx, 4

cmp bx, 4       ; <= 4, go to block1
jle block1
cmp bx, 40      ; < 40, go to block2
jl block2
mov al, 'C'     ; otherwise set 'C' and end
jmp end

block1:         ; set to A and end
  mov al, 'A'
  jmp end

block2:         ; set to B and end
  mov al, 'B'
  jmp end

end:

mov ah, 0x0e    ; set BIOS tele-type
int 0x10        ; print character in al

jmp $

times 510-($-$$) db 0
dw 0xaa55
