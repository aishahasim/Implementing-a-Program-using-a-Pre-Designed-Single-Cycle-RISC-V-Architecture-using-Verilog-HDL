module PC_Module (clk,rst_l,PC,PC_Next);
    input clk,rst_l;
    input [31:0] PC_Next;
    output [31:0] PC;

    reg [31:0] PC_1;

    always @(posedge clk or negedge rst_l) begin
        if (rst_l == 1'b0)
            PC_1 <= 32'h00000000;
        else
            PC_1 <= PC_Next;
    end

    assign PC = (rst_l == 1'b0) ? 32'h00000000 : PC_1;

endmodule