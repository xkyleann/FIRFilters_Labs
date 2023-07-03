# Design and Implementation of Finite Impulse Response (FIR) Filters
This project focuses on the design and implementation of Finite Impulse Response (FIR) filters. FIR filters are widely used in digital signal processing for applications such as audio and image processing. The project includes examples implemented in Matlab to demonstrate the design and analysis of FIR filters.

In signal processing, a finite impulse response (FIR) filter is a filter whose impulse response (or response to any finite length input) is of finite duration, because it settles to zero in finite time. This is in contrast to infinite impulse response (IIR) filters, which may have internal feedback and may continue to respond indefinitely (usually decaying)

## Introduction 
Finite Impulse Response (FIR) filters are a class of digital filters with a finite impulse response. They are characterized by their **_linear phase response_** and **_stability_**. In this project, we explore the design and implementation of FIR filters using various design methods.

## Defination

For a **_causal discrete-time_** FIR filter of order N, each value of the output sequence is a weighted sum of the most recent input values:

$$ y[n] = b[0] * x[n] + b[1] * x[n-1] + b[2] * x[n-2] + \ldots + b[N] * x[n-N] = \sum_{i=0}^{N} b_i * x [n-i] $$

where
* x[n] is the input signal,
* y[n] is the output signal,
* N is the filter order; an Nth order filter has N+1 terms on the right side.




### Design Methods

<details>
<summary><b> 1. Windowing Method   </b></summary>
<a> The project covers the design of FIR filters using windowing techniques such as the Hamming, Hanning, and Kaiser windows. These methods allow for the design of filters with desired frequency response characteristics.</a>
</details>

<details>
<summary><b> 2. Frequency Sampling Method  </b></summary>
<a> The frequency sampling method is another approach to design FIR filters. This method allows for specifying the desired frequency response directly by sampling it at specific frequency points. </a>
</details>

<details>
<summary><b> 3. Parks-McClellan Method </b></summary>
<a>  The Parks-McClellan algorithm, also known as the Remez exchange algorithm, is a powerful method for designing FIR filters. It provides optimal filter design by minimizing the maximum approximation error. </a>
</details>

### Implementation in MATLAB 

<details>
<summary><b> 1. Filter Design   </b></summary>
<a> MATLAB code demonstrates how to design FIR filters using different design methods, including windowing, frequency sampling, and the Parks-McClellan algorithm.</a>
</details>

<details>
<summary><b> 2. Filter Analysis   </b></summary>
<a>  Analysis of FIR filters, including frequency response analysis, impulse response analysis, and magnitude and phase response plots.</a>
</details>

<details>
<summary><b> 3. Filter Application  </b></summary>
<a> The application of FIR filters to practical signal processing tasks, such as audio filtering and image enhancement.</a>
</details>


### Conclusion 
The design and implementation of Finite Impulse Response (FIR) filters play a vital role in digital signal processing. This project provides a comprehensive understanding of FIR filter design methods and their implementation using MATLAB. By studying and applying the examples, readers can gain practical insights into designing and analyzing FIR filters for various signal processing applications.

### MATLAB Code 
```matlab
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
```

### Result
<img width="745" alt="image" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/0b2ab6f2-a2bc-4678-9973-a42f313b1cd0">

 
## Low-pass FIR filter using the windowing method with a Hamming window
```matlab
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
```

### Result | Magnitude Response (dB)
<img width="745" alt="image" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/b6c6bb58-aba6-4deb-b7f0-b11f61e0a6ff">

### Result | Phase Response (dB)
<img width="745" alt="image" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/269c334d-bcab-44ba-8151-6e72b997fef9">

<details>
<summary><b> Explanation </b></summary>
<a> A low-pass FIR filter with a passband frequency of 100 Hz and a stopband frequency of 200 Hz. The code then generates an input signal consisting of a sinusoid with added noise and filters the signal using the designed FIR filter through convolution. Finally, the input and filtered signals are plotted for visualization.</a>
</details>


### Source (within MLA Format)
- [Farhang-Boroujeny, Behrouz. "Design and Implementation of Finite Impulse Response (FIR) Filter." ResearchGate, 2016](https://www.researchgate.net/publication/297129417_Design_and_implementation_of_finite_impulse_response_FIR_filter)
- [Rao, Tapas. "Design and Implementation of FIR Filter." MATLAB Central File Exchange, MathWorks, 2011. Accessed 3 July 2023.](https://www.mathworks.com/matlabcentral/fileexchange/31085-design-and-implementation-of-fir-filter)
- ["Finite impulse response." Wikipedia, The Free Encyclopedia. Wikimedia Foundation, Inc. 19 June 2021. Web.](https://en.wikipedia.org/wiki/Finite_impulse_response)
