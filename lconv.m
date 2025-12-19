x = [1 2 3 4];
h = [1 2 1 2];

m = length(x);
n = length(h);
L = m + n - 1;
N = max(m,n);

X_mat = toeplitz([x, zeros(1, n-1)], [x(1), zeros(1, n-1)]);
ylc_matrix = X_mat * h';

disp('Matrix Method Result:');
disp(ylc_matrix');

% Linear convolution using FFT
x_padded = [x zeros(1, L - N)]; % Zero-pad x to L samples for linear convolution via FFT
h_padded = [h zeros(1, L - N)]; % Zero-pad h to L samples for linear convolution via FFT
ylc_fft = ifft(fft(x_padded) .* fft(h_padded)); % Linear convolution using FFT
