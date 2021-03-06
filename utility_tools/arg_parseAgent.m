function [error_flag,options] = arg_parse ( options, varargin)

% arg_parse ( options, varargin) -Parse and decode variable number of inputs
% options must be cell array of form:
% { {options1 default1} {option2 default2} ... } 
% $Revision: 1.1 $

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

% Set default values
error_flag=0;
nopt=length(options);
 for i=1:nopt,
   names{i} = lower((char(options{i}(1,1))));
   defaults(i)=options{i}(1,2);
%  assignin ('caller',char(names{i}), defaults{i});
 end
if nargin == 1 | length(varargin{1})==0,
   return
end

% Take care of nested calls with variable number of parameters
% where args appear as one element of a cell array

while length(varargin)==1 & iscell (varargin{1}),
  varargin=varargin{1};
end
narg=length(varargin);
if length(varargin) > 0 & strcmp('?',varargin(1)),
   s=dbstack;
   arg_help(s(1).name, options);
   error_flag=1;
   return
end

%
% Parse variable arguments
%
for i=1:2:narg,
  choice=lower((char(varargin{i})));
  j=find(strncmp(choice, names, length(choice)));
  if j > 0,
     options{j}{2} = varargin{i+1};
  else
   	 disp (['Invalid option:' choice]);
     vararg_help(options);
     error(['Bad Option:' choice]);
   end
end

function vararg_help (options)
fprintf (1, '\nOptions are:')
for i=1:length(options),
   fprintf(1,'\n\t');
   fprintf(1,'%c',char(options{i}(1,1)))
end
fprintf(1,'\n');
return