%% Numerically find integral of [P / A(x) E(x)] dx (if needed)
% Author(s): 
%  - Neil A. Kumar
%  - Linea Gutierrez
%  - Elise Carter
% Dependancies:
%  - defCylinder.m
% -------------------------------------------------------------------------
% All units are generalizable to both SI or U.S. customary units (use only
% one) and are represented with "u:" followed by the unit type:
%  - force     || Force units - N or lbs
%  - distance  || Distance units - m or in
%  - area      || Area units - m^2 or in^2
%  - pressure  || Pressure or stress units - Pa (N/m^2) or psi (lbs/in^2)
%  - na        || Unitless value
% -------------------------------------------------------------------------
% Note: Needs modulus change
function [defTot] = int_def (P,L,A1,A2,E1,E2,step)
    % P - Applied load                                  || u:force
    % L - Height of cylinder                            || u:distance
    % A1 - Crosssectional area (near)                   || u:area
    % A2 - Crosssectional area (end)                    || u:area
    % E1 - Young's Modulus of material (near)           || u:pressure
    % E2 - Young's Modulus of material (end)            || u:pressure
    % step - Number of integration steps                || u:na
    
    % Calculate Neccessary Variables
    C1 = sqrr(A1/pi); % Radius (near)                   || u:distance
    C2 = sqrr(A2/pi); % Radius (end)                    || u:distance
    deltC = C2-C1; % change in radius from near to end  || u:distance
    dC = deltC/step; % differential change in radius    || u:distance
    dL = L/step; % differential change in height        || u:distance
    
    % Loop Prep
    defTot = 0; % Create variable for total deformation/set to 0
    for i = 1:step % loops through integration steps
        % Midpoint Riemann Sum
        unitC1 = C1 - dC*i; 
        unitC2 = C1 - dC*(i-1);
        unitC = (unitC1 + unitC2)/2;

        A = pi*unitC^2; % crossectional area of unit
        dDef = defCylinder(P,dL,A,E); % differential change in deforamtion
        defTot = defTot + dDef; % update total deformation
    end

end