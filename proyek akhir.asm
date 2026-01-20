org 100h
jmp start

; =====================
; DATA
; =====================
level db 0            ; 0�3

off_str  db 'OFF $'
low_str  db 'LOW $'
med_str  db 'MED $'
high_str db 'HIGH$'

; =====================
; PROGRAM
; =====================
start:
    call clear
    call tampil

main:
    mov ah, 00h
    int 16h            ; baca keyboard

    cmp al, 27         ; ESC
    je keluar

    cmp al, '+'
    je naik

    cmp al, '-'
    je turun

    jmp main

; =====================
naik:
    cmp level, 3
    je main
    inc level
    call tampil
    jmp main

turun:
    cmp level, 0
    je main
    dec level
    call tampil
    jmp main

; =====================
tampil:
    call clear

    mov dx, offset judul
    call print

    mov dx, offset teks
    call print

    mov al, level
    call print_level
    ret

; =====================
print_level:
    cmp al, 0
    je off
    cmp al, 1
    je low
    cmp al, 2
    je med
    jmp high

off:    mov dx, offset off_str
        jmp cetak
low:    mov dx, offset low_str
        jmp cetak
med:    mov dx, offset med_str
        jmp cetak
high:   mov dx, offset high_str

cetak:
    call print
    ret

; =====================
print:
    mov ah, 09h
    int 21h
    ret

; =====================
clear:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

; =====================
keluar:
    mov ah, 4Ch
    int 21h

; =====================
; TEKS
; =====================
judul db 'SIMULASI INTENSITAS CAHAYA',13,10,'$'
teks  db 'LEVEL : $'
