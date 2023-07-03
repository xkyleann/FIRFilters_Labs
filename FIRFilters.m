% Filter specifications
order = 50;              % Filter order
cutoff_frequency = 0.4;  % Normalized cutoff frequency (between 0 and 1)
window_type = 'low';     % Window type

% Design the filter coefficients
filter_coeffs = fir1(order, cutoff_frequency, window_type);

% Generate a random signal
Fs = 1000;              % Sample rate (Hz)
t = 0:1/Fs:1;           % Time vector
x = sin(2*pi*50*t) + 0.5*sin(2*pi*120*t);  % Input signal (containing 50Hz and 120Hz components)

% Apply the filter to the signal
filtered_signal = filter(filter_coeffs, 1, x);

% Plot the original and filtered signals
figure;
subplot(2, 1, 1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal');

subplot(2, 1, 2);
plot(t, filtered_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal');