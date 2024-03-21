% Implementation of OFDM transmission based on Wi-Fi
ncarriers = 207;
FFTsize = 1024; 
fs = 80e6;
carrier1 = 100;
data = randi( [0,1] , [1,207]);
pskData = pskmod(data, 2, pi);
scatterplot(pskData)
datavector = zeros(FFTsize, 1);
datavector(carrier1:carrier1+ncarriers-1) = pskData;
TX = ifft(datavector);
RealTX = real(TX);

% Figure 1 -- Plotting 
figure(1); plot(RealTX);

% Figure 2 -- Plotting 
figure(2); pwelch(RealTX,[],[],[],fs); 

% SNR = Signal-to-Noise Ratio = 15 dB
SNR = 48; RX = awgn(RealTX, SNR, 'measured', [], 'dB');
afterFFT= fft(RX);
receivedSymbols = afterFFT(carrier1:carrier1+ncarriers-1);
scatterplot(receivedSymbols)
receivedData = pskdemod(receivedSymbols,2,pi);

% Figure 3 -- Plotting
figure(3); subplot(211); stairs(data,'b'); axis([1 40 -0.1 1.1]);
receivedData = pskdemod(receivedSymbols, 2 ,pi);
data = randi( [0,1] , [1,52]);

% Part 2 -- Optional
hpn = comm.PNSequence('Polynomial',[7 6 0], 'SamplesPerFrame',207,'InitialConditions',[1 1 1 1 1 1 0]);
data = step(hpn);

