BITS 16                     ; Specify 16 bits processor
org 0x7C00                  ; Set load offset to 0x7C00 where the BIOS load the bootloader

start:
    cli                      ; disable interruptions
    mov ax, cs               ; set data segments 
    mov ds, ax               ; and set the code segments to the data segments

    ; set the video mode to the text mode
    mov ah, 0x00
    mov al, 0x03             ; text mode 80x25 16 colors
    int 0x10

    ; print "Hello, World!"
    mov si, hello_string
    call print_string

    ; while true
    hang:
        jmp hang

; print strings that ends on 0
print_string:
    mov ah, 0x0E             ; teletype mode on text mode

    .next_char:
        lodsb                ; load next string byte to AL
        cmp al, 0            ; al = 0?
        jz .done             ; Jump if Zero to done
        int 0x10             ; if not, print AL (only since the AH mode is display)
        jmp .next_char       ; jump to the next char/byte

    .done:
        ret                  ; return

hello_string db 'Hello, World!', 0 // define bytes for string and end on 0

times 510-($-$$) db 0        ; fill with 0 until the 510 byte (included)
dw 0xAA55                    ; sign the bytes 511 and 512 

