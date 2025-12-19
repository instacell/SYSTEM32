Fs = 48000;     % Sampling Frequency
N  = 50;        % Filter order
Fc = 0.3;       % Cutoff frequency (Hz normalized style)

% FIR Low-pass filter using Rectangular window
b_rect = fir1(N, Fc/(Fs/2), 'low', rectwin(N+1));

% Frequency response
[H_rect, w] = freqz(b_rect, 1, 1024, Fs);

% Plot magnitude response
figure
plot(w, abs(H_rect), 'r', 'LineWidth', 1.5)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('FIR Low-Pass Filter using Rectangular Window')
grid on
