        .data
array:  .word 12, 45, 7, 93, 28, 61, 4
size:   .word 7
msg1:   .asciz "First large integer: "
msg2:   .asciz "Second large integer: "
new:    .asciz "\n"

        .text
        .globl main

main:
        la a0, array            # a0 = base address ao array[0]
        lw a1, size             # a1 = size (number of elements)
        jal ra, LargerInteger   # calls LargerIntegr(array, size)

        mv s0, a0

        la a0, msg1
        li a7, 4
        ecall

        mv a0, s0
        li a7, 1
        ecall

        la a0, new
        li a7, 4
        ecall

        la a0, msg2
        li a7, 4
        ecall

        mv a0, s0
        li a7, 1
        ecall

        li a7, 10
        ecall


LargerInteger: 

        addi sp, sp, -32
        sw s0, 28(sp)
        sw s1, 24(sp)
        sw s2, 20(sp)
        sw s3, 16(sp)
        sw s4, 12(sp)

        mv s0, a0       #s0 = array(base address)
        mv s1, a1       #s1 = size

        #the if statemant
        lw t0, 0(s0)        #t0 = array[0]
        lw t1, 4(s0)        #t1 = array[1]

        ble t0, t1, else1
        mv s2, t0          #max1 = array[0]
        mv s3, t1          #max2 = arrat[1]
        j done
else1:  
        mv s2, t1               #max1 = array[1]
        mv s3, t0              #max2 = array[0]
done:

        li t4, 2
loop:   
        bge t4, s1, done
        slli t2, t4, 2
        add t2, s0, t2
        lw t3, 0(t2)

        ble t3, s2, elseif
        mv s3, s2               # max2 = max1
        mv s2, t3               # max1 = array[i]
elseif:
        ble t3, s3, after
        mv s3, t3               # max2 = array[i]
after:
        addi t4, t4, 1
        j loop
end:
        la a0, msg1
        li a7, 4
        ecall

        mv a0, s2
        li a7, 1
        ecall

        la a0, new
        li a7, 4
        ecall

        la a0, msg2
        li a7, 4
        ecall

        mv a0, s3
        li a7, 1
        ecall

        la a0, new
        li a7, 4
        ecall

        lw   s0, 28(sp)
        lw   s1, 24(sp)
        lw   s2, 20(sp)
        lw   s3, 16(sp)
        lw   s4, 12(sp)
        addi sp, sp, 32
        ret




        


