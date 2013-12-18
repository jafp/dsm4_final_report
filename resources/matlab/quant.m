function y=quant(x,A,bits)
% x: input array
%bits: number of bits in the quantization => 2^(bits)
% divisions in the dynamic range [-A,A]
% A may be determined automatically as max|x|( input a 0 for A) or as a max
% range directly
% start here
if A==0
   A=max(abs(x));
end
delta=2*A/2^bits;%width of divisions
%the computation here complies with mid-tread quantization of the 2^(bits)
%divisions of [-A;A]
y=(x<=-A+delta/2)*(-A)+((x>-A+delta/2)&(x<=A-delta/2)).*round(x/delta)*delta+(A-delta)*(x>A-delta/2);
