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
   
    if gap == 0 
        continue;
    if gap ~= 0 % statically determinent 
        disp("Equation is statically indeterminate")
        
    % make sure that the gap is closed by deformations, if it closes, it is statically indeterminent again
    
    
    %% Free Deformation
    % Mechanical / Thermal
    disp([func, 'Calculating Free Deformation...']); %lgf
    UncLoad = 0;
    for i = 1: 1: bar.NElem % loop through elements
        UncLoad = UncLoad + bar.EndLoad(i); % Calculates uncontrained end load 
        out.UncLoad(i) = UncLoad; % the unconstrained (no reaction) load (P) in each element

        out.UncMDef(i) = int_def(UncLoad,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Nistp);
        out.UncTDef(i) = defThermo(bar.Alph(i),bar.DeltT(i)-bar.initT,bar.Leng(i));

        out.UncMDef(i) = int_def(UncLoad,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Nistp);    
        out.UncTDef(i) = defThermo(bar.Alph(i),bar.DeltT(i)-bar.initT, bar.Leng(i));
    end
    disp([func, 'Done!']); %lgf
    
%     disp(bar.EndLoad); %DEBUG
%     disp(out.UncLoad); %DEBUG

    %% Reaction Return
    disp([func, 'Calculating Reaction Return...']); %lgf
    TotRxDef = 0;
    rxSumNoLoad = 0;
    for i = 1: 1: bar.NElem % loop through elements
        rxSumNoLoad = rxSumNoLoad + int_def(1,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Nistp);
        TotRxDef = TotRxDef - (out.UncMDef(i) + out.UncTDef(i));
    end
    
    % Calculate Reaction Forces
    out.React0 = TotRxDef / rxSumNoLoad;
    out.React1 = - (out.UncLoad(bar.NElem) + out.React0);

    % Calculate reaction deformation of each element
    for i = 1: 1: bar.NElem % loop through elements
        reactDef = int_def(out.React0,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Nistp);
    end
    % Total = sum
    
    % Calculate total deformation of each element
    for h = 1: 1: bar.NElem % loop through elements
        out.TotDef(h) = out.UncMDef(h) + out.UncTDef(h);
    end
    disp([func, 'Done!']); %lgf
    
    %% Calculate total internal load in each element
    for j = 1: 1: bar.NElem
        out.TotLoad(j) = out.React0 + out.UncLoad(j);
    end
     
    %% Average normal stress in each element
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
