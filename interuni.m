A = 1; F = 2;
t = 0:0.001:1;
x_t = A*sin(2*pi*F*t);
subplot(4,1,1)
plot(t,x_t,'-b')

F_s = 2*F;
n = 0:1/F_s:1;
x_s = A*sin(2*pi*F*n);
subplot(4,1,2)
stem(n,x_s,"filled")

t_r = linspace(0,1,1000);
x_linear = interp1(n,x_s,t_r,"linear");
x_spline = interp1(n,x_s,t_r,"spline");
subplot(4,1,3)
plot(t_r,x_linear,'-o')
subplot(4,1,4)
plot(t_r,x_spline,'-r')
