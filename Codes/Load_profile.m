%Perfil Operacional TUG
%Perfil operacional del TUG para un día con una maniobra
clc
clear

%Perfil actual TUG
P_engine_continuous=1640;
P_engine_standby=2000;
P_engine_prime=1825;

P_engine    = 2*P_engine_continuous*[0, 0,  0.05,  0.15,  0.25,  0.35,  0.45,  0.55,  0.65,  0.75,  0.95,  0.75,  0.85,  0.45,  0.55,  0.35,  0.25,  0.15,  0.05,  0, 0]';
sfc_engine  =                     [0, 0, 305.7, 283.6, 265.9, 251.8, 241.4, 234.2, 229.7, 226.9, 224.6, 226.9, 225.5, 241.4, 234.2, 251.8, 265.9, 283.6, 305.7,  0, 0]';
Time        =                   8+[-1, 0,   0.5,  1.85,   3.4,   3.7,  3.95,   4.2,   4.3,   4.4,  4.55,  4.75,   4.8,   5.2,  5.75,  6.15,   6.5,   7.1,  8.65, 10, 11]';

stairs(Time,P_engine,'LineWidth', 4, 'Color',"#676E63")
grid on
ax = gca;
ax.FontSize = 16;
ax.GridAlpha = 0.5;
xlabel('\bf Horas Hábiles(Hrs)')
ylabel('\bf Potencia (kWm)')
title ('\bf Perfil de Carga')
yticks(-100:1100:3200)
%ylim([-100:3200])
xlim([7 19])
xticks(7:2:19)

%% Propuesta para Batería y Diesel

% Propuesta Diesel
P_diesel   =2*P_engine_continuous*[0,0,  0, 0,  0.25,  0.35,  0.45,  0.55,  0.65,  0.75,  0.95,  0.75,  0.85,  0.45,  0.55,  0.35,  0.25, 0,  0,  0,0]';
sfc_diesel =                      [0,0,  0, 0, 265.9, 251.8, 241.4, 234.2, 229.7, 226.9, 224.6, 226.9, 225.5, 241.4, 234.2, 251.8, 265.9, 0,  0,  0,0]';

%Propuesta Batt
P_batt= P_engine_continuous*[0,0,  0.05,  0.15,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0.15,  0.05,  0,0]';


stairs(Time,P_batt,'LineWidth', 4,'Color',"#7CDF7C")
hold on
stairs(Time,P_diesel,'LineWidth', 3,'Color',"#676E63")
grid on
ax = gca;
ax.FontSize = 16;
xlabel('\bf Horas Hábiles(Hrs)')
ylabel('\bf Potencia (kWm)')
title ('\bf Perfil de Carga')
legend('Batt', 'Diesel','Location','northwest')
yticks(-100:1100:3200)
xlim([7 19])
xticks(7:2:19)

%% Tiempo de Uso
use_time=zeros(length(Time),1);
for i=1:(length(Time)-2)
    use_time(i+1,1) = Time(i+2,1)-Time(i+1,1);
end
use_time(1,1)=0.5; %Forzar para que la suma del tiempo de uso sea 10 hrs

T = table(P_engine,use_time)
sum(use_time)

%%
% P_diesel corresponde al trabajo realizado sólo por el motor diesel
CF = 3.206,
for j=1:(length(Time))
    EMM1(j,1)=sfc_engine(j,1)*P_engine(j,1)*use_time(j,1)*CF/(1e6);
    EMM2(j,1)=sfc_diesel(j,1)*P_diesel(j,1)*use_time(j,1)*CF/(1e6);
end

stairs(Time,EMM1,'LineWidth', 4,'Color',"#676E63")
grid on
xlabel('\bf Horas Hábiles(Hrs)')
ylabel('\bf Ton {CO}_{2}')
title ('\bf Emisiones')
ax = gca;
ax.FontSize = 16;
yticks(0:0.2:0.8)
%ylim([-100:3200])
xlim([7 19])
xticks(7:2:19)
%matrix=[EMM1,sfc_engine,P_engine,use_time];
%%
CF = 3.206,
for j=1:(length(Time))
    EMM1(j,1)=sfc_engine(j,1)*P_engine(j,1)*use_time(j,1)*CF/(1e6);
    EMM2(j,1)=sfc_diesel(j,1)*P_diesel(j,1)*use_time(j,1)*CF/(1e6);
end

stairs(Time,EMM1,'-.','LineWidth', 3,'Color',"#676E63")
hold on
stairs(Time,EMM2,'LineWidth', 4,'Color',"#7CDF7C")
grid on
ax = gca;
ax.FontSize = 16;
xlabel('Horas Hábiles(Hrs)')
ylabel('Ton {CO}_{2}')
title ('\bf Emisiones')
legend('s/n Batt', 'c/n Batt','Location','northeast')
yticks(0:0.2:0.8)
xlim([7 19])
xticks(7:2:19)

%%
for k=1:(length(Time))
    EMM1_acc(k)=sum(EMM1(1:k));
    EMM2_acc(k)=sum(EMM2(1:k));
end

