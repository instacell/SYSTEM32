load('C:\Users\User\OneDrive\Desktop\dsp lab\2024_E10\Exercies_2_Extraterrestrial signal.mat');

N = length(signal);

figure
plot(t, signal, 'r', 'LineWidth', 1.2)
xlabel('Time (s)')
ylabel('Amplitude')
title('Received Extraterrestrial Signal (Time Domain)')
grid on

% FFT and PSD
X = fft(signal);

PSD = (abs(X).^2) / N;    % Correct PSD calculation

% Frequency axis
freq = (0:N-1) * (fs/N);

figure
plot(freq, PSD, 'b', 'LineWidth', 1.2)
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density')
title('Power Spectral Density of the Signal')
grid on

% Adaptive thresholding
threshold = 0.2 * max(PSD);

% Keep only strong frequency components
mask = PSD > threshold;

% Apply mask to FFT coefficients
X_filtered = X .* mask;

% Reconstruct signal using IFFT
signal_reconstructed = real(ifft(X_filtered));

% Plot original vs reconstructed signal
figure
plot(t, signal, 'r', 'LineWidth', 1)
hold on
plot(t, signal_reconstructed, 'g', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Amplitude')
title('Original Signal vs Noise-Removed Signal')
legend('Original Signal', 'Reconstructed Signal (After Noise Removal)')
grid on




% Upper threshold to suppress terrestrial RFI (high power)
upper_threshold = 0.3 * max(PSD);

% Lower threshold to suppress Gaussian noise floor
lower_threshold = 0.02 * max(PSD);

% Keep ONLY low-power meaningful components
mask_low_power = (PSD < upper_threshold) & (PSD > lower_threshold);

% Apply mask
X_low_power = X .* mask_low_power;

signal_weak = real(ifft(X_low_power));

% Compare original vs weak-signal reconstruction
figure
plot(t, signal, 'r', 'LineWidth', 1)
hold on
plot(t, signal_weak, 'b', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Amplitude')
title('Original Signal vs Weak (Low-Power) Extracted Signal')
legend('Original Mixed Signal', 'Extracted Weak Signal')
grid on
