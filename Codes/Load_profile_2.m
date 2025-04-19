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
xlabel('\bf Horas Hábiles(Hrs)')
ylabel('\bf Potencia (kWm)')
title ('\bf Perfil de Carga')
yticks(-100:1100:3200)
%ylim([-100:3200])
xlim([7 19])
xticks(7:2:19)
%% BAR GRAPHIC

%Se realizará una ponderación del 43% del motor principal diesel, para así
%simular las emisiones obtenidas por el Motor diesel secundario.

%una maniobra
%P_engine    = 2*P_engine_continuous*[0, 0,  0.05,  0.15,  0.25,  0.35,  0.45,  0.55,  0.65,  0.75,  0.95,  0.75,  0.85,  0.45,  0.55,  0.35,  0.25,  0.15,  0.05,  0,  0]';
%P_diesel    = 2*P_engine_continuous*[0, 0,     0,     0,  0.25,  0.35,  0.45,  0.55,  0.65,  0.75,  0.95,  0.75,  0.85,  0.45,  0.55,  0.35,  0.25,     0,     0,  0,  0]';
%P_batt      =   P_engine_continuous*[0, 0,  0.05,  0.15,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,  0.15,  0.05,  0,  0]';
%EMMIS_TUG   =                       [0, 0, .2170, .6934, .2097, .2317, .2856, .1355, .1570, .2684, .4487, .0895, .8062, .6283, .5418, .3244, .4194, .6934, .2170,  0,  0]';
%Time        =                       [7, 8,   8.5,  9.85,  11.4,  11.7, 11.95,  12.2,  12.3,  12.4, 12.55, 12.75,  12.8,  13.2, 13.75, 14.15,  14.5,  15.1, 16.65, 17, 19]';

% 2maniobras
%P_engine    = P_engine_continuous*[ 0,  0.05,  0.15,  0.25,  0.35,  0.45,  0.95,  0.55,  0.35,  0.15,  0.05,   0,  0.05,  0.15,  0.25,  0.35, 0.95,   0.45,  0.35,  0.15,  0.05,  0,  0]';
%sfc_engine  =                     [ 0, 305.7, 283.6, 265.9, 251.8, 241.4, 224.6, 234.2, 251.8, 283.6, 305.7,   0, 305.7, 283.6, 265.9, 251.8, 224.6, 241.4, 251.8, 283.6, 305.7,  0,  0]';
%Time        =                   7+[ 0,     1,   1.5,     2,  2.25,   2.5,  2.75,  3.75,     4,   4.5,     5, 5.5,     7,   7.5,     8,   8.5,    9,   9.75, 10.25,  10.5, 10.75, 11, 12]';



P_TUG_BAR3           = 2*P_engine_continuous*[ 0 0;  0 0.05;   0.2 0;  0.35 0;   0.8 0;   0.5 0;   0.3 0;  0 0.15;   0 0.1;  0 0.05; 0 0.05]';
P_TUG                = 2*P_engine_continuous*[ 0,  0.05,   0.2,  0.35,   0.8,   0.5,   0.3,  0.15,   0.1,  0.05, 0.05]';
%Una maniobra
P_TUG_1              = 2*P_engine_continuous*[ 0,     0,     0,  0.35,   0.8,   0.5,   0.3,     0,     0,     0,    0]';
P_TUG_2              = 2*P_engine_continuous*[ 0,  0.05,   0.2,     0,     0,     0,     0,  0.15,   0.1,  0.05, 0.05]';
%Dos Maniobras
P_TUG_3              = 2*P_engine_continuous*[ 0,  0.05,  0.15,  0.25,  0.35,  0.45,  0.95,  0.55,  0.35,  0.15,  0.05,   0,  0.05,  0.15,  0.25,  0.35, 0.95,   0.45,  0.35,  0.15,  0.05,  0,  0]';

%%Corregir Valor de Emisiones por Hora
EMMIS_TUG_BAR3       =                       [ 0 0; 0 .6934; .4552 0;.3719*0.9 0; .2423 0; .3176 0; .5850 0;  0 .3719; 0 .5500; 0 .6934; 0 .6934]';
EMMIS_TUG            =                       [ 0, .6934, .4552,.3719*0.9, .2423, .3176, .5850,  .3719, .5500, .6934,.6934]';
EMMIS_TUG_1          =                       [ 0,     0,     0,.3719*0.9, .2423, .3176, .5850,      0,     0,     0,    0]';
EMMIS_TUG_2          =                       [ 0, .6934, .4552,         0,    0,     0,     0,  .3719, .5500, .6934,.6934]';
% dos manioras

