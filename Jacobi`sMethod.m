close all; clear all; clc; format long;
% date de intrare
A = [7 -0.28 3.5; 0.81 -3 0.03; 5 -4 -20];
b = [-2.8;0.3;4];
eps = 10^(-4);
alpha = zeros(size(A));
beta = zeros(size(A,1),1);
k = 1;
% alpha
for i = 1:size(A);
 for j = 1:size(A)
 if (i~=j)
alpha(i,j) = - A(i,j)/A(i,i);
 end
 end
end
% beta
for i = 1:size(A)
 beta(i) = b(i)/A(i,i);
end
% norma infinit alpha
for i=1:size(A)
 s(i)=0;
for j = 1:size(A)
 s(i) = s(i)+abs(alpha(i,j));
end
end
 norma_a = max(s);
% norma infinit beta
 norma_b = max(abs(beta));
% nr. min de iteratii
 k_min = floor(log(eps*(1-norma_a)/norma_b)/log(norma_a));
 x(:, 1)=beta;
while(k <= k_min)
 x(:,k+1)= alpha*x(:,k)+beta;
 k=k+1;
end