org 0x7c00



[bits 16]


    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x8000      ; Set up stack pointer

%include "gdt.inc"
cli
lgdt [gdtr]

    get_kernel:
        push dx
        
        mov ah, 0x2    ; read
        mov al, dh    ;previously set size
        mov ch, 0x0    ; cylinder position
        mov dh, 0x0    ; head
        mov cl, 0x2 ; position -> after bootloader
        int 0x13    ; call bios    
        
        pop dx
        ret

    mov dh, 17            ; size of kernel
    mov bx, 0x9000    ; position of the kernel
    call get_kernel

    [bits 32]
    
    mov eax, cr0
    or al, 1
    mov cr0, eax
    jmp CODE_SEG:init_pm

    
    mov edx, 1
    mov ecx, 0x32
    call print_text

    print_text:
        mov ebx,1
        mov eax, 4
        int 0x80
        ret

    init_pm:
        mov ax, DATA_SEG
        mov ds, ax
        mov ss, ax
        mov es, ax
        mov fs, ax
        mov gs, ax
        mov ebp, 0x90000
        mov esp, ebp
        
        call 0x9000
        jmp $

    





times 510 - ($-$$) db 0
dw 0xAA55
