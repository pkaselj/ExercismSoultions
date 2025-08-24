section .text
global steps
; int steps(int)
steps:
        push rbp
        mov rbp, rsp

        push rcx ; step counter
        push rax ; scratch buffer for calculations
        push rsi ; divisor or multiplier 
        push rdx ; r32 multiplier and divisor extension

        movsx rax, edi ; argument is int (edi) sign-promote to long and move to rax
        mov rcx, 0 ; initialize step counter

; guard checks
        test rax, rax
        js _steps_invalid ; Error if negative
        jz _steps_invalid ; Error if 0
        jmp _steps_loop

_steps_invalid:
        mov rcx, -1     ; return code -1
        jmp _steps_end

_steps_loop:
        inc rcx
        cmp rax, 1              ; end condition (rax == 1) 
        je _steps_success
        test rax, 1
        jz _steps_even
        mov rsi, 3      ; do if odd
        mul rsi
        add rax, 1
        jmp _steps_processed
_steps_even:
        mov rsi, 2      ; do if even
        xor rdx, rdx
        div rsi

_steps_processed:
        jmp _steps_loop

_steps_success:
        dec rcx         ; soultion dicates number of steps is counted from second number

_steps_end:
        mov rax, rcx    ; calling convention -> return code is rax

        pop rdx
        pop rsi
        pop rcx

        leave
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