Zeros_col            = zeros(11,1);
TUG1                 = [P_TUG, Zeros_col];
TUG2                 = [Zeros_col, EMMIS_TUG];

P_MainDiesel_bar3    = 2*P_engine_continuous*[ 0,     0,     0,     0,   0.8,   0.5,     0,     0,     0,     0,    0]';
EMMIS_MainDiesel     =                       [ 0,     0,     0,     0, .2423, .3176,     0,     0,     0,     0,    0]';
P_Diesel_bar3        = 2*P_engine_continuous*[ 0,     0,   0.2,  0.35,     0,     0,   0.3,     0,     0,     0,    0]';
EMMIS_Diesel         =                  0.43*[ 0,     0, .6934, .4516,     0,     0, .5850,     0,     0,     0,    0]';
P_batt_bar3          = 2*P_engine_continuous*[ 0,  0.05,     0,     0,     0,     0,     0,  0.15,   0.1,  0.05, 0.05]';
EMMIS_HTUG           =                       EMMIS_MainDiesel+EMMIS_Diesel;
Time_bar3            =                       [ 8,     9,    10,    11,    12,    13,    14,    15,    16,    17,   18]';

x=Time_bar3;
z=[P_batt_bar3 P_Diesel_bar3 P_MainDiesel_bar3];
b=bar3(x,z);
m={'Batt','Gen Set','Diesel'};    % systems
xticklabels(m)
yticks(8:2:18)
zticks(500:1000:3000)
zlabel('Potencia [kW]')
ylabel('Jornada [h]')
b(1).FaceColor=[0.49,0.87,0.49];
b(2).FaceColor=[0.00,0.60,0.30];
b(3).FaceColor=[0.404, 0.431, 0.388];


%% POTENCIA TUG
c=bar(x,P_TUG_1);
grid on
c(1).LineWidth = 1;
c(1).LineStyle = "-";
c(1).FaceColor = 'flat';
c(1).CData(1,:) = [0.404, 0.431, 0.388];
c(1).CData(2,:) = [0.404, 0.431, 0.388];
c(1).CData(3,:) = [0.404, 0.431, 0.388];
c(1).CData(4,:) = [0.404, 0.431, 0.388];
c(1).CData(5,:) = [0.404, 0.431, 0.388];
c(1).CData(6,:) = [0.404, 0.431, 0.388];
c(1).CData(7,:) = [0.404, 0.431, 0.388];
c(1).CData(8,:) = [0.404, 0.431, 0.388];
c(1).CData(9,:) = [0.404, 0.431, 0.388];
c(1).CData(10,:) = [0.404, 0.431, 0.388];
c(1).CData(11,:) = [0.404, 0.431, 0.388];
hold on
c=bar(x,P_TUG_2);
c(1).LineWidth = 2;
c(1).LineStyle = "-";
c(1).FaceColor = 'flat';
c(1).CData(1,:) = [0.404, 0.431, 0.388];
c(1).CData(2,:) = [0.404, 0.431, 0.388];
c(1).CData(3,:) = [0.404, 0.431, 0.388];
c(1).CData(4,:) = [0.404, 0.431, 0.388];
c(1).CData(5,:) = [0.404, 0.431, 0.388];
c(1).CData(6,:) = [0.404, 0.431, 0.388];
c(1).CData(7,:) = [0.404, 0.431, 0.388];
c(1).CData(8,:) = [0.404, 0.431, 0.388];
c(1).CData(9,:) = [0.404, 0.431, 0.388];
c(1).CData(10,:) = [0.404, 0.431, 0.388];
c(1).CData(11,:) = [0.404, 0.431, 0.388];
grid on
ylabel('Potencia [kWm]')
xlabel('Horas Hábiles [h]')
xticklabels({'8:00',' ','10:00',' ','12:00',' ','14:00',' ','16:00',' ','18:00'})
yticks(500:1000:3000)
%% EMISIONES

