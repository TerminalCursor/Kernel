    ;; rax - ASCII Letter
    ;; rdx - color
write_letter:
    push rdx
    mov rsi, ASCII_TABLE
    xor rdx, rdx
    mov rcx, 0x9
    mul rcx
    add rsi, rax
    mov rdi, 0xA0000
    mov rdx, [rsp+2]
    and rdx, 0xFF
    jz .nxt1
.down:
    add rdi, 0x140
    dec rdx
    jnz .down
.nxt1:
    mov rdx, [rsp+1]
    and rdx, 0xFF
    add rdi, rdx
    pop rdx
    mov ch, 9
.top:
    mov rax, [rsi]
    mov cl, 7
.draw:
    ror al, 15
    test rax, 0x80
    jz .no
    mov [rdi], dl
.no:
    inc rdi
    dec cl
    jnz .draw
    add rdi, 0x140
    sub rdi, 7
    inc rsi
    dec ch
    jnz .top

    ret

%include "asciitable.asm"

    ;; 0x120 - 9 * 0x21
    ;; 0x140 - Length of One line
