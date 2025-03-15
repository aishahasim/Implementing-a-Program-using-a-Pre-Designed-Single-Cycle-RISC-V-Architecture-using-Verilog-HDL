module mux (a,b,s,o);
input s;
input [0:31] a,b;
output [0:31] o;
assign o = (s == 1'b0) ? a : b;
endmodule
