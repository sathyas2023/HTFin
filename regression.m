clc;
close all;
clear all;

m = @(h,P,k,A) sqrt((h*P)/(k*A));
T = @(h,k,m,L,x,Tb,Ti) ((cosh(m*(L-x))+(h/(m*k))*sinh(m*(L-x)))/ ...
                 (cosh(m*L)+(h/(m*k))*sinh(m*L)))*(Tb-Ti)+Ti;
q = @(h,m,P,k,A,L,Tb,Ti) sqrt(h*P*k*A)*(Tb-Ti)* ...
     ((sinh(m*L)+(h/(m*k))*cosh(m*L))/ ...
      (cosh(m*L)+(h/(m*k))*sinh(m*L)));
            
% Areas [m^2]
A_steel = pi/4*0.0128^2;
A_aluminum = pi/4*0.0128^2;
A_brass = pi/4*0.0128^2;
A_copper = pi/4*0.0127^2;

% Perimeter [m]
P_steel = pi*0.0128;
P_aluminum = pi*0.0128;
P_brass = pi*0.0128;
P_copper = pi*0.0127;

% Length [m]
L_steel = 12.0625*0.0254;
L_aluminum = 11.96875*0.0254;
L_brass = 12.0625*0.0254;
L_copper = 12*0.0254;

% Thermocouple Length [m]
tc_L_steel = [12 9.0938 6.0938 3.0938 0.0625].*0.0254;
tc_L_aluminum = [11.9063 9.0625 6.0313 3 0.0313].*0.0254;
tc_L_brass = [12 9.0938 6.0938 3.0625 0.0625].*0.0254;
tc_L_copper = [11.9063 9.0625 6.0625 3.0313 0.0625].*0.0254;

% Thermal Conducivity [W/m-K]
k_steel = 16.2;
k_aluminum = 167;
k_brass = 116;
k_copper = 398;

% Temperatures [K] (Tb = T5 assumption)
T_inf = 21.72 + 273.15;
Tb_brass_free = 72.48 + 273.15;
Tb_copper_free = 66.48 + 273.15;
Tb_steel_free = 82.91 + 273.15;
Tb_aluminum_free = 51.38 + 273.15;
Tb_brass_forced = 56.19 + 273.15;
Tb_copper_forced = 44.11 + 273.15;
Tb_steel_forced = 53.44 + 273.15;
Tb_aluminum_forced = 38.19 + 273.15;

tc_T_brass_free = [28.54 30.39 36.04 47.94 72.48] + 273.15;
tc_T_copper_free = [46.88 47.78 51.12 57.13 66.48] + 273.15;
tc_T_steel_free = [21.90 22.37 24.53 35.12 82.91] + 273.15;
tc_T_aluminum_free = [28.69 29.34 33.25 49.77 51.38] + 273.15;

tc_T_brass_forced = [22.62 23.06 24.72 31.28 56.19] + 273.15;
tc_T_copper_forced = [29.47 29.71 31.25 34.75 44.11] + 273.15;
tc_T_steel_forced = [21.72 21.89 22.32 23.41 53.44] + 273.15;
tc_T_aluminum_forced = [23.07 23.11 24.34 27.16 38.19] + 273.15;



