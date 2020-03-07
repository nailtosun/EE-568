clear;
nu = 4*pi*1e-7;
theta1 = 2*asin(7.5/12);
theta2 = asin(3/4)-asin(7.5/12);
A1 = @(theta) 12e-3*(theta)*0.02;
A2 = @(theta) 10e-3*(theta)*0.02;
A3 = @(theta) 11e-3*(theta)*0.02;
R1 = @(theta) 0.5e-3/(A1(theta)*nu);
R2 = @(theta) 2.5e-3/(A2(theta)*nu);
R3 = @(theta) 1.5e-3/(A3(theta)*nu);
i = 1;
for theta = -(2*pi*89)/360:((2*pi*0.1)/360):((2*pi*89)/360)
    theta = abs(theta);
    if theta>=0 && theta<=theta2
        R(i) = R1(theta1-theta)*R3(theta)/(R1(theta1-theta)+R3(theta));
        i = i+1;
    elseif theta>theta2 && theta<theta1
        dum = R1(theta1-theta)*R2(theta-theta2)/(R1(theta1-theta)+R2(theta-theta2));
        R(i) = dum*R3(theta2)/(R3(theta2)+dum);
        i = i+1;
    elseif theta>=theta1+theta2 && theta<theta1+theta2*2
        R(i) = R2(theta)*R3(theta-theta1)/(R2(theta)+R3(theta-theta1));
        i = i+1;
    else
        disp(theta*360/(2*pi))
        R(i) = R2(theta1);
        i = i+1;
       
    end
   
end
figure;
plot(360/(2*pi).*(-(2*pi*89)/360:((2*pi*0.1)/360):((2*pi*89)/360)),250*250./((2.*R)));
