# 32-Bit Arithmetic Logic Unit (ALU) in Verilog

**Overview**
This repository contains the complete RTL design and functional verification of a parameterized 32-bit Arithmetic Logic Unit (ALU). The design is a purely combinational, unclocked architecture targeting the Xilinx Artix-7 FPGA (xc7a200tfbg676-2). It supports eight fundamental arithmetic and logical operations and features robust flag generation (Zero, Carry, Overflow).

**Tools & Technologies**
Language: Verilog HDL (IEEE 1364)

EDA Tool: Xilinx Vivado ML 2025.2

Simulation: XSim Simulator

Target Device: Xilinx Artix-7

**Architecture & Operations**
The design utilizes a 3-bit opcode to execute the following operations:

000: Addition (with unsigned overflow detection)

001: Subtraction (with zero and signed overflow detection)

010 - 101: Bitwise AND, OR, XOR, NOT

110 - 111: Logical Shift Left, Logical Shift Right

**Key Performance Metrics (Post-Synthesis)**
Resource Utilization: 298 Slice LUTs (0.22% of total FPGA fabric). Zero DSP blocks and zero Block RAMs utilized.
Timing: Unconstrained combinational data path achieving complete timing closure with zero violations.
Power & Thermals: Maintained a 16°C thermal margin (23.553W estimated unconstrained total on-chip power).

**Verification**
Functional verification was performed using a structured testbench covering 10 specific test cases, including maximum value boundary conditions and identical operand subtraction. A 100% pass rate was achieved.

<img width="1586" height="817" alt="Screenshot 2026-07-11 220143" src="https://github.com/user-attachments/assets/f5c4b124-4970-40d4-a52a-75e3acf7c54f" />


**RTL Schematic & Physical Layout**
<img width="1277" height="728" alt="Screenshot 2026-07-11 200110" src="https://github.com/user-attachments/assets/22042c43-e498-45f6-9b9b-c4023cc8bae2" />
<img width="563" height="682" alt="floor plan" src="https://github.com/user-attachments/assets/2a35d33c-c155-49e4-a701-e9fc18c45f7b" />



**How to Run**
Clone the repository.
Create a new Vivado project and add the files from the /rtl and /sim directories.
Run behavioral simulation using XSim to view the waveforms.
