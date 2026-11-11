# LIMO: a Sesotho-language processor derived from RISC-V


LIMO is a small 32-bit load-store processor whose assembly language is Sesotho. It is derived from RISC-V (RV32I). It has a 16 registers instead of 32 like the RISC-V RV32I.

| **Repository** | https://github.com/Kevin-droid408/Computer-Architecture |
## Running the simulator

The simulator is plain HTML, CSS and JavaScript. It has no build step, no server and no dependencies.

1. Open `src/index.html` in any modern browser, or open the GitHub Pages link above.
2. Pick an example from the drop-down, type a program, or use **Open a .limo file** to load one from your computer.
3. Use **Step** to advance one clock cycle, or **Run** / **Run to end**. **Step back** undoes a cycle.
4. Untick **Forwarding** to see the cycle cost of each hazard. Changing it resets the run.
5. Click a row in the machine-code table to set or clear a breakpoint.
6. Press **Self-test** to run example programs 1 to 3 and compare their cycle, stall and flush counts with the M1 specification.

## Features

| Req. | What the simulator does |
|---|---|
| B1 | Editor and assembler with labels, `#` comments, decimal and `0x` immediates. Shows each line's hex and colour-coded binary fields (field names on hover) and reports errors in plain language with line numbers. Open and save `.limo` files. |
| B2 | Five stages with the IF/ID, ID/EX, EX/MEM and MEM/WB registers and separate instruction and data memories. Step, Step back, Run, Pause, Run to end, Reset and breakpoints. |
| B3 | Per-stage live values: PC, PC+4, register operands, immediate, ALU inputs and result, memory address and data, write-back value, and the content of every pipeline register. |
| B4 | Control signals (RegWrite, ALUSrc, ALU control, MemRead, MemWrite, MemtoReg, Branch, Jump) for each instruction in flight, with a one-line meaning on hover, plus PCSrc. |
| B5 | RAW, load-use and control hazards are detected and logged. Shows ForwardA/B sources, bubbles and flushes. Forwarding ON/OFF switch. |
| B6 | Instruction-by-cycle pipeline chart, cycles, CPI, stalls, flushes, register file with Sesotho names, and non-zero data memory, with changed values highlighted. |
| B7 | Freshman mode narrates each stage in English and Sesotho. Five built-in example programs. The pipeline chart also labels cells with text, so colour is not the only cue. |

### Known gaps

- The datapath is shown as stage cards with live values, not as a wire diagram with highlighted units.
- The Sesotho narration is a draft and needs review by a Sesotho speaker.
- Automated unit tests, the eight test programs, the Ripes cross-check and the usability test (B8) are not yet written.

## The LIMO ISA in brief

32-bit registers, byte-addressed little-endian memory, word-aligned `lata`/`boloka`, fixed 32-bit instructions in RV32I formats (R, I, S, B, J). 16 registers, so register fields use 4 of the 5 encoded bits.

### Registers

| Number | Name | Alias | Purpose |
|---|---|---|---|
| r0 | `noto` (also `lefela`) | zero | Hard-wired zero |
| r1 | `khutla` | ra | Return address |
| r2 | `lesupa` | sp | Stack pointer |
| r3 to r15 | `lb3` to `lb15` | | General purpose |

`sebali` (the PC) is not in the register file and cannot be named as an operand.

### Instructions

| Mnemonic | Syntax | Operation | RV32I |
|---|---|---|---|
| `kopanya` | `rd, rs1, rs2` | rd ← rs1 + rs2 | add |
| `tlosa` | `rd, rs1, rs2` | rd ← rs1 − rs2 | sub |
| `kopanyapalo` | `rd, rs1, imm` | rd ← rs1 + imm | addi |
| `le` | `rd, rs1, rs2` | bitwise AND | and |
| `kapa` | `rd, rs1, rs2` | bitwise OR | or |
| `kapafeela` | `rd, rs1, rs2` | bitwise XOR | xor |
| `checha-menahane` | `rd, rs1, rs2` | shift left logical | sll |
| `checha-arola` | `rd, rs1, rs2` | shift right logical | srl |
| `papisonyane` | `rd, rs1, rs2` | rd ← 1 if rs1 < rs2 (signed), else 0 | slt |
| `lata` | `rd, imm(rs1)` | rd ← memory word | lw |
| `boloka` | `rs2, imm(rs1)` | memory word ← rs2 | sw |
| `tlola-lekana` | `rs1, rs2, label` | branch if equal | beq |
| `tlola-fapana` | `rs1, rs2, label` | branch if not equal | bne |
| `qhoma` | `rd, label` | rd ← PC+4; jump | jal |
| `qhoma-aterese` | `rd, imm(rs1)` | rd ← PC+4; jump to rs1+imm | jalr |

The assembler ignores hyphens, apostrophes and letter case in mnemonics, so `checha-menahane`, `chechamenahane` and `Ts'` style spellings all resolve to the same word. An apostrophe inside a number is an error.

## Pipeline timing model

- Five stages: IF, ID, EX, MEM, WB. The register file is written in WB and read in ID in the same cycle (write before read).
- With forwarding on, EX takes operands from EX/MEM first, then MEM/WB. The only stall is a **load-use** hazard: one bubble.
- With forwarding off, an instruction waits in ID until its producer has written back.
- Branches and jumps resolve in EX with **always-not-taken** prediction. A taken branch or jump flushes 2 instructions.
- Cycle count is the cycle in which the last instruction completes WB. Misaligned or out-of-range memory accesses stop the simulator with an error message.

Reference results from the M1 specification, which the self-test checks:

| Program | Cycles | Stalls | Flushes |
|---|---|---|---|
| 1. ALU instructions | 15 | 0 | 0 |
| 2. Load-use stall | 13 | 1 | 0 |
| 3. Loop, branches, call | 25 | 0 | 6 |

## Repository layout

```
.
├── src/
│   ├── index.html      page structure
│   ├── style.css       styles
│   ├── assembler.js    ISA table, parser, RV32I encoding
│   ├── pipeline.js     five-stage pipeline, forwarding, stalls, flushes
│   └── ui.js           rendering, examples, controls, self-test
├── tests/              unit tests and test programs (B8, to do)
├── examples/           .limo example programs
├── docs/               ISA specification, design notes, test report
├── README.md
└── AI_USE.md           declaration of AI tool use
```

The scripts share global variables and must load in the order `assembler.js`, `pipeline.js`, `ui.js`.

## Way of working

- `main` is protected. Work arrives through feature branches and pull requests, with one issue per branch and a reviewer who is not the author.
- A task is done when it is merged through a reviewed PR, tests pass, the linked issue is closed, and the spec is updated if the ISA changed.
- Stand-ups on Wednesday, Thursday and Friday; sprint review and planning on Sunday.
- Each milestone is tagged: `m1` to `m4`, then `v1.0`.
- Code style is enforced with Prettier: `npx prettier --write "src/*"`.

## AI use

AI tools were used for exploration and drafting. Each use is declared in [`AI_USE.md`](AI_USE.md) with the tool, its purpose and what the team changed. Every member must be able to explain the code they submit.

## References

- Patterson and Hennessy, *Computer Organization and Design: RISC-V Edition*, Ch. 2 and Ch. 4.
- Harris and Harris, *Digital Design and Computer Architecture: RISC-V Edition*, Ch. 6 and 7.
- Stallings, *Computer Organization and Architecture*, 10th ed., Ch. 12 to 14.
- Ripes (reference five-stage pipeline) and RARS.
