`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 09:42:32
// Design Name: 
// Module Name: control32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control32(Opcode,Jrn,Function_opcode,Alu_resultHigh,RegDST,ALUSrc,MemorIOtoReg,RegWrite,MemRead,
MemWrite,IORead, IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
    // The real address of LW and SW is Alu_Result, the signal comes from the execution unit
    // From the execution unit Alu_Result[31..10], used to help determine whether to process Mem or IO
    input[21:0] Alu_resultHigh;
    input[5:0]Opcode;
    input [5:0]Function_opcode;
    //1 indicates that data needs to be read from memory or I/O to the register
    output MemorIOtoReg;
    output MemRead; // 1 indicates that the instruction needs to read from the memory
    output IORead; // 1 indicates I/O read
    output IOWrite; // 1 indicates I/O write
    output RegWrite;
    output [1:0]ALUOp;
    output Branch;
    output nBranch;
    output Jmp;
    output Sftmd;
    output RegDST;
    output ALUSrc;
    output Jal;
    output I_format;
    output Jrn;
    output MemWrite;// Instruction that needs to write a register
    wire R_format;
    wire Lw;
    wire Sw;
    assign Sw = (Opcode==6'b101011) ? 1'b1:1'b0;
    assign Lw = (Opcode==6'b100011) ? 1'b1:1'b0;
    assign R_format = (Opcode==6'b000000);
    assign RegWrite = (R_format || Lw || Jal || I_format) && !(Jrn) ; // Write memory or write IO
    assign MemWrite = ((Sw==1) && (Alu_resultHigh[21:0] != 22'H3FFFFF)) ? 1'b1:1'b0;
    assign MemRead = ((Lw==1) && (Alu_resultHigh[21:0] != 22'H3FFFFF)) ? 1'b1:1'b0; // Read memory
    assign IORead = ((Lw==1) && (Alu_resultHigh[21:0] == 22'H3FFFFF)) ? 1'b1:1'b0; // Read port
    assign IOWrite = ((Sw==1) && (Alu_resultHigh[21:0] == 22'H3FFFFF)) ? 1'b1:1'b0; // Write port
    // Read operations require reading data from a port or memory to a register
    assign MemorIOtoReg = IORead || MemRead;
    assign ALUOp[1] = (Sw==1 || Lw==1 || Branch==1 || nBranch==1) ? 1'b0:1'b1;
    assign ALUOp[0] = (Opcode==6'b000100 || Opcode==6'b000101) ? 1'b1:1'b0;
    assign Branch = (Opcode==6'b000100) ? 1'b1:1'b0;
    assign nBranch = (Opcode==6'b000101) ? 1'b1:1'b0;
    assign Jmp = (Opcode==6'b000010) ? 1'b1:1'b0;
    assign Jal = (Opcode==6'b000011) ? 1'b1:1'b0;
    assign Jrn = (Opcode==6'b000000 && Function_opcode==6'b001000) ? 1'b1:1'b0;
    assign Sftmd = (Opcode==6'b000000 && (Function_opcode==6'b000000 || Function_opcode==6'b000011 || Function_opcode==6'b000010)) ? 1'b1:1'b0;
    assign RegDST = (R_format==1) ? 1'b1:1'b0;
    assign ALUSrc = (I_format||Lw==1||Sw==1) ? 1'b1:1'b0;
    assign I_format = (!(R_format) && !(Jal) && !(Jmp) && !(Jrn) && !(Branch) && !(nBranch) && (Alu_resultHigh[21:0] != 22'H3FFFFF)) ? 1'b1:1'b0;
endmodule
