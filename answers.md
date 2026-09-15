# Step 4

| Instruction | Format | Opcode | Funct3 | Funct7 | rd | rs1 | rs2 | Hex |
|---|---|---|---|---|---|---|---|---|
| add | R-Type | 0110011 | 000 | 0000000 | 00101 | 00101 | 00110 | 006282b3 |
| slli | I-Type | 0010011 | 001 | 0000000 | 11100 | 00101 | | 00329e13 |
| sub | R-Type | 0110011 | 000 | 0100000 | 11101 | 11100 | 00111 | 407e0eb3 |

# Step 5

| RISC-V instruction | Format from Opcode | Registers | Assembly instruction |
|---|---|---|---|
| 0x00A00263 | I-Type | x0, x5 | addi t0, zero, 10 |
| 0x406283B3 | R-Type | x7, x6, x5 | sub t2, t0, t1 |
| 0x00329293 | I-Type | x5 | slli t0, t0, 3 |

# Step 6

The `.data` section reserves memory and defines a null-terminated string, "Hello world!", under the label `hello`. The `la a0, hello` instruction loads the address of that string (not its contents) into register `a0`, which is where syscalls expect their first argument. `a7` is loaded twice because it holds the syscall number.
