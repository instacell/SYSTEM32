% Sampling parameters
Fs = 400;                  % Sampling frequency (Hz) Nyquist_frequency = 2 x 100 = 200Hz ==> Fs = 2 * Nyquist_frequency
t = 0:1/Fs:5;              % Time duration (5 seconds)
N = length(t);

% Signal Component
heart = sin(2*pi*1*t);           % Heart rhythm (1 Hz)
muscle = sin(2*pi*100*t);        % Muscle movement (100 Hz)
powerline = sin(2*pi*50*t);      % Powerline interference (50 Hz)

% Clean ECG signal
clean_signal = heart + muscle + powerline;

% Gaussian Noise
noise = 2 * 0.5 * randn(size(t));

% Clean signal with noise
clean_signal_with_noise = clean_signal + noise;

plot(t,clean_signal,'r');hold on
plot(t,clean_signal_with_noise,'b');
xlabel('Time (s)')
ylabel('ECG signal')
title('ECG signal with and without noise')
legend("Without Noise","With noise")

% Apply fft
X = fft(clean_signal_with_noise);

% PSD calculation
PSD = (X .* conj(clean_signal_with_noise))/N;

% Frequency axis
freq = (0:N-1)*(Fs/N);

% Adaptive threshold
threshold = 0.2 * max(PSD);

% Keep strong frequencies
Keep_strong_freq = PSD > threshold;

% Ensure symmetry
Keep_strong_freq = Keep_strong_freq | fliplr(Keep_strong_freq);

% Apply filter
noisy_signal_filtered = X .* Keep_strong_freq;

% Filter in frequency domain
X_filtered = X .* Keep_strong_freq;

% Back to time domain
filtered_signal = real(ifft(noisy_signal_filtered));

% PSD of filtered signal
PSD_filtered = (X_filtered .* conj(X_filtered)) / N;

% Plot PSD comparison
figure
plot(freq,PSD,'r'); hold on
plot(freq,PSD_filtered,'b');
grid on
xlabel('Frequency (Hz)')
ylabel('Power')
title('PSD of Noisy and Noise-removed ECG Signal')
legend('Noisy Signal PSD','Filtered Signal PSD')

% Remove 50Hz component
fs1 = 48;  % Lower stopband edge
fs2 = 52;  % Upper stopband edge

fp1 = 45;  % Lower passband edge
fp2 = 55;  % Upper passband edge

wp = [fp1 fp2] / (Fs/2); % Passband
ws = [fs1 fs2] / (Fs/2); % Stopband

% Filter specifications
Rp = 1;    % Passband ripple (dB)
Rs = 40;   % Stopband attenuation (dB)

% buttord to Find Filter Order
[N, Wn] = buttord(wp, ws, Rp, Rs);

% Butterworth Band-Stop Filter
[b, a] = butter(N, Wn, 'stop');

% Magnitude & Phase response using freqz()
figure
freqz(b, a, 1024, Fs)
title('Magnitude and Phase Response of Butterworth Notch Filter (50 Hz)')

reconstructed_signal = clean_signal_with_noise;

% Zero-phase filtering to avoid phase distortion
filtered_signal = filtfilt(b, a, reconstructed_signal);

% PSD of reconstructed (noisy) signal
N = length(reconstructed_signal);
X_noisy = fft(reconstructed_signal);
PSD_noisy = (X_noisy .* conj(X_noisy)) / N;

% PSD of filtered signal
X_filtered = fft(filtered_signal);
PSD_filtered = (X_filtered .* conj(X_filtered)) / N;

figure
plot(freq, PSD_noisy, 'r', 'LineWidth', 1.5); hold on
plot(freq, PSD_filtered, 'b', 'LineWidth', 1.5)
grid on
xlabel('Frequency (Hz)')
ylabel('Power')
title('PSD Before and After 50 Hz Butterworth Filtering')
legend('Before Filtering', 'After Filtering')




