clc
clear all
close all


x = 0.1:1/22:1;
d = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;

plot(x, d, 'b');
hold on;

%% RBF parametrai 
% centrai ir spinduliai
c1 = 0.19;  
r1 = 0.16;

c2 = 0.91;  
r2 = 0.16;

% svoriai ir bias
w1 = randn(1)*0.5;
w2 = randn(1)*0.5;
b1 = randn(1)*0.5; 

eta = 0.1; % mokymosi greitis

%% mokymo ciklas 2 sluoksnis
for iter = 1:90
    for i = 1:length(x)
        %  RBF funkcijos
        F1 = exp(-((x(i) - c1)^2) / (2 * r1^2));
        F2 = exp(-((x(i) - c2)^2) / (2 * r2^2));

        % isejimo sluoksnis
        v = F1*w1 + F2*w2 + b1;
        y = v; %aktyvacija, tiesine f

        
        e = d(i) - y;

        %svoriu atbaujinimas
        w1 = w1 + eta * e * F1;
        w2 = w2 + eta * e * F2;

        b1 = b1 + eta * e;
    end
end

%% testavimas
x_new = 0.1:1/22:1;
Y = zeros(1, length(x_new));

for i = 1:length(x_new)
    % skaiciuojam RBF reiksmes
    F1 = exp(-((x_new(i) - c1)^2) / (2 * r1^2));
    F2 = exp(-((x_new(i) - c2)^2) / (2 * r2^2));

    % isejimas
    Y(i) = F1*w1 + F2*w2 + b1;
end

plot(x_new, Y, 'r--');
grid on;
