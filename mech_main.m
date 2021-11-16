%% Numerically find integral of [P / A(x) E(x)] dx (if needed)
% Author(s): 
%  - Neil A. Kumar
%  - Linea Gutierrez
%  - Elise Carter
%  - Dr. Kendall Hunter (provided template/examples, assumed)
% Dependancies:
%  - model_input.m
%  - int_def.m
% -------------------------------------------------------------------------
% All units are generalizable to both SI or U.S. customary units (use only
% one) and are represented with "u:" followed by the unit type:
%  - force     || Force units - N or lbs
%  - distance  || Distance units - m or in
%  - area      || Area units - m^2 or in^2
%  - pressure  || Pressure or stress units - Pa (N/m^2) or psi (lbs/in^2)
%  - na        || Unitless value
% -------------------------------------------------------------------------
function [out] = mech_main (varargin)
    %% Initialize
    disp('****COMBINED MECHANICAL/THERMAL AXIAL LOADING ANALYSIS****');
    func = sprintf('mech_main.m || '); %Look good formatting (lgf)
    if nargin == 0
        disp([func, 'Reading in new bar model']);
        bar = model_input;
    else
        disp([func, 'Using bar model provided in call']);
        bar = varargin{1};
    end    
    
    %% Free Deformation
    % Mechanical / Thermal
    disp([func, 'Calculating Free Deformation...']); %lgf
    
    % Loop setup
    UncLoad = 0;
    FreeDefSum = 0;
    for i = 1: 1: bar.NElem % loop through elements
        UncLoad = UncLoad + bar.EndLoad(i); % Calculates uncontrained end load 
        out.UncLoad(i) = UncLoad; % the unconstrained (no reaction) load (P) in each element

        % Calculate unconstrained mechanical deformation and store output
        out.UncMDef(i) = int_def(UncLoad,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Nistp);

        % Calculate unconstrained thermal deformation and store output
        out.UncTDef(i) = defThermo(bar.Alph(i),bar.DeltT(i)-bar.initT,bar.Leng(i));
        
        FreeDefSum = FreeDefSum + out.UncMDef(i) + out.UncTDef(i);
    end
    disp([func, 'Done!']); %lgf
    
    %% Check Gap
    disp([func, 'Checking if there is a gap...']); %lgf
    if bar.EndGap ~= 0
        disp([func,'Gap, problem may be statically determinate...']); %lgf
        if bar.EndGap <= FreeDefSum
            disp([func,'Gap closed. Indeterminate']); %lgf
        else 
            disp([func,'Gap not closed. Determinate']); %lgf
        end
    else
        disp([func, 'No Gap']);
    end
    disp([func, 'Done!']); %lgf

    %% Reaction Return
    disp([func, 'Calculating Reaction Return...']); %lgf
    TotRxDef = 0;
    rxSumNoLoad = 0;
    
    % We're getting this wrong on the problems that have a gap
    
    for i = 1: 1: bar.NElem % loop through elements
        rxSumNoLoad = rxSumNoLoad + int_def(1,bar.Leng(i), bar.Area1(i), bar.Area2(i), bar.Modu1(i), bar.Modu2(i), bar.Nistp);
        TotRxDef = TotRxDef - (out.UncMDef(i) + out.UncTDef(i));
    end
    
    % Calculate Reaction Forces
    out.React0 = (TotRxDef + bar.EndGap) / rxSumNoLoad;
    out.React1 = - (out.UncLoad(bar.NElem) + out.React0);
    
    ReactDef = 0
    % Calculate reaction deformation of each element
    for i = 1: 1: bar.NElem % loop through elements
        ReactDef(i) = int_def(out.React0,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Nistp);

        out.MecDef(i) = out.UncMDef(i) + ReactDef(i);
        out.TotDef(i) = out.UncMDef(i) + out.UncTDef(i) + ReactDef(i); 
    end
    disp([func, 'Done!']); %lgf
    
    % Calculate total internal load in each element
    for j = 1: 1: bar.NElem
        out.TotLoad(j) = out.React0 + out.UncLoad(j);
    end
     
    % Average normal stress in each element
    for k = 1: 1: bar.NElem
        AvgArea = (bar.Area1 + bar.Area2) ./ 2;
        out.Stress(k) = out.TotLoad(k) ./ AvgArea(k);
    end
     
    
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
    disp('****END OF ANALYSIS****');
end
