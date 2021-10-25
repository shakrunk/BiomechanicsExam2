%% Exam 2 Take-Home Portion
% BIOE-3040-H01 Introduction to Biomechanics w/ Prof. Hunter
% Author(s): 
%  - Neil A. Kumar
%  - Linea Gutierrez
%  - Elise Carter
% Dependencies: 
%  - cls.m 
%  - Mixed2.05.mat
%  - Prob2.04.mat
%  - Prob2.05.mat 
%  - Prob2.06.mat
%  - mech_main.m

%% Setup

% Generic Reset
cls; % alias used for ease; does following commands:
        % close all; % close all open windows / plots
        % clear;     % clear the workspace of any variables
        % clc;       % clear the command line

% Formatting and Metadata
format short e;
fprintf("<strong># ~/denkr/Documents/School/UCD/'5. BIOE.3020.H01 - BioMechanics'/Matlab/BiomechanicsExam2 m</strong>\n");
fprintf("<strong># File: run.m</strong>\n");
fprintf("<strong># Title: Exam 2 Take-Home Portion</strong>\n");
fprintf("<strong># Authors: Neil A. Kumar, Linea Gutierrez, and Elise Carter</strong>\n");
fprintf("<strong># Dependencies:</strong> cls.m | Mixed2.05.mat | Prob2.04.mat | Prob2.05.mat | Prob2.06.mat | mech_main.m\n");

%% Program Main

% Load in example models
fprintf('\n- Loading in example models -\n'); % Look good formatting (lgf)
bar(1) = load('Example Models/Prob2.04.mat').bar;   fprintf('Prob2.04.mat loaded into bar(1)\n'); %lgf
bar(2) = load('Example Models/Prob2.05.mat').bar;   fprintf('Prob2.05.mat loaded into bar(2)\n'); %lgf
bar(3) = load('Example Models/Mixed2.05.mat').bar;  fprintf('Mixed2.05.mat loaded into bar(3)\n'); %lgf
bar(4) = load('Example Models/Prob2.06.mat').bar;   fprintf('Prob2.06.mat loaded into bar(4)\n'); %lgf

for i = 1:4
    out(i) = mech_main(bar(i));
    fprintf('mech_main run on barmodel %i\n', i);
end

%% Progam End

fprintf("\n<strong>## End of Progam</strong>\n");

%% Program Workspace / Debug Station
    % A place to mess around with ideas if unsure where it will be placed
    % organizationally. Ideally there should be nothing in this section
    % once the file is complete.
