.data           # declare and initialize variables
hello:  .asciz "Hello world!\n" # string
Extended:   .asciz "sure matala!\n" #string to extend the code
a: .word 10
b: .word 20

  .text         # code starts here
main:           # label marking the entry point of the program
  la a0, hello  # load the address of hello into a0 (1st argument)
  addi a7, zero, 4     # code to print the string at the address a0
  ecall         # make the system call

  la a0, Extended   #load the address of Extended into a0 (1st argument)
  addi a7, zero, 4     # code to print the string at the address a0
  ecall         # make the system call

  lw t0, a     # load the value of a into t0
  lw t1, b     # load the value of b into t1

#adding a and b, storing the result in t2
  add t2, t0, t1   #t2 = t0 + t1

  li a7, 1        # syscall for print integer
  mv a0, t2       # move the result to a0 (1st argument)
  ecall 

  addi a7, zero, 10    # code to exit
  ecall         # make the system call
