`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2023 09:13:47
// Design Name: 
// Module Name: fadd_single
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
module  fadd_single(a1,b1,c);

input logic [31:0]a1;//=32'b01000000000100000000000000000111;
input logic [31:0]b1;//=32'b01000001111100000000000000000011;
output logic [31:0]c;
  
  logic[31:0]temp;//a,b,temp;
  logic[7:0]ea,eb,bias,e;
  logic[22:0]ma,mb,m_f;
  logic[27:0]ma_temp,mb_temp,m_add,m_temp,m_temp1;
  bit[24:0]m1;
  logic g,r,s0,s1,s,p,s3;
 logic [31:0]a;//=32'b01000000000100000000000000000111;
 logic [31:0]b;//=32'b01000001111100000000000000000011;
  
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
    
  	ea=a[30:23];
  	eb=b[30:23];
  
    ma=a[22:0];
    mb=b[22:0];
    
    bias=ea-eb;
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
    m_add=ma_temp+mb_temp;
    
    e=m_add[27]?(ea+1):ea;
    m_temp[25:0]=m_add[27]?m_add[26:1]:m_add[25:0];
    m_temp[26]=1;
    m_temp[27]=0;
    
    //m_temp1=m_temp[27]?(m_temp>>1):m_temp;
   // e=m_temp[27]?(e+1):e;
    
    g=m_temp[3];
    r=m_temp[2];
    s0=m_temp[0];
    s1=m_temp[1];
    s=s0|s1;
    
   // m1[24:0]=r?(s?(m_temp[27:3]+1):(g?(m_temp[27:3]+1):(m_temp[27:3]))):(m_temp1[27:3]);
    p=r&(((~g)&s)|g);
    if(p)
      m1=m_temp[27:3]+1;
    else
      m1=m_temp[27:3];
    
    if(ea==eb)
      m_f=m_add[27]?m1[22:0]:m1[23:1];
    else
      m_f=m1[24]?(m1[23:1]):m1[22:0];
    
    
    e=m1[24]?(e+1):e;
    
    //$strobe("%b,%b,%b",s3,e,m_f);
    end
    
    assign c[31]=s3;
    assign c[22:0]=m_f;
    assign c[30:23]=e;
endmodule
