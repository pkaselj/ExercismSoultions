section .text

; extern int find(int *array, int size, int value);
; rdi = array
; esi = size
; edx = value
global find
find:
    push rbp
    mov rbp, rsp
    sub rsp, 16 ; rbp-8 -> first, rsp-16 -> last iter

    push rbx

    test rdi, rdi   ; test if array is null
    jz _find_error

    test esi, esi ; return error on empty array or invalid size
    jle _find_error

    dec rsi
    mov qword [rbp-8], 0
    mov qword [rbp-16], rsi
_find_loop:
    ; rax = (first + last)/2
    mov rax, qword [rbp-8]
    add rax, qword [rbp-16]
    shr rax, 1

    lea rbx, dword [rdi + rax * 4] ; absolute address to element at index rax

    cmp edx, dword [rbx] ; compare wanted to current value 
    je _find_end ; found the value
    ; Test here if rax is 0 or last value
    jg _find_upper
    ; wanted value < current value
    ; case current index == 0
    test rax, rax
    jz _find_error
    ; case first == last
    mov rbx, qword [rbp-8]
    cmp rbx, qword [rbp-16]
    jz _find_error
    dec rax
    mov qword [rbp-16], rax
    jmp _find_loop
_find_upper:
    ; wanted value > current value
    ; case current index == (size-1)
    cmp rax, rsi
    jz _find_error
    ; case first == last
    mov rbx, qword [rbp-8]
    cmp rbx, qword [rbp-16]
    jz _find_error
    inc rax
    mov qword [rbp-8], rax
    jmp _find_loop

    

_find_error:
    mov rax, -1
_find_end:

    pop rbx

    leave
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
