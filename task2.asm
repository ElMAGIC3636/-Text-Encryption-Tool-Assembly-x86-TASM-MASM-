.model small
.stack 100h

.data

msg_input  db 13,10,"Enter input filename: $"
msg_output db 13,10,"Enter output filename: $"
msg_done   db 13,10,"Encryption completed successfully.$"
msg_err    db 13,10,"Error occurred!$"

input_filename  db 50 dup(0)
output_filename db 50 dup(0)

buffer db 512 dup(0)

.code

;----------------------------------------
; read_string: reads string + shows typed chars
; DX = buffer
;----------------------------------------
read_string PROC
    mov si, dx

read_loop:
    mov ah, 01h       ; read char with echo
    int 21h

    cmp al, 13        ; ENTER?
    je end_read

    mov [si], al      ; save char
    inc si
    jmp read_loop

end_read:
    mov byte ptr [si], 0
    ret
read_string ENDP


main PROC

    mov ax, @data
    mov ds, ax

    ; ================================
    ; Ask for INPUT filename
    ; ================================
    mov dx, offset msg_input
    mov ah, 09h
    int 21h

    mov dx, offset input_filename
    call read_string


    ; ================================
    ; Ask for OUTPUT filename
    ; ================================
    mov dx, offset msg_output
    mov ah, 09h
    int 21h

    mov dx, offset output_filename
    call read_string


    ; ================================
    ; OPEN input file (read only)
    ; ================================
    mov dx, offset input_filename
    mov ax, 3D00h         ; open read only
    int 21h
    jc file_error
    mov bx, ax            ; BX = input file handle


    ; ================================
    ; CREATE output file
    ; ================================
    mov dx, offset output_filename
    mov cx, 0             ; normal attribute
    mov ah, 3Ch
    int 21h
    jc file_error
    mov si, ax            ; SI = output file handle


read_loop_file:
    mov ah, 3Fh           ; read file
    mov cx, 512
    mov dx, offset buffer
    int 21h
    jc file_error

    cmp ax, 0
    je finish_encrypt      ; EOF

    mov cx, ax             ; number of bytes read
    mov di, offset buffer

encrypt_loop:
    xor byte ptr [di], 1   ; simple XOR encryption
    inc di
    loop encrypt_loop

    mov bx, si             ; output handle
    mov dx, offset buffer
    mov cx, ax
    mov ah, 40h            ; write
    int 21h

    jmp read_loop_file


finish_encrypt:
    ; close output
    mov ah, 3Eh
    mov bx, si
    int 21h

    ; close input
    mov bx, bx
    mov ah, 3Eh
    int 21h

    mov dx, offset msg_done
    mov ah, 09h
    int 21h
    jmp exit_program


file_error:
    mov dx, offset msg_err
    mov ah, 09h
    int 21h

exit_program:
    mov ax, 4C00h
    int 21h

main ENDP
end main