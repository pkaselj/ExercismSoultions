section .text
global steps
; int steps(int)
steps:
        push rbp
        mov rbp, rsp

        push rcx
        push rax
        push rsi

        movsx rax, edi
        mov rcx, 0

; guard checks
        test rax, rax
        jns _steps_loop
        mov rcx, -1
        jmp _steps_end

_steps_loop:
        inc rcx
        cmp rax, 1
        je _steps_success
        test rax, 1
        jz _steps_even
        mov rsi, 3
        mul rsi
        add rax, 1
        jmp _steps_processed
_steps_even:
        mov rsi, 2
        xor rdx, rdx
        div rsi

_steps_processed:
        jmp _steps_loop

_steps_success:
        dec rcx

_steps_end:
        mov rax, rcx

        pop rsi
        pop rcx

        leave
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
