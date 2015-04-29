 function [A,C]  =  destac(R,n) 
  
% destac   Estimates the A and C matrices of a LTI state 
%          space model form using the result of the preprocessor 
%     routines dordxx (dordom, dordpo, etc.) 
%          General model structure: 
%              x(k+1) = Ax(k) + Bu(k)+ w(k) 
%              y(k)   = Cx(k) + Du(k)+ v(k) 
%          For more information about the disturbance properties see 
%          the help pages for the preprocessor dordxx functions. 
% 
% Syntax: 
%          [A,C] = destac(R,n); 
% 
% Input: 
%   R      Data structure obtained from dordxx, containing the 
%          triangular factor and additional information 
%          (such as i/o dimension etc.) 
%   n      Order of system to be estimated. 
% 
% Output: 
%   A,C    Estimated system matrices. 
% 
% See also: dordom, dordpi, dordpo, dordeiv. 
% 
 
%  --- This file is generated from the MWEB source dmoesp.web --- 
% 
% Bert Haverkamp November 1999 
% Copyright (c) 1999, Bert Haverkamp 
 
 
 
 if nargin==0 
  help destac 
  return 
end 
 if ~isempty(R) 
  if ~isstruct(R) 
    error('R should be a stucture, generated by dordxx.') 
  end 
  if isfield(R,'m') 
    m = R.m; 
    if (m<0) 
      error('Illegal value for number of inputs in R.m') 
    end 
  else 
    error('The field R.m does not exist.') 
  end 
  if isfield(R,'l') 
    l = R.l; 
    if (l<0) 
      error('Illegal value for number of outputs in R.l') 
    end 
  else 
    error('The field R.l does not exist.') 
  end 
  if isfield(R,'i') 
    i = R.i; 
    if (i<3) 
      error('Illegal value for the block matrix parameter in R.i') 
    end 
  else 
    error('The field R.i does not exist.') 
  end 
  if isfield(R,'Un') 
    Un = R.Un; 
    il  =  i * l; 
    if ~(all(size(Un)==[il,il])) 
      error('The field R.Un has wrong size.') 
    end 
  else 
      error('The field R.Un does not exist.') 
    end 
  end 
 
 
 if (n>i * l) 
  error(['The order is too large. It should be smaller than i times #outputs.l']) 
end 
 
 
 
if (n>i * l) 
  error(['The order is too large. It should be smaller than i times #outputs.l']) 
end 
 
 
 % find A and C 
A  =  Un(1:il-l,1:n)\ Un(l+1:il,1:n); 
C  =  Un(1:l,1:n); 
 
 
 
 
 