%% brass_free
F_min = inf;
h_brass_free = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_brass,k_brass,A_brass);
    T1 = T(h,k_brass,m_h,L_brass,tc_L_brass(1),Tb_brass_free,T_inf);
    T2 = T(h,k_brass,m_h,L_brass,tc_L_brass(2),Tb_brass_free,T_inf);
    T3 = T(h,k_brass,m_h,L_brass,tc_L_brass(3),Tb_brass_free,T_inf);
    T4 = T(h,k_brass,m_h,L_brass,tc_L_brass(4),Tb_brass_free,T_inf);
    T5 = T(h,k_brass,m_h,L_brass,tc_L_brass(5),Tb_brass_free,T_inf);
    F = (tc_T_brass_free(1) - T1)^2 + (tc_T_brass_free(2) - T2)^2 + ...
        (tc_T_brass_free(3) - T3)^2 + (tc_T_brass_free(4) - T4)^2 + ...
        (tc_T_brass_free(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_brass_free = h;
    end
end
fprintf('brass_free: h = %f W/m-K\n',h_brass_free);

%% copper_free
F_min = inf;
h_copper_free = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_copper,k_copper,A_copper);
    T1 = T(h,k_copper,m_h,L_copper,tc_L_copper(1),Tb_copper_free,T_inf);
    T2 = T(h,k_copper,m_h,L_copper,tc_L_copper(2),Tb_copper_free,T_inf);
    T3 = T(h,k_copper,m_h,L_copper,tc_L_copper(3),Tb_copper_free,T_inf);
    T4 = T(h,k_copper,m_h,L_copper,tc_L_copper(4),Tb_copper_free,T_inf);
    T5 = T(h,k_copper,m_h,L_copper,tc_L_copper(5),Tb_copper_free,T_inf);
    F = (tc_T_copper_free(1) - T1)^2 + (tc_T_copper_free(2) - T2)^2 + ...
        (tc_T_copper_free(3) - T3)^2 + (tc_T_copper_free(4) - T4)^2 + ...
        (tc_T_copper_free(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_copper_free = h;
    end
end
fprintf('copper_free: h = %f W/m-K\n',h_copper_free);

%% steel_free
F_min = inf;
h_steel_free = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_steel,k_steel,A_steel);
    T1 = T(h,k_steel,m_h,L_steel,tc_L_steel(1),Tb_steel_free,T_inf);
    T2 = T(h,k_steel,m_h,L_steel,tc_L_steel(2),Tb_steel_free,T_inf);
    T3 = T(h,k_steel,m_h,L_steel,tc_L_steel(3),Tb_steel_free,T_inf);
    T4 = T(h,k_steel,m_h,L_steel,tc_L_steel(4),Tb_steel_free,T_inf);
    T5 = T(h,k_steel,m_h,L_steel,tc_L_steel(5),Tb_steel_free,T_inf);
    F = (tc_T_steel_free(1) - T1)^2 + (tc_T_steel_free(2) - T2)^2 + ...
        (tc_T_steel_free(3) - T3)^2 + (tc_T_steel_free(4) - T4)^2 + ...
        (tc_T_steel_free(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_steel_free = h;
    end
end
fprintf('steel_free: h = %f W/m-K\n',h_steel_free);

%% aluminum_free
F_min = inf;
h_aluminum_free = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_aluminum,k_aluminum,A_aluminum);
    T1 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(1),Tb_aluminum_free,T_inf);
    T2 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(2),Tb_aluminum_free,T_inf);
    T3 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(3),Tb_aluminum_free,T_inf);
    T4 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(4),Tb_aluminum_free,T_inf);
    T5 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(5),Tb_aluminum_free,T_inf);
    F = (tc_T_aluminum_free(1) - T1)^2 + (tc_T_aluminum_free(2) - T2)^2 + ...
        (tc_T_aluminum_free(3) - T3)^2 + (tc_T_aluminum_free(4) - T4)^2 + ...
        (tc_T_aluminum_free(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_aluminum_free = h;
    end
end
fprintf('aluminum_free: h = %f W/m-K\n',h_aluminum_free);

%% brass_forced
F_min = inf;
h_brass_forced = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_brass,k_brass,A_brass);
    T1 = T(h,k_brass,m_h,L_brass,tc_L_brass(1),Tb_brass_forced,T_inf);
    T2 = T(h,k_brass,m_h,L_brass,tc_L_brass(2),Tb_brass_forced,T_inf);
    T3 = T(h,k_brass,m_h,L_brass,tc_L_brass(3),Tb_brass_forced,T_inf);
    T4 = T(h,k_brass,m_h,L_brass,tc_L_brass(4),Tb_brass_forced,T_inf);
    T5 = T(h,k_brass,m_h,L_brass,tc_L_brass(5),Tb_brass_forced,T_inf);
    F = (tc_T_brass_forced(1) - T1)^2 + (tc_T_brass_forced(2) - T2)^2 + ...
        (tc_T_brass_forced(3) - T3)^2 + (tc_T_brass_forced(4) - T4)^2 + ...
        (tc_T_brass_forced(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_brass_forced = h;
    end
end
fprintf('brass_forced: h = %f W/m-K\n',h_brass_forced);

%% copper_forced
F_min = inf;
h_copper_forced = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_copper,k_copper,A_copper);
    T1 = T(h,k_copper,m_h,L_copper,tc_L_copper(1),Tb_copper_forced,T_inf);
    T2 = T(h,k_copper,m_h,L_copper,tc_L_copper(2),Tb_copper_forced,T_inf);
    T3 = T(h,k_copper,m_h,L_copper,tc_L_copper(3),Tb_copper_forced,T_inf);
    T4 = T(h,k_copper,m_h,L_copper,tc_L_copper(4),Tb_copper_forced,T_inf);
    T5 = T(h,k_copper,m_h,L_copper,tc_L_copper(5),Tb_copper_forced,T_inf);
    F = (tc_T_copper_forced(1) - T1)^2 + (tc_T_copper_forced(2) - T2)^2 + ...
        (tc_T_copper_forced(3) - T3)^2 + (tc_T_copper_forced(4) - T4)^2 + ...
        (tc_T_copper_forced(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_copper_forced = h;
    end
end
fprintf('copper_forced: h = %f W/m-K\n',h_copper_forced);

%% steel_forced
F_min = inf;
h_steel_forced = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_steel,k_steel,A_steel);
    T1 = T(h,k_steel,m_h,L_steel,tc_L_steel(1),Tb_steel_forced,T_inf);
    T2 = T(h,k_steel,m_h,L_steel,tc_L_steel(2),Tb_steel_forced,T_inf);
    T3 = T(h,k_steel,m_h,L_steel,tc_L_steel(3),Tb_steel_forced,T_inf);
    T4 = T(h,k_steel,m_h,L_steel,tc_L_steel(4),Tb_steel_forced,T_inf);
    T5 = T(h,k_steel,m_h,L_steel,tc_L_steel(5),Tb_steel_forced,T_inf);
    F = (tc_T_steel_forced(1) - T1)^2 + (tc_T_steel_forced(2) - T2)^2 + ...
        (tc_T_steel_forced(3) - T3)^2 + (tc_T_steel_forced(4) - T4)^2 + ...
        (tc_T_steel_forced(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_steel_forced = h;
    end
end
fprintf('steel_forced: h = %f W/m-K\n',h_steel_forced);

%% aluminum_forced
F_min = inf;
h_aluminum_forced = -1;
for i = 1:0.01:1000
    h = i;
    m_h = m(h,P_aluminum,k_aluminum,A_aluminum);
    T1 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(1),Tb_aluminum_forced,T_inf);
    T2 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(2),Tb_aluminum_forced,T_inf);
    T3 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(3),Tb_aluminum_forced,T_inf);
    T4 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(4),Tb_aluminum_forced,T_inf);
    T5 = T(h,k_aluminum,m_h,L_aluminum,tc_L_aluminum(5),Tb_aluminum_forced,T_inf);
    F = (tc_T_aluminum_forced(1) - T1)^2 + (tc_T_aluminum_forced(2) - T2)^2 + ...
        (tc_T_aluminum_forced(3) - T3)^2 + (tc_T_aluminum_forced(4) - T4)^2 + ...
        (tc_T_aluminum_forced(5) - T5)^2;
    if F < F_min
        F_min = F;
        h_aluminum_forced = h;
    end
end
fprintf('aluminum_forced: h = %f W/m-K\n',h_aluminum_forced);

%% q_fin
% q = @(h,m,P,k,A,L,Tb,Ti)
m_brass_free = m(h_brass_free,P_brass,k_brass,A_brass);
q_fin_brass_free = q(h_brass_free,m_brass_free,P_brass,k_brass,A_brass,L_brass,Tb_brass_free,T_inf);

m_copper_free = m(h_copper_free,P_copper,k_copper,A_copper);
q_fin_copper_free = q(h_copper_free,m_copper_free,P_copper,k_copper,A_copper,L_copper,Tb_copper_free,T_inf);

m_steel_free = m(h_steel_free,P_steel,k_steel,A_steel);
q_fin_steel_free = q(h_steel_free,m_steel_free,P_steel,k_steel,A_steel,L_steel,Tb_steel_free,T_inf);

m_aluminum_free = m(h_aluminum_free,P_aluminum,k_aluminum,A_aluminum);
q_fin_aluminum_free = q(h_aluminum_free,m_aluminum_free,P_aluminum,k_aluminum,A_aluminum,L_aluminum,Tb_aluminum_free,T_inf);

m_brass_forced = m(h_brass_forced,P_brass,k_brass,A_brass);
q_fin_brass_forced = q(h_brass_forced,m_brass_forced,P_brass,k_brass,A_brass,L_brass,Tb_brass_forced,T_inf);

m_copper_forced = m(h_copper_forced,P_copper,k_copper,A_copper);
q_fin_copper_forced = q(h_copper_forced,m_copper_forced,P_copper,k_copper,A_copper,L_copper,Tb_copper_forced,T_inf);

m_steel_forced = m(h_steel_forced,P_steel,k_steel,A_steel);
q_fin_steel_forced = q(h_steel_forced,m_steel_forced,P_steel,k_steel,A_steel,L_steel,Tb_steel_forced,T_inf);

m_aluminum_forced = m(h_aluminum_forced,P_aluminum,k_aluminum,A_aluminum);
q_fin_aluminum_forced = q(h_aluminum_forced,m_aluminum_forced,P_aluminum,k_aluminum,A_aluminum,L_aluminum,Tb_aluminum_forced,T_inf);

fprintf('brass_free: qfin = %f W\n', q_fin_brass_free);
fprintf('copper_free: qfin = %f W\n', q_fin_copper_free);
fprintf('steel_free: qfin = %f W\n', q_fin_steel_free);
fprintf('aluminum_free: qfin = %f W\n', q_fin_aluminum_free);
fprintf('brass_forced: qfin = %f W\n', q_fin_brass_forced);
fprintf('copper_forced: qfin = %f W\n', q_fin_copper_forced);
fprintf('steel_forced: qfin = %f W\n', q_fin_steel_forced);
fprintf('aluminum_forced: qfin = %f W\n', q_fin_aluminum_forced);

