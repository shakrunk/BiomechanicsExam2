function [out] = bardef_main (varargin) % changed function name to match title

    disp('****COMBINED MECHANICAL/THERMAL AXIAL LOADING ANALYSIS****');
    if nargin == 0
        disp('Reading in new bar model');
        bar = model_input;
    else
        disp('Using bar model provided in call');
        bar = varargin{1};
    end
    
    %% DO WORK HERE
    %% Free Deformation
    % Mechanical
    UncLoad = 0;
    for i = 1: 1: bar.NElem % loop through elements
        UncLoad = UncLoad + bar.EndLoad(i); % Calculates uncontrained end load
        out.UncLoad(i) = UncLoad;
        out.UncMDef(i) = Int_def(UncLoad,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Nistp);
    end
%     disp(bar.EndLoad); %DEBUG
%     disp(out.UncLoad); %DEBUG
    % Thermal

    %% Reaction Return
    
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