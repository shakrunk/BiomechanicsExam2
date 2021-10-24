function [out] = mech_main (varargin)

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
% out.TotLoad(bar.NElem) - the total internal load (P) in each element
% out.TotDef(bar.NElem) - the total deformation of each element
% out.Stress(bar.NElem) - the average normal stress in each element
%   NOTE: find the stress mid-way through the bar (average the end areas).
%% OUTPUT CAN OPTIONALLY CONTAIN
% out.UncLoad(bar.NElem) - the unconstrained (no reaction) load (P) in each element
% out.UncMDef(bar.NElem) - the unconstrained (no reaction) mechanical deformation of each element
% out.UncTDef(bar.NElem) - the thermal (no reactions) deformation of each element
% out.MecDef(bar.NElem) - the mechanical deformation of each element

end

%% Numerically find integral of [P / A(x) E(x)] dx (if needed)
%function [def] = int_def ([YOU DECIDE WHAT IT NEEDS])
% Perform integration here in subfunction. You'll need to call this a lot, so
% don't just do it multiple times above...

%end

%% Take input of bar mechanical/thermal info
function [bar] = model_input ()

bar.NElem = input('Total # of elements? ');
bar.initT = input('Initial Temperature? ');
bar.Nistp = input('Number of integration steps? ');

for i = 1: 1: bar.NElem
    prompt = sprintf('Bar Element #%2d', i);
    bar.Area1(i) = input([prompt ' area near end = ']);
    bar.Area2(i) = input([prompt ' area far end  = ']);
    bar.Leng(i) = input([prompt ' length = ']);
    bar.Modu1(i) = input([prompt ' modulus near end = ']);
    bar.Modu2(i) = input([prompt ' modulus far end  = ']);
    bar.Alph(i) = input([prompt ' alpha = ']);
    bar.DeltT(i) = input([prompt ' Final Temperature = ']);
    if i == 1
        bar.EndGap = input([prompt ' end gap = ']);
    end
    if i > 1
        bar.EndLoad(i) = input([prompt ' end load = ']);
    else
        bar.EndLoad(1) = 0;
    end
end

yn = input('Save model to .mat file? (y/n) ','s');
if strcmpi(yn,'y')
    name = input('Input model name (no trailing .mat): ','s');
    name = [name '.mat'];
    save (name, 'bar');
end

end