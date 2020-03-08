%% EE 568: Special Topics in Electrical Machines
% Project 1: Analitic Model ver 1.1
% Nail Tosun
clear;
mu = 4*pi*1e-7; % mu_0 permuability of air
theta1 = 2*asin(7.5/12); % State 1
theta2 = asin(3/4)-asin(7.5/12); % State 2

A1 = @(theta) 12e-3*(theta)*0.02; % Area Related with inductance_1
A2 = @(theta) 10e-3*(theta)*0.02; % Area Related with inductance_2
A3 = @(theta) 11e-3*(theta)*0.02; % Area Related with inductance_3

% Theta dependent reluctance functions
R1 = @(theta) 0.5e-3/(A1(theta)*mu); 
R2 = @(theta) 2.5e-3/(A2(theta)*mu);
R3 = @(theta) 1.5e-3/(A3(theta)*mu);

i = 1;
for theta = -(2*pi*89)/360:((2*pi*0.1)/360):((2*pi*89)/360)
    theta = abs(theta);
    if theta>=0 && theta<=theta2
        R(i) = R1(theta1-theta)*R3(theta)/(R1(theta1-theta)+R3(theta));
        i = i+1;
    elseif theta>theta2 && theta<=theta1
        dum = R1(theta1-theta)*R2(theta-theta2)/(R1(theta1-theta)+R2(theta-theta2));
        R(i) = dum*R3(theta2)/(R3(theta2)+dum);
        i = i+1;
    elseif theta>theta1 && theta<theta1+theta2*2
        R(i) = R2(theta-theta2)*R3(theta1+theta2-theta)/(R2(theta-theta2)+R3(theta1+theta2-theta));
        i = i+1;
    end
   
end
figure;
plot(360/(2*pi).*(-(2*pi*89)/360:((2*pi*0.1)/360):((2*pi*89)/360)),(2.*R));
