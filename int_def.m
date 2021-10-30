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
function [defMTot, defTTot] = int_def (P,L,A1,A2,E1,E2,alpha,deltaT,step)
    % P - Applied load                                  || u:force
    % L - Height of cylinder                            || u:distance
    % A1 - Crosssectional area (near)                   || u:area
    % A2 - Crosssectional area (end)                    || u:area
    % E1 - Young's Modulus of material (near)           || u:pressure
    % E2 - Young's Modulus of material (end)            || u:pressure
    % alpha - Coef of Thermal Expansion                 || u:temp^(-1)
    % deltaT - Change in Temperature                    || u:temp
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
    defTTot = 0; % Create variable for total thermal deformation
        
    % Loop through integration steps
    for i = 1:n

        % Midpoint Riemann Sum - Midpoint Area
        unitA1 = A1 - dA*i;  % Area on the left || u:area
        unitA2 = A1 - dA*(i-1); % Area on the right
        A = (unitA1 + unitA2)/2; % midpoint

        % Midpoint Riemann Sum - Midpoint Modulus
        unitE1 = E1 - dE*i; 
        unitE2 = E1 - dE*(i-1);
        unitE = (unitE1 + unitE2)/2;

        % Calculate differential change in deformation
        dMDef = defCylinder(P,dL,A,unitE);      % Mechanical

        dTDef = alpha*deltaT*dL;                % Thermal, this does not need to be integrated, it should be multiplied by length of each element

        % Update Total Deformation
        defMTot = defMTot + dMDef;              % Mechanical
        defTTot = defTTot + dTDef;              % Thermal

    end
      % disp(['n = ', n, 'Mechanical Deformation: ', defMTot,'Thermal Deformation', defTTot, 'Done!']) 
    end
end
