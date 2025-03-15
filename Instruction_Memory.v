module Instruction_Memory (rst_l,A,RD);
    
    input rst_l;
    input [31:0] A;
    output [31:0] RD;

    reg [31:0] mem [1023:0];

    //assign RD = (~rst_l) ? {32{~rst_l}} : mem[A[31:2]];
    //assign RD = (~rst_l) ? {32{1'b0}} : mem[A[31:2]];
    assign RD = (rst_l == 1'b0) ? 32'h00000000 : mem[A[31:2]];

    // initial begin
    //     $readmemh("mem.hex",mem);
    // end
    initial begin
        //mem[0] = 32'hFFC4A303;
        //mem[1] = 32'h0064A423;
        mem[2] = 32'h0062E233;
        //mem[3] = 32'hFE420AE3;
    end
endmodule