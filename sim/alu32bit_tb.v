`timescale 1ns / 1ps
module alu_tb;
    // inputs driven by testbench
    reg  [31:0] A;
    reg  [31:0] B;
    reg  [2:0]  opcode;
    // outputs driven by ALU
    wire [31:0] result;
    wire        zero;
    wire        carry;
    wire        overflow;
    // instantiate ALU
    alu #(.WIDTH(32)) uut (
        .A(A), .B(B), .opcode(opcode),
        .result(result), .zero(zero),
        .carry(carry), .overflow(overflow)
    );
    initial begin
        $display("=== 32-bit ALU Testbench ===");
        $display("Time\tOp\tA\t\tB\t\tResult\t\tZ C O");
        // ADD: 10 + 20 = 30
        A=32'd10;  B=32'd20;          opcode=3'b000; #10;
        $display("%0t\tADD\t%0d\t\t%0d\t\t%0d\t\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // ADD overflow: 0xFFFFFFFF + 1 = 0, carry=1
        A=32'hFFFFFFFF; B=32'd1;      opcode=3'b000; #10;
        $display("%0t\tADD\t%h\t%0d\t\t%0d\t\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // SUB: 50 - 30 = 20
        A=32'd50;  B=32'd30;          opcode=3'b001; #10;
        $display("%0t\tSUB\t%0d\t\t%0d\t\t%0d\t\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // SUB: 25 - 25 = 0, zero=1
        A=32'd25;  B=32'd25;          opcode=3'b001; #10;
        $display("%0t\tSUB\t%0d\t\t%0d\t\t%0d\t\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // AND
        A=32'hFF00FF00; B=32'h0F0F0F0F; opcode=3'b010; #10;
        $display("%0t\tAND\t%h\t%h\t%h\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // OR
        A=32'hFF00FF00; B=32'h0F0F0F0F; opcode=3'b011; #10;
        $display("%0t\tOR\t%h\t%h\t%h\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // XOR: same inputs = zero
        A=32'hAAAAAAAA; B=32'hAAAAAAAA; opcode=3'b100; #10;
        $display("%0t\tXOR\t%h\t%h\t%h\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // NOT: ~0 = 0xFFFFFFFF
        A=32'h00000000; B=32'd0;      opcode=3'b101; #10;
        $display("%0t\tNOT\t%h\t\t\t%h\t%b %b %b",$time,A,result,zero,carry,overflow);
        // SHL: 8 << 2 = 32
        A=32'd8;   B=32'd2;           opcode=3'b110; #10;
        $display("%0t\tSHL\t%0d\t\t%0d\t\t%0d\t\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        // SHR: 32 >> 2 = 8
        A=32'd32;  B=32'd2;           opcode=3'b111; #10;
        $display("%0t\tSHR\t%0d\t\t%0d\t\t%0d\t\t%b %b %b",$time,A,B,result,zero,carry,overflow);
        $display("=== Simulation Complete ===");
        $finish;
    end
endmodule