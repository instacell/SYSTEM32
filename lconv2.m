x = [1 2 3 4];
h = [1 2 1 2];
N = length(x);

% Circulant matrix
row = x;
col = x([1, end:-1:2]); % Circular shift logic
C = toeplitz(row, col);

ycc_matrix = C * h';

disp('Circular Convolution Matrix Result:');
disp(ycc_matrix');

% Circular convolution using FFT
ycc_fft = ifft(fft(x).* fft(h)); 