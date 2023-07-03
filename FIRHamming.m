% Design and Implementation of Low-Pass FIR Filter using Hamming Window

% Filter Specifications
Fs = 1000;       % Sampling frequency (Hz)
Fpass = 100;     % Passband frequency (Hz)
Fstop = 200;     % Stopband frequency (Hz)
Apass = 1;       % Passband ripple (dB)
Astop = 80;      % Stopband attenuation (dB)

% Normalize frequencies
Wpass = (2*Fpass) / Fs;
Wstop = (2*Fstop) / Fs;

% Filter Order Calculation using Hamming Window Method
delta_W = Wstop - Wpass;
M = ceil((Astop - 8) / (2.285*delta_W*pi));
if mod(M, 2) == 0
    M = M + 1;  % Ensure the filter order is odd
end

% Hamming Window Generation
h = hamming(M);

% Ideal Low-Pass Filter Impulse Response Calculation
n = 0:M-1;
hd = (sin(Wstop*pi*(n-M/2)) - sin(Wpass*pi*(n-M/2))) ./ (pi*(n-M/2));

% Windowed Low-Pass Filter Impulse Response
h_lowpass = hd .* h';

% Frequency Response Plot
fvtool(h_lowpass, 1, 'Fs', Fs, 'Color', 'white');
title('Frequency Response of Low-Pass FIR Filter');
legend('Filter Response');

% Signal Generation and Filtering
t = 0:1/Fs:1;  % Time vector
f_signal = 150; % Frequency of the input signal (Hz)
x = sin(2*pi*f_signal*t) + 0.5*randn(size(t)); % Input signal with noise

% Filter Signal using Convolution
y = conv(x, h_lowpass, 'same');

% Plotting Input and Filtered Signals
figure;
subplot(2, 1, 1);
plot(t, x);
title('Input Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, y);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');