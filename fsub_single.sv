`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2023 09:40:01
// Design Name: 
// Module Name: fsub_single
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


// Code your design here
module fsub_single(a1,b1,c);
input logic [31:0]a1,b1;
output logic[31:0]c;
  logic [31:0]a;//=32'b01000010100100000000000000000001;
  logic [31:0]b;//=32'b01000000011100000000000001000000;
  logic[7:0]ea,eb,bias,e;
  logic[22:0]ma,mb,m_f;
  logic[27:0]mb_temp,ma_temp,msub;
  logic[23:0]m1;
  logic g,r,s0,s1,s,s3,p;
  logic[31:0]temp;
  int l;
  
  
always_comb
  begin
  a=a1;
  b=b1;
    if(a[30:23]<b[30:23])
      begin
        temp=a;
        a=b;
        b=temp;
      end
  else if(a[30:23]==b[30:23])
  begin
    if(a[22:0]<b[22:0])
        begin
        temp=a;
        a=b;
        b=temp;
        end
  end
  else
    begin
    a=a;
    b=b;
    end
    
    ea=a[30:23];
  	eb=b[30:23];
  
    ma=a[22:0];
    mb=b[22:0];
    
    bias=ea-eb;
    e=ea;
    s3=a[31];
    
    mb_temp[25:3]=mb;
    ma_temp[25:3]=ma;
    mb_temp[26]=1;
    ma_temp[26]=1;
    mb_temp[27]=0;
    ma_temp[27]=0;
    ma_temp[2:0]=0;
    mb_temp[2:0]=0;
    mb_temp=mb_temp>>bias;
  
    if(bias==2'b00)
      mb_temp[27:3]=(~mb_temp[27:3])+1;
    else if(bias==2'b01)
      mb_temp[27:2]=(~mb_temp[27:2])+1;
    else if(bias==2'b10)
      mb_temp[27:1]=(~mb_temp[27:1])+1;
    else if(bias==2'b11)
      mb_temp[27:0]=(~mb_temp[27:0])+1;
    else
      mb_temp=(~mb_temp);
    
    msub=ma_temp+mb_temp;
    
    g=msub[3];
    r=msub[2];
    s0=msub[0];
    s1=msub[1];
    s=s0|s1;
    
   
    p=r&(((~g)&s)|g);
    if(p)
      m1=msub[26:3]+1;
    else
      m1=msub[26:3];
    
    for(l=0;l<25;l=l+1)
    begin
    if(~m1[23])
        begin
        if(m1!=0)
        begin
          m1=m1<<1;
          e=e-1;
          if(m1[23])
          begin
          break;
          end
        end
      else
        m1=m1;
        end
        end
   
    m_f=m1[22:0];
      
      
      
    //$strobe("%b,%b,%b",s3,e,m_f);
   end
   
   assign c[31]=s3;
   assign c[30:23]=e;
   assign c[22:0]=m_f;
   
endmodule
