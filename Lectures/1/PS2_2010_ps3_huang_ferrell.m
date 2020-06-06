
%E1 = Ras-GTP
%E2 = RAF Phosphatase
%cx = complex
%P = phosphate (PO4)
%PP = two phosphates
%* = activated
%Pase = phosphatase enzyme (so MEKPase is MEK phosphatase)

%initial conditions, all from Huang & Ferrell, 1996
RAF = 0.003;       %uM
RAFstar = 0;       %uM, initially no activated RAF
RAFstar_cx = 0;    %uM, initially no RAF* complex
RAFstar1_cx = 0;   %uM, initially no RAF* complex
MEK = 1.2;         %uM
MEKp = 0;          %uM, initially no phosphorylated MEK
MEKpp = 0;         %uM, initially no phosphorylated MEK
MEKpp_cx = 0;      %uM
MEKpp1_cx = 0;     %uM, initially no phosphorylated MEK complex
ERK = 1.2;         %uM
ERKp = 0;          %uM, initially no phosphorylated ERK
ERKpp = 0;         %uM, initially no phosphorylated ERK
ERKPase = 0.12;    %uM
ERKPase_cx = 0;    %uM, initially no complex
ERKPase1 = 0.12;   %uM
ERKPase1_cx = 0;   %uM, initially no complex
MEKPase = 0.3e-3;  %uM
MEKPase_cx = 0;    %uM, initially no complex
MEKPase1 = 0.3e-3; %uM
MEKPase1_cx = 0;   %uM, initially no complex
E2 = 0.3e-3;       %uM, input stimulus, 10-fold less abundant than its substrate Mos
E2_cx = 0;         %uM
E1 = 1e-2;         %uM, will vary this input stimulus below
E1_cx = 0;         %uM

%parameters
Km = 300;          %nM, Michaelis constant
Vmax = 150;        %nM s^-1, from Michaelis Menten

E1 = logspace(-6, -1, 100);     %uM

params = [E2,0,ERK,ERKp,ERKpp,MEK,MEKp,MEKpp,RAF,RAFstar,MEKPase,MEKPase1,ERKPase,ERKPase1,E2_cx,E1_cx,MEKpp_cx,MEKpp1_cx,RAFstar_cx,RAFstar1_cx,MEKPase_cx,MEKPase1_cx,ERKPase_cx,ERKPase1_cx];

t = [0 100];

for j = 1:length(E1)
    
    params(2) = E1(j);
    
    [t,y] = ode23s(@KinaseCascade, t, params,[],Km,Vmax);
    Y1 = y(:,5);
    Y2 = y(:,8);
    Y3 = y(:,10);
    Activated_ERK(j) = Y1(length(t)); %just want steady state values
    Activated_MEK(j) = Y2(length(t));
    Activated_RAF(j) = Y3(length(t));
    
end

%normalize to get percent response
Activated_ERK = Activated_ERK/(Activated_ERK(length(Activated_ERK)));
Activated_MEK = Activated_MEK/(Activated_MEK(length(Activated_MEK)));
Activated_RAF = Activated_RAF/(Activated_RAF(length(Activated_RAF)));

semilogx(E1,Activated_RAF,'b', 'LineWidth', 2);
hold on
semilogx(E1,Activated_MEK,'g', 'LineWidth', 2);
semilogx(E1,Activated_ERK,'r', 'LineWidth', 2);
legend('activated RAF','activated MEK','activated ERK');
title('Ultrasensitivity in the MAPK cascade','FontSize', 16, 'FontWeight', 'bold');
xlabel ('Input stimulus (E1)','FontSize', 12, 'FontWeight', 'bold');
ylabel ('predicted steady-state fractional activation','FontSize', 12, 'FontWeight', 'bold');
set(gca,'FontSize',12, 'FontWeight', 'bold');
hold off;


E1 = 1e-1; %large input stimulus, uM
params(2) = E1;
[t,y] = ode23s(@KinaseCascade, t, params,[],Km,Vmax);
activatedERK = y(:,5);
figure(2)
plot(t,activatedERK);
title('ERK output over time for large input stimulus','FontSize', 16, 'FontWeight', 'bold');
xlabel ('time','FontSize', 12, 'FontWeight', 'bold');
ylabel ('predicted ERK concentration / nM', 'FontSize', 12, 'FontWeight', 'bold');
set(gca,'FontSize',12, 'FontWeight', 'bold');

