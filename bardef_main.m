function [out] = mech..main (varargin)

% Function is a recreation by Neil A. Kumar of file by Dr. Kendall Hunter
% Shown in Lecture 18 - 10/21. Use for preperatory work only.

disp('****COMBINED MECHANICAL/THERMAL AXIAL LOADING ANALYSIS****');
if nargin == 0
	disp('Reading in new bar model');
	bar = model_input;
else
	disp('Using bar model provided in call');
	bar = varargin{1};
end

%% DO WORK HERE

%% OUTPUT SHOULD CONTAIN 
% out.React0 - reaction at right side
% out.React1 - reaction at left side
% out.TotLoad(bar.NE1em) - the total internal load (P) in each element
% out.TotDef(bar.NE1em) - the total deformation of each element
% out.Stress(bar.NE1em) - the average normal stress in each element
%   Note: find the stress mid-way through the bar (average the end areas)
%% OUTPUT CAN OPTIONALLY CONTAIN
% out.UncLoad(bar.NE1em) - the unconstrained (no reaction) load (P) in each element
% out.UncMDef(bar.NE1em) - the unconstrained (no reaction) mechanical deformation of [Neil guessed completion]: each element
% out.UncTDef(bar.NE1em) - the thermal (no reaction) deformation of each element

end

%% Numerically find integral of [P / A(x) E(x)] dx (if needed)
%function [def] = int_def ([YOU DECIDE WHAT IT NEEDS])
% Perform integration here in subfunction. You'll need to call this a lot, so
% don't just do it multiple times above...

%end

%% Take input of bar mechanical/thermal info
function [bar] = model_input ()

bar.NE1em = input('Total # of elements? ');
bar.initT = input('Initial Temperature? ');
bar.Nistp = input('Number of integration steps? ');

for i = 1: 1: bar.NE1em
    prompt = sprintf('Bar Element #%2d', i);
    bar.Area1(i) = input([prompt ' area near end = ']);
    bar.Area2(i) = input([prompt ' area far end = ']);
    bar.Leng(i) = input([prompt ' length = ']);
    bar.Modu1(i) = input([prompt ' modulus near end = ']);
    bar.Modu2(i) = input([prompt ' modulus far end = ']);
