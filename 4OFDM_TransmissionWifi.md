## Implementation of OFDM transmission based on Wi-Fi
* The goal of this lab is to implement a basic code of software OFDM transmitter and receiver, to understand how a wireless transmission on multiple carriers works, and what is the relationship between its basic parameters.
* To be able to follow each step of signal processing, we will examine the transmission of one OFDM symbol composed on multiple carriers, which will allow us to send several bits at a time (we will not take into account the pilot symbols and will use a simple BPSK modulation).

* ## Tasks
* The number of carrier frequencies will be 16 at the beginning and 52 later:
```Matlab
>> ncarriers = 16;
```

* FFT size will be 256 and the sampling frequency 80 MHz:
```Matlab
>> FFTsize = 256;
>> fs = 80e6;
```

* First carrier for data transmission:
```Matlab
>> carrier1=40;
```

* In our first experiment with OFDM, we will send 16 bits of data:
```Matlab
>> data = [ 1 1 1 1 0 1 0 1 1 0 0 1 0 0 0 1 ];
```

* Next we will map these bits to symbols of BPSK modulation:
```Matlab
>> pskData = pskmod(data, 2, pi);
```

* As you know from the lecture and labs, the BPSK constellation maps **1 to 1 and 0 to –1** (unipolar to bipolar conversion). Therefore, the pskmod function simply changed zeros to –1, which we can see writing
```Matlab
>> pskData’
```

* The apostrophe at the end will allow us to print a column instead of a raw (to facilitate reading in the command line). In this simple way we mapped the data to BPSK symbols and we are ready to transmit them using OFDM. In the next step we will display the constellation:
```Matlab
>> scatterplot(pskData)
```

* To prepare the data for an inverse FFT, we put BPSK symbols to the correct positions in a vector, so that they are placed on the following carriers after IFFT. Since we will use a **256 points fast Fourier** transform, but we need only 16 carriers (why we do that should become clear later) we have to fill in the vector with zeros and then insert our data at the selected positions.
```Matlab
>> datavector = zeros(FFTsize, 1);
```
and we fill in the parallelData vector with the modulation symbols starting from the 40th element, which is set by carrier1 variable (it should become clear later why we do not fill it in from the beginning)

```Matlab
>> datavector(carrier1:carrier1+ncarriers-1) = pskData;
```

* Make sure that all the BPSK symbols have been inserted and that there are zeros around them:
```Matlab
datavector
```

* Next, we move to the most important step of OFDM transmission: the IFFT. It will allow us to get the
waveform that corresponds to the data placed orthogonally on the selected carrier frequencies:
```Matlab
>> TX = ifft(datavector);
```
* To the receiver we will send only the real part of the signal.
```Matlab
>> RealTX = real(TX);
```
* That was the last signal processing step in the digital part of the transmitter. Next, we plot the signal in the time domain:
```Matlab
>> figure(1); plot(RealTX);
```

* This signal will look like noise when the number of carriers is high enough. We only have 16 carriers now, but later we will have 52 carriers and the result will be similar to that in Fig 1.
Next, we observe the spectrum of the signal:
```Matlab
>> figure(2); pwelch(RealTX,[],[],[],fs); % fs is the sampling frequency defined before
```

* As we can see from the spectrum, we obtained an OFDM signal at the frequencies around 20 MHz. After the digital-to-analog conversion the signal can be shifted to the final frequency, e.g., to 2.4 GHz band, by a simple multiplication with a sinusoidal signal from a generator.
The spectrum does not look like a typical OFDM spectrum yet (the edges are not very steep), because we only have 16 carriers. Later, we will have 52 carriers, as in Wi-Fi, and the spectrum will look like in the left panel of Figure 2.

```Matlab
>> SNR = 15; RX = awgn(RealTX, SNR, 'measured', [], 'dB');
```

* This way in RX we get the signal expected at the receiver input for the signal-to-noise ratio equal **15 dB**.
* The first step in the receiver is to perform an FFT:
```Matlab
>> afterFFT= fft(RX);
```

* Next we extract only the carriers that carried the data:
```Matlab
>> receivedSymbols = afterFFT(carrier1:carrier1+ncarriers-1);
```
  * and we plot the signal constellation:
```Matlab
>> scatterplot(receivedSymbols)
```
* The received symbols have to be demodulated:
```Matlab
>> receivedData =pskdemod(receivedSymbols,2,pi);
```
* In our case (BPSK modulation), the demodulator checks whether the number is positive or **negative** and **assigns 1 or 0**, respectively.
* Make sure that the transmitted data is the same as the receivedData:
```Matlab
>> figure(3); subplot(211); stairs(data,’b’); axis([1 40 -0.1 1.1]);
>> subplot(212); stairs(receivedData,'r'); axis([1 40 -0.1 1.1]);
```
* If the transmission had no errors, modify your code to use 52 carriers, as in Wi-Fi. It should be enough to change the ncarrier variable to 52 and generate 52 bits of data using randi function: >> data= randi( [0,1] , [1,52]);
Save all interesting results for your report (including the waveform and the spectrum). Make sure that you understand each step.
Next, experiment with inserting the data in a different place of the datavector (using the parameter carrier1). First, start from the position number 102 (that is in the middle part of the vector) and next from the position number 24. In each case observe the spectrum location. In your report, respond to the question: why we cannot place the data exactly in the middle of the vector?
Return to the initial setting, that is carrier1 = **40**.

* To understand why we used a 256 point FFT, modify the length of FFT to 512 and compare the results. You should see two changes: the width of the spectrum and the distance between the carriers. In Wi-Fi this distance is equal to 312.5 kHz, which we obtain automatically by selecting the required sampling frequency and FFT size.
