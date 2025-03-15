module Single_Cycle_Top_TB ();
    
    reg clk=1'b1,rst_l;

    Single_Cycle_Top Single_Cycle_Top(
                                .clk(clk),
                                .rst_l(rst_l)
    );

    initial begin
        $dumpfile("Single Cycle.vcd");
        $dumpvars(0);
    end

    always 
    begin
        clk = ~ clk;
        #50;  
        
    end
    
    initial
    begin
        rst_l <= 1'b0;
        #150;

        rst_l <=1'b1;
        #500;
        $finish;
    end
endmodule