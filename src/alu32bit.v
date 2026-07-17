`timescale 1ns / 1ps
module alu #(parameter WIDTH = 32)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [2:0]       opcode,
    output reg  [WIDTH-1:0] result,
    output wire             zero,
    output wire             carry,
    output wire             overflow
);
    // extended wires to capture carry bit
    wire [WIDTH:0] add_ext;
    wire [WIDTH:0] sub_ext;
    assign add_ext = {1'b0, A} + {1'b0, B};
    assign sub_ext = {1'b0, A} - {1'b0, B};
    // combinational ALU logic
    always @ (*) begin
        result = {WIDTH{1'b0}};
        case (opcode)
            3'b000 : result = add_ext[WIDTH-1:0]; // ADD
            3'b001 : result = sub_ext[WIDTH-1:0]; // SUB
            3'b010 : result = A & B;              // AND
            3'b011 : result = A | B;              // OR
            3'b100 : result = A ^ B;              // XOR
            3'b101 : result = ~A;                 // NOT
            3'b110 : result = A << B[4:0];        // SHL
            3'b111 : result = A >> B[4:0];        // SHR
        endcase
    end
    // zero flag: high when result is all zeros
    assign zero = ~(|result);
    // carry flag: unsigned overflow for ADD and SUB
    assign carry = (opcode == 3'b000) ? add_ext[WIDTH] :
                   (opcode == 3'b001) ? sub_ext[WIDTH] : 1'b0;
    // overflow flag: signed overflow for ADD and SUB
    assign overflow = (opcode == 3'b000) ?
                        ((~A[WIDTH-1] & ~B[WIDTH-1] &  result[WIDTH-1]) |
                         ( A[WIDTH-1] &  B[WIDTH-1] & ~result[WIDTH-1])) :
                      (opcode == 3'b001) ?
                        ((~A[WIDTH-1] &  B[WIDTH-1] &  result[WIDTH-1]) |
                         ( A[WIDTH-1] & ~B[WIDTH-1] & ~result[WIDTH-1])) :
                      1'b0;
endmodule