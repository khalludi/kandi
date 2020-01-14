print_string:
  pusha             ; push registers
  mov ah, 0x0e      ; set BIOS tele-type
 
  call print        ; print loop

  popa              ; pop registers
  ret               ; return

print:
  mov al, [bx]      ; mv output to proper register
  int 0x10          ; call interrupt
  inc bx            ; update bx
  mov al, [bx]
  cmp al, 0         ; check if null reached
  jne print         ; if not, print next character
  ret               ; else return
