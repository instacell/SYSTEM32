b = [0.2];
a = [1, -0.52, 0.68];

% generate transfer function
% H = tf(b,a,-1); -1 specifies a discrete-time

figure
zplane(b,a)
title('Pole-Zero Plot of H(z)');
grid on;

figure
% Impulse response
impz(b, a)
% Step response
stepz(b, a)

figure
% Frequency Response with Z-domain Analysis
w = linspace(0, pi, 500);
freqz(b, a, w);
abs(h) % Magnitude response
angle(h) * 180/pi % Phase response in degrees

% Determine and display poles
poles = roots(a);
disp('Poles of H(z):');
disp(poles);
