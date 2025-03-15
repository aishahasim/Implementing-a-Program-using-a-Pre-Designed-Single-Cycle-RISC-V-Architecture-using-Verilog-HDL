`include "PC.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Control_Unit_Top.v"
`include "mux.v"
module Single_Cycle_Top (clk,rst_l);
    input clk,rst_l;

    wire [31:0] PC_Top, RD_Instr, ImmExt_Top, RD1_Top, WriteResult,
                ReadData, PCPlus4, RD2_Top, ALU_Result,SrcB;
    wire RegWrite, MemWrite;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;
    wire ALUSrc;
    wire ResultSrc;

    PC_Module PC(
        .clk(clk),
        .rst_l(rst_l),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    Instruction_Memory Instruction_Memory(
        .rst_l(rst_l),
        .A(PC_Top),
        .RD(RD_Instr)
    );

    Register_File Register_File(
        .clk(clk),
        .rst_l(rst_l),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top),
        .WE3(RegWrite),
        .WD3(WriteResult)
    );

    Sign_Extend Sign_Extend(
        .rst_l(rst_l),
        .ImmSrc(ImmSrc[0]),
        .Instr(RD_Instr),
        .ImmExt(ImmExt_Top)
    );

    Control_Unit_Top Control_Unit(
        .Op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(),
        .funct3(RD_Instr[14:12]),
        .funct7(),
        .ALUControl(ALUControl),
        .Zero(),
        .PCSrc()

    );

    mux alumux(
        .a(RD2_Top),
        .b(ImmExt_Top),
        .s(ALUSrc),
        .o(SrcB)
    );

    mux rsltmux(
        .a(ALU_Result),
        .b(ReadData),
        .s(ResultSrc),
        .o(WriteResult)

    );

    ALU ALU(
        .A(RD1_Top),
        .B(SrcB),
        .Result(ALU_Result),
        .ALUControl(ALUControl),
        .OverFlow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    Data_Memory Data_Memory(
        .clk(clk),
        .rst_l(rst_l),
        .WE(MemWrite),
        .WD(RD2_Top),
        .A(ALU_Result),
        .RD(ReadData)
    );

    PC_Adder PC_Adder(
        .A(PC_Top),
        .B(32'h00000004),
        .C(PCPlus4)
    );
endmodule