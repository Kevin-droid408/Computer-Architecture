# RISC-V Assembly & C++ Arithmetic Model

This project demonstrates a simple arithmetic operation implemented in three parallel forms: a C++ reference model and two RISC-V assembly programs.

## Files

### `model.cpp`
A C++ program that computes `(a + b) * 8 - c` where `a = 7`, `b = 5`, `c = 20`, and prints the result to the console.

### `assmeblyModel.s`
A RISC-V assembly implementation of the same computation as `model.cpp`. It:
- Loads `a`, `b`, and `c` from the `.data` section into registers `t0`, `t1`, `t2`.
- Adds `a` and `b` (`t0 = t0 + t1`).
- Shifts the sum left by 3 bits using `slli` (equivalent to multiplying by 8).
- Subtracts `c` from the shifted value (`t4 = t3 - t2`).
- Prints the final integer result via syscall `a7 = 1`, then exits via syscall `a7 = 10`.

### `PrintStringsandArithmetic.s`
A RISC-V assembly program that combines string printing with integer arithmetic. It:
- Prints two null-terminated strings (`hello` and `Extended`) in sequence, each via syscall `a7 = 4`, loading the string's address into `a0` before each call.
- Loads two words, `a = 10` and `b = 20`, adds them, and prints the sum via syscall `a7 = 1`.
- Exits via syscall `a7 = 10`.

## Key Concepts

- **`.data` section**: reserves and initializes labeled memory (strings and words) used by the program.
- **`a0`**: the register syscalls read their first argument from — a string address for print-string, or an integer value for print-integer.
- **`a7`**: holds the syscall number and is reloaded whenever the program needs to invoke a different system call (print string, print integer, exit).

## Running

These `.s` files are written for a RISC-V simulator such as [RARS](https://github.com/TheThirdOne/rars). Load a file, assemble, and run to see its console output.
