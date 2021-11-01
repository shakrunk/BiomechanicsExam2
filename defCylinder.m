%% Calculate the Mechanical Deformation of a Cylinder
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
function [def] = defCylinder(P,L,A,E)
    % P - Applied load                          || u:force
    % L - Height of cylinder                    || u:distance
    % A - Crosssectional area of cylinder       || u:area
    % E - Young's Modulus of cylinder material  || u:pressure
    
    % axial deformation formula 
    def = (P*L)/(A*E); % Deformation            || u:distance
end