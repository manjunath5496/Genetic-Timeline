

function PS4FeedbackMAPK()

clc;
close all;

k=[0.4;   % v1 / nM s^-1 
   0.25;  % v2 / nM s^-1
   0.025; % k3 / s^-1
   0.025; % k4 / s^-1
   0.75;  % v5 / nM s^-1
   0.75;  % v6 / nM s^-1
   0.025; % k7 / s^-1
   0.025; % k8 / s^-1
   0.5;   % v9 / nM s^-1
   0.5];  % v10 / nM s^-1

KM=[10; % all in nM
    8;
    15;
    15;
    15;
    15;
    15;
    15;
    15;
    15];

Feedback=0.1; % nM^-1

n=1; % Hill coefficient

yo=[100; % y1 = MKKK; all in nM
    0;   % y2 = MKKK-p
    300; % y3 = MKK
    0;   % y4 = MKK-p
    0;   % y5 = MKK-pp
    300; % y6 = MAPK
    0;   % y7 = MAPK-p
    0];  % y8 = MAPK-pp
 


% b) Plot system response to step stimulus with and without negative
%    feedback

tspan=[0 7200];
k(1)=10; % strength of input stimulus
Feedback=0; % Try 0 vs. 100; plot in same graph
[TOUT1,YOUT1] = ode23s(@CascadeFB, tspan, yo,[],k,KM,Feedback,n);
activatedERK_no_FB = YOUT1(:,8);
Feedback=100;

% your code here

figure();
plot(TOUT1./60,activatedERK_no_FB, 'k-', TOUT2./60,activatedERK_with_FB, 'k--', 'LineWidth', 2);
    legend('No feedback','With feedback','Location','NorthEast');
    title('Negative feedback in the MAPK cascade','FontSize', 16, 'FontWeight', 'bold');
    xlabel ('Time / min','FontSize', 12, 'FontWeight', 'bold');
    ylabel ('[Erk-pp] / nM', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca,'FontSize',12, 'FontWeight', 'bold');

% c) Adjust parameters, repeat
k(1)=2; % strength of inout stimulus
Feedback=0.15;
yo(1)=50;  % y1 = MKKK
yo(3)=150; % y3 = MKK
yo(6)=150; % y6 = MAPK    

% your code here



% d) i) Draw bifurcation diagram:
%     1) Vary v1
%     2) For each v1, let system evolve for 10 000 s
%     3) Record and plot min and max [Erk-pp] between 5 000 - 10 000 s.
%        Plot the data as points, not lines.
%
% HINT: Let system evolve for 5 000 s. Use endpoint concentrations as
%       initial conditions for another 5 000 s run. Then extract the min
%       and max values from this second run only.
v1range=linspace(0,6,100); % reasonable range to iterate over

% your code here



% iii) Plot Erk-pp as a function of time in response to stimuli of different
% strengths

% your code here




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dydt = CascadeFB(t,y,k,KM,Feedback,n)  

%KI = 1/Feedback;

% Pre-calculate terms for rate equations
r1  = k(1)*y(1)/((1+(y(8)*Feedback)^n)*(KM(1)+y(1)));
r2  = k(2)*y(2)/(KM(2)+y(2));
r3  = k(3)*y(2)*y(3)/(KM(3)+y(3));
r4  = k(4)*y(2)*y(4)/(KM(4)+y(4));
r5  = k(5)*y(5)/(KM(5)+y(5));
r6  = k(6)*y(4)/(KM(6)+y(4));
r7  = k(7)*y(5)*y(6)/(KM(7)+y(6));
r8  = k(8)*y(5)*y(7)/(KM(8)+y(7));
r9  = k(9)*y(8)/(KM(9)+y(8));
r10 = k(10)*y(7)/(KM(10)+y(7)); 

% Calculate derivatives
dydt=[r2-r1;        % y1 = MKKK
      r1-r2;        % y2 = MKKK-p
      r6-r3;        % y3 = MKK
      r3+r5-r4-r6;  % y4 = MKK-p
      r4-r5;        % y5 = MKK-pp
      r10-r7;       % y6 = MAPK
      r7+r9-r8-r10; % y7 = MAPK-p
      r8-r9];       % y8 = MAPK-pp
      
    


