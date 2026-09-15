    .data
a: .word 7
b: .word 5
c: .word 20

    .text
    .globl main

main:

    #loading valaues of a, b, c into registers
    lw t0, a
    lw t1, b
    lw t2, c

    #adding a and b, storing result in t0
    add t0, t0, t1

    #shifting left by 3
    slli t3, t0, 3

    #subtracting c from t3, storing result in t4
    sub t4, t3, t2

    #printing the result
    li a7, 1         # syscall for print integer
    mv a0, t4
    ecall

    #exit
    li a7, 10        # syscall for exit
    ecall
    