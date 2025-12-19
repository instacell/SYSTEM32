clc;
clear;

% Define symbolic variables
syms z n

% Define the signal x[n]
x = -(0.5)^n;

% Compute the Z-transform for 0 ≤ n ≤ 20
Xz = symsum(x*z^(-n), n, 0, 20);

disp('Z-Transform X(z) = ');
pretty(Xz)

% Plot the unit circle
theta = linspace(0, 2*pi, 500);
x_uc = cos(theta);
y_uc = sin(theta);

figure;
plot(x_uc, y_uc, 'r:', 'LineWidth', 1.5);
hold on;
axis equal;

% Plot Region of Convergence (ROC)
r = linspace(0.5, 2, 300);
[Theta, R] = meshgrid(theta, r);

X = R .* cos(Theta);
Y = R .* sin(Theta);

fill(X(:), Y(:), 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Final plot settings
legend('Unit Circle', 'Region of Convergence (|z| > 0.5)', 'Location', 'best');
xlabel('Real Axis');
ylabel('Imaginary Axis');
title('Unit Circle and Region of Convergence');
grid on;
hold off;

