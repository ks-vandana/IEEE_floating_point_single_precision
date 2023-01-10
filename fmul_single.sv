module fp_mult(a,b,c);
  input logic [31:0]a; //32'b00111111101000000000000000000000 = 1.25
  input logic [31:0]b; //32'b00111111001000000000000000000000 = 0.625
  output logic [31:0]c; //0.78125
 
 always_comb 
  begin
  bit sa = a[31];
  bit sb = b[31];
  bit sc = sa ^ sb;
  logic [7:0]ea = a[30:23];
  logic [7:0]eb = b[30:23];
  logic [7:0]ef = ea + eb;//-8'b01111111;
  logic [7:0]ec= ef-8'b01111111;
  logic [23:0]ma = 24'b100000000000000000000000 + a[22:0];
  logic [23:0]mb = 24'b100000000000000000000000 + b[22:0];
  logic [22:0]mc = 23'b0;
  
  logic [48:0]d = ma;
  
    for(int t=0;t<24;t++)
      begin
        if(d[0]==1)
          begin
            d[48:24] = d[48:24]+mb[23:0];
          end
          begin
            d = d >> 1;
          end
      end
    if(d[47]==1'b1)
      begin
        ec=ec+1;
        d = d >> 1;
      end
    c[31] = sc;
  	c[30:23] = ec;
  	c[22:0] = d[45:23];
  end

endmodule
