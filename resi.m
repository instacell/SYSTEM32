clc;
clear;

num = [5 45 2 1 1];
den = [2 5 9 5 3];

[r,p,k] = residue(num,den);

disp('Residues (r):');
disp(r);

disp('poles')
disp(p);

disp('Direct term coefficients (k):');
disp(k);

zplane(num,den)
title('Pole-zero plot of G(z)');
grid on;

n = 0:20;
impz(num,den,n)
