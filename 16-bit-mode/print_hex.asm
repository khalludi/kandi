
print_hex:
  pusha

  ;mov bp, 0x8000          ; Setup stack
  ;mov sp, bp

  mov bl, 0x00            ; Set counter

main_loop:
  cmp bl, 0x04            ; Loop four times
  je end
  
  cmp bl, 0x00            ; Shift last digit if
  je noshift              ; needed
  sar dx, 4         

noshift:
  mov cx, dx              ; Get last number in hex
  and cx, 0x000f

  cmp cl, 0x0a            ; If letter, add7
  jge add7

return_label:
  add cl, 0x30            ; Add 0x30 offset
  push cx                 ; Push to stack
  inc bl                  ; Increment counter
  jmp main_loop           ; Loop again

end:
  pop cx                  ; At end, pop from stack
  mov [HEX_OUT+0x02], cl  ; and place in correct
  pop cx                  ; position
  mov [HEX_OUT+0x03], cl
  pop cx
  mov [HEX_OUT+0x04], cl
  pop cx
  mov [HEX_OUT+0x05], cl

  mov bx, HEX_OUT         ; Move string to bx
  call print_string       ; Print string

  popa                    ; Pop and return
  ret

add7:
  add cl, 0x07            ; Add offset of 7 for
  jmp return_label        ; letters

; Include print functions
%include "print_string.asm"

; Data
HEX_OUT: db '0x0000', 0
