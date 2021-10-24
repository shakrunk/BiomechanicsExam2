%% Exam 2 Take-Home Portion
% BIOE-3040-H01 Introduction to Biomechanics w/ Prof. Hunter
% By Neil A. Kumar, Linea Gutierrez, and Elise Carter

%% Setup

% Generic Reset
cls; %alias used for ease; does following commands:
        % close all; % close all open windows / plots
        % clear;     % clear the workspace of any variables
        % clc;       % clear the command line

% Formatting and Metadata
format long g;
fprintf("<strong># ~/denkr/Documents/School/UCD/'5. BIOE.3020.H01 - BioMechanics'/Matlab/BiomechanicsExam2 m</strong>\n");
fprintf("<strong># File: run.m</strong>\n");
fprintf("<strong># Title: Exam 2 Take-Home Portion</strong>\n");
fprintf("<strong># Authors: Neil A. Kumar, Linea Gutierrez, and Elise Carter</strong>\n");

%% Program Main

% Load in example models
fprintf('\n- Loading in example models -\n'); % Look good formatting (lgf)
bar4 = load('Example Models/Prob2.04.mat');        fprintf('Prob2.04.mat loaded into bar4\n'); %lgf
bar5 = load('Example Models/Prob2.05.mat');        fprintf('Prob2.05.mat loaded into bar5\n'); %lgf
bar5mix = load('Example Models/Mixed2.05.mat');    fprintf('Mixed2.05.mat loaded into bar5mix\n'); %lgf
bar6 = load('Example Models/Prob2.06.mat');        fprintf('Prob2.06.mat loaded into bar6\n'); %lgf

%% Progam End

fprintf("\n<strong>## End of Progam</strong>\n");

%% Program Functions

%% Program Workspace / Debug Station
    % A place to mess around with ideas if unsure where it will be placed
    % organizationally. Ideally there should be nothing in this section
    % once the file is complete.