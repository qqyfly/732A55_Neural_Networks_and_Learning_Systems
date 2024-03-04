function [V, L, I] = sorteig(M)
% SORTEIG  Sorted Eigenvalues and Eigenvectors
%          SORTEIG(M) is a matrix whose columns are the eigenvectors of M 
%          sorted in descending order according to their respective 
%          eigenvalues.
%
%          [V, L] = SORTEIG(M) produces a matrix V with eigenvectors and 
%          a vector L with corresponding eigenvalues of M. The eigenvalues 
%          and  eigenvectors are sorted so that the first column of V is the 
%          eigenvector corresponding to the largest eigenvalue and so on.
%
%          See allso EIG.

[V, D] = eig(M);	% get egenvectors and eigenvalues
[L, I] = sort(diag(D), 'descend');
V = V(:,I);
