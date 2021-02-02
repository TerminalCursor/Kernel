[org 0x1000]
[bits 64]
entry:
	mov rdi, 0xA0000
	dec rdi
	mov al, 1
	mov rcx, 0xFA00
.draw:
	inc rdi
	mov [rdi], al
	dec rcx
	jnz .draw

.loop:

	;; Input loop
.uploop:
	mov dx, 0x60
	in ax, dx
	cmp al, [LAST_KEY]
	je .uploop
	mov [LAST_KEY], al
	test al, 0x80
	jz .uploop
	;; Exit if q
	cmp al, 0x90
	je .exit
	mov [TEMP_RAX], rax
	jmp .loop

.exit:
	; Shutdown time
	mov dx, 0x604
	mov ax, 0x2000
	out dx, ax

	;; Shutdown failed... loop indefinitely
	jmp $

LAST_KEY db 0
TEMP_RAX dq 0
TEST_BYTE dw 0x0

%include "letter.asm"
