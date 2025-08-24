section .text

; extern int square_of_sum(int number);
global square_of_sum
square_of_sum:
    push rbp
    mov rbp, rsp

    movsx rcx, edi ; counter
    mov rax, 0 ; accumulator 

square_of_sum_loop:
    add rax, rcx
    loop square_of_sum_loop

square_of_sum_end:
    mov rdx, 0
    mul rax

    leave
    ret

; extern int sum_of_squares(int number);
global sum_of_squares
sum_of_squares:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    push rbx ; saved register

    movsx rcx, edi ; counter
    mov rbx, 0 ; accumulator

sum_of_squares_loop:
    mov rax, rcx
    mov qword [rbp-8], rax
    mov rdx, 0
    mul qword [rbp-8]
    add rbx, rax
    loop sum_of_squares_loop 

    mov rax, rbx
    pop rbx

    leave
    ret

; extern int difference_of_squares(int number);
global difference_of_squares
difference_of_squares:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    push rdi

    call sum_of_squares
    mov qword [rbp-8], rax

    mov rdi, qword [rbp-16]
    call square_of_sum
    sub rax, qword [rbp-8]

    leave
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
