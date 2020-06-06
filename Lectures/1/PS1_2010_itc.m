%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function firstname_lastname_itc   % Modify with your own name
clc;        % clean up
close all;  %

% Set known quantities
Ninj = 5;      % number of injections - explore what this should best be!
Vinj = 1e-5;   % Vol per injection in L
Vcell = 1e-3;  % Vol of cell in L
 Linj = 1; % Conc of injected ligand solution in M; replace with your value
 Po = 1 % Po in M; replace with your value
 KD = 1 % KD in M; replace with your value
deltaH = -10;

[L,C,Q] = calc_all(Po,Ninj, Linj, Vinj, Vcell,KD,deltaH);
plot_itc_figure(L./Po, Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculates Qi for each injection, and returns arrays of the
% free ligand concentration, complex concentration, and heat
% released or absorbed for all peaks
function [L,C,Q] = calc_all(Po,Ninj, Linj, Vinj, Vcell,KD,deltaH)
% Write code to calculate all Q, i.e. Q(i) for i=1...number of injections
L = [1 2 3];  % dummy numbers - replace with calculations
C = [2 3 4];
Q = [3 4 5];

% Calculates the heat released or absorbed for an individual injection
function Qi = calcQi(deltaH, Vcell, Ci, Cprev)     
   Qi = 1; % replace with your expression

%Calculates fractional saturation
function yeq = fracSat(KD, Lo, Po)
   yeq = 1; % your expression here
   
% Plots the figure. Careful with the units (see below!).
function plot_itc_figure(LP_ratio, Q)
% your code here
xlabel('Ligand to protein ratio');
ylabel('Q / \mucal');