plot(Time,EMM1_acc,'LineWidth', 1.5,'Color',"#676E63")
hold on
plot(Time,EMM2_acc,'LineWidth', 1.5,'Color','#D4AC0D')
grid on
xlabel('Horas Hábiles(Hrs)')
ylabel('Emisiones (Ton CO2)')
title ('\bf Emisiones Acumuladas Motor Cat3516B')
legend('s/n Batt', 'c/n Batt','Location','northwest')

%% BAR GRAPHIC

%Se realizará una ponderación del 43% del motor principal diesel, para así
%simular las emisiones obtenidas por el Motor diesel secundario.

%P_engine    = 2*P_engine_continuous*[0, 0,  0.05,  0.15, 0.25, 0.35, 0.45,  0.55, 0.65, 0.75,  0.95,  0.75, 0.85, 0.45,  0.55,  0.35, 0.25, 0.15,  0.05,  0, 0]';
%P_diesel    = 2*P_engine_continuous*[0, 0,     0,     0, 0.25, 0.35, 0.45,  0.55, 0.65, 0.75,  0.95,  0.75, 0.85, 0.45,  0.55,  0.35, 0.25,    0,     0,  0, 0]';
%P_batt      =   P_engine_continuous*[0, 0,  0.05,  0.15,    0,    0,    0,     0,    0,    0,     0,     0,    0,    0,     0,     0,    0, 0.15,  0.05,  0, 0]';
%Time        =                       [7, 8,   8.5,  9.85, 11.4, 11.7, 11.95, 12.2, 12.3, 12.4, 12.55, 12.75, 12.8, 13.2, 13.75, 14.15, 14.5, 15.1, 16.65, 17,19]';

% REGISTRO:  P_MainDiesel_bar3    = 2*P_engine_continuous*[ 0,  0.05,   0.2,  0.35,   0.8,   0.5,  0.3,  0.15,  0.05,     0,   0]';

P_TUG                = 2*P_engine_continuous*[ 0,  0.05,   0.2,  0.35,   0.8,   0.5,  0.3,  0.15,   0.1,  0.05, 0.05]';
P_MainDiesel_bar3    = 2*P_engine_continuous*[ 0,     0,   0.2,  0.35,   0.8,   0.5,  0.3,     0,     0,     0,    0]';
P_batt_bar3          = 2*P_engine_continuous*[ 0,  0.05,     0,     0,     0,     0,    0,  0.15,   0.1,  0.05, 0.05]';
Time_bar3            =                       [ 8,     9,    10,    11,    12,    13,   14,    15,    16,    17,   18]';
%Time_jornada            =                    [ 9:00,     8:00,    '8:00',    '8:00',    '8:00',    '8:00',   '8:00',    '8:00',    '8:00',    '8:00',   '8:00']';

y=Time_bar3;
z=[P_batt_bar3 P_MainDiesel_bar3];
b=bar3(y,z);
ax = gca;
axis tight
zticks(500:1000:3000)
set(ax,'ytick',8:2:18,'yticklabel',compose('%d:00',8:2:18))
ax.XAxis.FontSize = 12; % or whatever
ax.XAxis.FontName = 'Helvetica';
ax.YAxis.FontSize = 14; % or whatever
ax.YAxis.FontName = 'Times New Roman';
ax.ZAxis.FontSize = 14; % or whatever
ax.ZAxis.FontName = 'Times New Roman';
m={'Battery','Diesel'};    % systems
xticklabels(m)
xtickangle(315)
zlabel('[kW]','FontName', 'Times New Roman')
title ('\bf Proposed Operational Profile - Hybrid Tug')
b(1).FaceColor=[0.51,0.87,0.46];
%b(2).FaceColor=[0.42,0.68,0.87];
b(2).FaceColor=[0.60,0.62,0.58];

%%
x=P_TUG;
c=bar(y,x);
m={'Main Diesel'};    % systems
bx = gca;
bx.XAxis.FontSize = 14; % or whatever
bx.XAxis.FontName = 'Times New Roman';
bx.YAxis.FontSize = 14; % or whatever
bx.YAxis.FontName = 'Times New Roman';
ylabel('[kW]')
yticks(500:1000:3000)
set(bx,'xtick',8:2:18,'xticklabel',compose('%d:00',8:2:18))
bx.GridAlpha = 0.5;
grid on
c(1).FaceColor=[0.60,0.62,0.58];
title ('\bf Operational Profile - Tugboat')

%%
tiledlayout(1,2);

%Tile 1
nexttile
c=bar(y,x);
c(1).FaceColor=[0.40,0.43,0.39];
ax = gca;
ax.FontSize = 16;
xlabel('\bf Horas Hábiles(Hrs)')
ylabel('\bf Potencia (kWm)')
title ('\bf Perfil de Carga')
grid on
yticks(0:500:3000)
xticks(8:2:18)

%Tile 2
nexttile
bar3(y,z)
b=bar3(y,z);
b(1).FaceColor=[0.49,0.87,0.49];
b(2).FaceColor=[0.00,0.60,0.30];
b(3).FaceColor=[0.40,0.43,0.39];
m={'Bat','Gen Set','Main Diesel'};    % systems
xticklabels(m)
grid on
zticks(0:500:3000)
yticks(8:2:18)
zlabel('Potencia [kW]')
ylabel('Horas Hábiles [h]')
