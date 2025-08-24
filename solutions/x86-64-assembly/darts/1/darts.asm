section .rodata
RAD_OUT_2: DQ 100.0
PTS_OUT:   DQ 1
RAD_MID_2: DQ 25.0
PTS_MID:   DQ 5
RAD_INR_2: DQ 1.0
PTS_INR:   DQ 10

section .text
global score

; extern uint8_t score(double x, double y);
score:
    push rbp
    mov rbp, rsp

    mulsd xmm0, xmm0
    mulsd xmm1, xmm1
    addsd xmm0, xmm1 ; xmm0 <- squared disance from origin

    ucomisd xmm0, [rel RAD_INR_2]
    ja _score_mid
    mov rax, [rel PTS_INR]
    jmp _score_end
_score_mid:
    ucomisd xmm0, [rel RAD_MID_2]
    ja _score_out
    mov rax, [rel PTS_MID]
    jmp _score_end
_score_out:
    ucomisd xmm0, [rel RAD_OUT_2]
    ja _score_miss
    mov rax, [rel PTS_OUT]
    jmp _score_end
_score_miss:
    mov rax, 0

_score_end:
    leave
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
