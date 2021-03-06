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
%  - Graded_Bar1.mat
%  - Graded_Bar2.mat
%  - mech_main.m

%% Setup

% Generic Reset
cls; % alias used for ease; does following commands:
        % close all;          % Close all open windows / plots
        % clear;              % Clear the workspace of any variables
        % format short e;     % Reset command window formatting
        % clc;                % Clear the command line

% Formatting and Metadata
fprintf("<strong># ~/denkr/Documents/School/UCD/'5. BIOE.3020.H01 - BioMechanics'/Matlab/BiomechanicsExam2 m</strong>\n");
fprintf("<strong># File: run.m</strong>\n");
fprintf("<strong># Title: Exam 2 Take-Home Portion</strong>\n");
fprintf("<strong># Authors: Neil A. Kumar, Linea Gutierrez, and Elise Carter</strong>\n");
fprintf("<strong># Dependencies:</strong> cls.m | Mixed2.05.mat | Prob2.04.mat | Prob2.05.mat |\n                Prob2.06.mat | Graded_Bar1.mat | Graded_Bar2.mat |\n                mech_main.m\n");

%% Program Main

% Load in example models
fprintf('\n- Loading in example models -\n'); % Look good formatting (lgf)
bar(1) = load('Example Models/Prob2.04.mat').bar;   fprintf('Prob2.04.mat loaded into bar(1)\n'); %lgf
bar(2) = load('Example Models/Prob2.05.mat').bar;   fprintf('Prob2.05.mat loaded into bar(2)\n'); %lgf
bar(3) = load('Example Models/Prob2.06.mat').bar;   fprintf('Prob2.06.mat loaded into bar(3)\n'); %lgf
bar(4) = load('Example Models/Mixed2.05.mat').bar;  fprintf('Mixed2.05.mat loaded into bar(4)\n'); %lgf

% Load in graded models
gradbar(1) = load('Graded Models/Graded_Bar1.mat').bar; 
gradbar(2) = load('Graded Models/Graded_Bar2.mat').bar; 

% Add graded models to bar (removes redundant fields)
bar(5) = rmfield(gradbar(1),'comment'); fprintf('Graded_Bar1.mat loaded into bar(5)\n'); %lgf
bar(6) = rmfield(gradbar(2),'comment'); fprintf('Graded_Bar2.mat loaded into bar(6)\n'); %lgf

for i = 1: 1: length(bar)
    fprintf('\nRunning mech_main.m on bar model %i\n', i); %lgf
    out(i) = mech_main(bar(i));
    fprintf('\n Output for bar(%d) \n', i) 
    disp(out(i));
end

%% Prove Convergence for a Bar (Problem 2.05)
% Prove convergence by changing step size
fprintf('\n -Proving Convergence- \n'); %lgf

% Load prob 2.05
convbar = load('Example Models/Prob2.05.mat').bar;

% Store original solve structure in a cell
fprintf('\nRunning mech_main.m on convergence bar model 1\n'); %lgf
convbar_out{1} = mech_main(convbar);

% Define original number of steps (Nistp)
step_original = convbar.Nistp;

% Define new number of steps to be tested
step_new = step_original * 100;

% Set Nistp equal to 200 steps and solve
fprintf('\nRunning mech_main.m on convergence bar model 2\n'); %lgf
convbar.Nistp = step_new;
convbar_out{2} = mech_main(convbar);

% Relative error between bar elements with 20 and 2000 steps
rel_error = (convbar_out{1}.UncMDef - convbar_out{2}.UncMDef) ./ convbar_out{1}.UncMDef;
tol = 1e-6; % tolerance 

if any(rel_error > tol) % relative error greater than tolerance
    fprintf('\n Does not converge with original step size. Original Step Size Insufficient \n'); %lgf
else % relative error less than tolerance
     fprintf('\n Convergence Proved! Original Step Size Sufficient \n'); %lgf
end

% EXPLANATION: convbar_out.UncMDef is assigned to the output of the first 
% time our integration funtion is used in mech_main. If the relative error  
% between UncMDef when solved with original Nistp value is within a tolerance (1e-6) of
% UncMDef solved with Nistp*100 steps, it is concluded that solving with 
% the original step size does indeed converge within the integration function.

%% Progam End

fprintf("\n<strong>## End of Progam</strong>\n");

    
