module Data_Memory(clk,rst_l,WE,WD,A,RD);

    input clk,rst_l,WE;
    input [31:0]A,WD;
    output [31:0]RD;

    reg [31:0] mem [1023:0];

    always @ (posedge clk)
    begin
        if(WE)
            mem[A] <= WD;
    end

    assign RD = (~rst_l) ? 32'd0 : mem[A];

    initial begin
        mem[60] = 32'h0000000A;
        mem[72] = 32'h0000000C;
    end

endmodule