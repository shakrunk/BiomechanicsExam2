%% Calculate the Thermal Deformation of an Element
% Author(s):
%  - Neil A. Kumar
% Dependancies:
%  - None
% -------------------------------------------------------------------------
% All units are generalizable to both SI or U.S. customary units (use only
% one) and are represented with "u:" followed by the unit type:
%  - force     || Force units - N or lbs
%  - distance  || Distance units - m or in
%  - area      || Area units - m^2 or in^2
%  - pressure  || Pressure or stress units - Pa (N/m^2) or psi (lbs/in^2)
%  - temp      || Tepmerature units - °C (°K-273.15) or °F
%  - na        || Unitless value
% -------------------------------------------------------------------------
function [def] = defThermo(alpha, deltaT, L)
    % alpha - Coef of Thermal Expansion            || u:temp^(-1)
    % deltaT - Change in Temperature               || u:temp
    % L - Height of cylinder                       || u:distance
    
    % thermal deformation formula 
    def = alpha*deltaT*L; % Deformation            || u:distance
end