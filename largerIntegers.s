         .data
array:  .word 12, 45, 7, 93, 28, 61, 4
size:   .word 7
msg1:   .asciz "The first largest integer is: "
msg2:   .asciz "The second largest integer is: "

        .text
        .globl main

main:   #loading elements into an array
        la  a0, array
        lw  a1, size