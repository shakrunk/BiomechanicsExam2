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
%  - force      || Force units - N or lbs
%  - distance   || Distance units - m or in
%  - area       || Area units - m^2 or in^2
%  - pressure   || Pressure or stress units - Pa (N/m^2) or psi (lbs/in^2)
%  - temp       || Tepmerature units - °C (°K-273.15) or °F
%  - na         || Unitless value
% -------------------------------------------------------------------------
function [defMTot] = int_def (P,L,A1,A2,E1,E2,step)
    % P - Applied load                                  || u:force
    % L - Height of cylinder                            || u:distance
    % A1 - Crosssectional area (near)                   || u:area
    % A2 - Crosssectional area (end)                    || u:area
    % E1 - Young's Modulus of material (near)           || u:pressure
    % E2 - Young's Modulus of material (end)            || u:pressure
    % step - Number of integration steps                || u:na
    
    % Calculate Neccessary Variables
    % - Change in:
    deltA = A2-A1; % area from near to end              || u:area
    deltE = E2-E1; % modulus from near to end           || u:pressure
    
    % - Differential change in:
    dA = deltA/step; % area                             || u:area
    dE = deltE/step; % modulus                          || u:pressure
    dL = L/step; % height                               || u:distance
    
    % Loop Prep
    defMTot = 0; % Create variable for total mechanical deformation
        
    % Loop through integration steps
    for i = 1: 1: step

        % Area - Left and Right
        unitA1 = A2 - dA*i;  % Area on the left         || u:area
        unitA2 = A2 - dA*(i-1); % Area on the right     || u:area

        % Modulus - Left and Right
        unitE1 = E2 - dE*i;  % Modulus on the left      || u:pressure
        unitE2 = E2 - dE*(i-1);  % Modulus on the right || u:pressure

        % Calculate differential change in deformation
        unitMDef1 = defCylinder(P,dL,unitA1,unitE1); % Right
        unitMDef2 = defCylinder(P,dL,unitA2,unitE2); % Left
        dMDef = (unitMDef1 + unitMDef2)/2; % Midpoint

        % Update Total Mechanical Deformation
        defMTot = defMTot + dMDef; %                    || u:distance
    end
end