b=bar(x,EMMIS_TUG_1);
b(1).LineWidth = 1;
b(1).LineStyle = "-";
b(1).FaceColor = 'flat';
b(1).CData(1,:) = [0.404, 0.431, 0.388];
b(1).CData(2,:) = [0.404, 0.431, 0.388];
b(1).CData(3,:) = [0.404, 0.431, 0.388];
b(1).CData(4,:) = [0.404, 0.431, 0.388];
b(1).CData(5,:) = [0.404, 0.431, 0.388];
b(1).CData(6,:) = [0.404, 0.431, 0.388];
b(1).CData(7,:) = [0.404, 0.431, 0.388];
b(1).CData(8,:) = [0.404, 0.431, 0.388];
b(1).CData(9,:) = [0.404, 0.431, 0.388];
b(1).CData(10,:) = [0.404, 0.431, 0.388];
b(1).CData(11,:) = [0.404, 0.431, 0.388];
hold on
b=bar(x,EMMIS_TUG_2);
b(1).LineWidth = 1;
b(1).LineStyle = "-";
b(1).FaceColor = 'flat';
b(1).CData(1,:) = [0.404, 0.431, 0.388];
b(1).CData(2,:) = [0.404, 0.431, 0.388];
b(1).CData(3,:) = [0.404, 0.431, 0.388];
b(1).CData(4,:) = [0.404, 0.431, 0.388];
b(1).CData(5,:) = [0.404, 0.431, 0.388];
b(1).CData(6,:) = [0.404, 0.431, 0.388];
b(1).CData(7,:) = [0.404, 0.431, 0.388];
b(1).CData(8,:) = [0.404, 0.431, 0.388];
b(1).CData(9,:) = [0.404, 0.431, 0.388];
b(1).CData(10,:) = [0.404, 0.431, 0.388];
b(1).CData(11,:) = [0.404, 0.431, 0.388];
grid on
ylabel('Emisiones [TonC{O}_{2}]')
xlabel('Horas Hábiles [h]')
xticklabels({'8:00',' ','10:00',' ','12:00',' ','14:00',' ','16:00',' ','18:00'})
yticks(0:0.2:0.8)
%%
subplot(2,1,1)
b=bar(x,P_TUG_2);
b(1).LineWidth = 1;
b(1).LineStyle = "-";
b(1).FaceColor = 'flat';
b(1).EdgeColor = [0,0,0];
b(1).CData(1,:) = [0.60,0.62,0.58];
b(1).CData(2,:) = [0.60,0.62,0.58];
b(1).CData(3,:) = [0.60,0.62,0.58];
b(1).CData(4,:) = [0.60,0.62,0.58];
b(1).CData(5,:) = [0.60,0.62,0.58];
b(1).CData(6,:) = [0.60,0.62,0.58];
b(1).CData(7,:) = [0.60,0.62,0.58];
b(1).CData(8,:) = [0.60,0.62,0.58];
b(1).CData(9,:) = [0.60,0.62,0.58];
b(1).CData(10,:) = [0.60,0.62,0.58];
b(1).CData(11,:) = [0.60,0.62,0.58];
yticks(500:1000:3000)
ylim([0 3000])
hold on
a=bar(x,P_TUG_1);
a(1).LineWidth = 1;
a(1).LineStyle = "-";
a(1).FaceColor = 'flat';
a(1).EdgeColor = [0,0,0];
a(1).CData(1,:) = [0.60,0.62,0.58];
a(1).CData(2,:) = [0.60,0.62,0.58];
a(1).CData(3,:) = [0.60,0.62,0.58];
a(1).CData(4,:) = [0.60,0.62,0.58];
a(1).CData(5,:) = [0.60,0.62,0.58];
a(1).CData(6,:) = [0.60,0.62,0.58];
a(1).CData(7,:) = [0.60,0.62,0.58];
a(1).CData(8,:) = [0.60,0.62,0.58];
a(1).CData(9,:) = [0.60,0.62,0.58];
a(1).CData(10,:) = [0.60,0.62,0.58];
a(1).CData(11,:) = [0.60,0.62,0.58];
grid on
ylabel('[kW]')
xticklabels({'8:00',' ','10:00',' ','12:00',' ','14:00',' ','16:00',' ','18:00'})
yticks(500:1000:3000)
ax = gca;
ax.XAxis.FontSize = 14; % or whatever
ax.XAxis.FontName = 'Times New Roman';
ax.YAxis.FontSize = 14; % or whatever
ax.YAxis.FontName = 'Times New Roman';
title ('\bf Operational Profile - Tugboat')


%%
clc
Time = [ "8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]'


%%
T = table(Time, P_TUG,EMMIS_TUG);
stackedplot(T)