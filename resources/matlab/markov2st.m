function [y,p,H]=markov2st(P,N);
% production of a 1. order markov chain of length N
% P the state transition matrix
% In this edition: 2 states (as in ex. of Harris note)
%p:the computed symbol-probabilities
%H: the Entropy computed as in Harris
%start here
p(2)=0; % space for symbol probabilities to be computed
[V,D]=eig(P);% computation of eigenvalues in D and eigenvecors in V
[r,c]=find(D==1);% find the index of eigenvalue 1
 % they are the same, so...only the first
p(1)=V(1,r)/(V(1,r)+V(2,r)); % sum =1
p(2)=V(2,r)/(V(1,r)+V(2,r));% now p(1)+p(2)=1

H0=-(P(1,1)*log2(P(1,1))+P(2,1)*log2(P(2,1)));% conditional entropies
H1=-(P(1,2)*log2(P(1,2))+P(2,2)*log2(P(2,2)));%      "          "
H=H0*p(1)+H1*p(2); % and this is the the expected value of H... (Average)
x=rand(1,N);
y=zeros(1,N);%memory space for the sequence
if x(1)<=p(1)
   y(1)=0;  
else 
   y(1)=1;
end
for i=2:N
   switch y(i-1)% just to ensure integers..
   
   case {0}
      if x(i)<=P(1,1)
         y(i)=0;% stay in 0
      else
         y(i)=1;% or shift
      end
   case {1}
      if x(i)<=P(2,2)
         y(i)=1;
      else
         y(i)=0;
      end
   end
end;
