module Sign_Extend (rst_l,ImmSrc,Instr,ImmExt);
    input rst_l, ImmSrc;
    input [31:0] Instr;
    output [31:0] ImmExt;

    assign ImmExt = (~rst_l) ? 32'h00000000 : ImmSrc ?
                {{20{Instr[31]}},Instr[31:25],Instr[11:7]} :
                {{20{Instr[31]}},Instr[31:20]};

    //assign ImmExt = (~rst_l) ? 32'h00000000 : Instr[11] ? 
                                            //{20{1'b1},Instr} :
                                            //{20{1'b0},Instr};

    //assign ImmExt = (~rst_l) ? 32'h00000000 : Instr[11] ? 
                                            //{20'hFFFFF',Instr} :
                                            //{20'h00000,Instr};    
endmodule