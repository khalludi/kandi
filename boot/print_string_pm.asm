[bits 32]
; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to
; by EDX
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY   ; Set edx to vid mem

print_string_pm_loop:
  mov al, [ebx]           ; Store char in AL
  mov ah, WHITE_ON_BLACK  ; Store attrib in AH

  cmp al, 0         ; if al = 0, end of string
  je print_string_pm_done

  mov [edx], ax     ; Store in curr char cell
  add ebx, 1        ; Increment ebx
  add edx, 2        ; Move to next char cell
                    ; in vid mem

  jmp print_string_pm_loop  ; loop

print_string_pm_done:
  popa
  ret
