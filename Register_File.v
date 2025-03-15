module Register_File (clk,rst_l,A1,A2,A3,RD1,RD2,WE3,WD3);
    input clk,rst_l,WE3;
    input [4:0] A1, A2, A3;
    input [31:0] WD3;
    output [31:0] RD1, RD2; 
    reg [31:0] Register [31:0];
    assign RD1 = (rst_l == 1'b0) ? 32'h00000000 : Register[A1];
    assign RD2 = (rst_l == 1'b0) ? 32'h00000000 : Register[A2];
    always @(posedge clk) begin
        if (WE3)
            Register[A3] <= WD3;     // add x7 x5 x6
    end
    initial begin
        Register[9] = 32'h00000040; // A1 RD1 // Base Address
        Register[6] = 32'h00000030; // A2 RD2 // Data
        Register[5] = 32'h00000040;
    end
endmodule