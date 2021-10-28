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
    UncLoad = 0;
    %conv_mat_MDef = cell(numel(step_vec));
    %conv_mat_TDef = cell(numel(step_vec));
    %step_vec = linspace(5,bar.Nistp,4);
    for i = 1: 1: bar.NElem % loop through elements
        UncLoad = UncLoad + bar.EndLoad(i); % Calculates uncontrained end load
        out.UncLoad(i) = UncLoad;
        step_vec = [bar.Nistp/2, bar.Nistp];
        conv_mat_MDef = cell(2,1);
        conv_mat_TDef = cell(2,1);
        
        figure
        for j = 1: 2
            step = step_vec(j);
            [ UncMDef, UncTDef ] = int_def(UncLoad,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),bar.Alph(i),bar.DeltT(i)-bar.initT,step);
            conv_mat_MDef{j} = UncMDef;
            conv_mat_TDef{j} = UncTDef;
            if j == 2
            out.UncMDef(i) = UncMDef(end);
            out.UncTDef(i) = UncTDef(end);
            end
            x_vals = linspace(0, bar.Leng(i), step);
            plot(x_vals,conv_mat_MDef{j});
            hold on
        end
        title(fprintf('Convergence Plot for Element %s', bar.NElem));
        legend('steps= 10', 'steps = 20')
        % Set up for convergence plots
        
        
%         figure
%         ooop = linspace(0,20, numel(conv_mat_MDef{1}));
%         plot(ooop, conv_mat_MDef{1})
%         title = fprintf('Convergence Plot for Element %s (Problem %s)', bar.NElem, prob_num);
%         title(title)
%         
%         
        
        
        
        % Inconstant Area: integral of [P / A(x) E(x)] dx
        %    linspace(Al, Ar, nsteps)
        %    linspace(0, L2, nsteps)
        %    trapz()
        %    cumtrap()
        
    end
    disp([func, 'Done!']); %lgf
    
%     disp(bar.EndLoad); %DEBUG
%     disp(out.UncLoad); %DEBUG

    %% Reaction Return
    disp([func, 'Calculating Reaction Return...']); %lgf
    TotRxDef = 0;
    rxSumNoLoad = 0;
    for i = 1: 1: bar.NElem % loop through elements
        rxSumNoLoad = rxSumNoLoad + int_def(1,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),0,0,bar.Nistp);
        rxSumNoLoad = rxSumNoLoad(end);
        TotRxDef = TotRxDef - (out.UncMDef(i) + out.UncTDef(i));
    end
    
    % Calculate Reaction Forces
    out.React0 = TotRxDef / rxSumNoLoad;
    out.React1 = - (out.UncLoad(bar.NElem) + out.React0);

    % Calculate reaction deformation of each element    ? why does this say reaction deformation? 
    for i = 1: 1: bar.NElem % loop through elements
        [reactDef, ~] = int_def(out.React0,bar.Leng(i),bar.Area1(i),bar.Area2(i),bar.Modu1(i),bar.Modu2(i),0,0,bar.Nistp);
        reactDef = reactDef(end);
    end

    % Calculate total deformation of each element
    for h = 1: 1: bar.NElem % loop through elements
        out.TotDef(h) = out.UncMDef(h) + out.UncTDef(h);
    end
    disp([func, 'Done!']); %lgf

    %% Put force eq equations into a for loop 
    %  SigmaF = 0
    %  for j = 1:1:bar.NElem
    %   
    
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
