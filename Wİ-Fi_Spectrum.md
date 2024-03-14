# Analyzing the spectrum spreading technique used in the basic physical layer of Wi-Fi
* The goal is to analyze the operation of Wi-Fi in 1 Mbit/s mode, which is the most robust mode of operation. It is used in the most difficult radio channel conditions and allows to obtain the longest range. It uses the direct-sequence spread-spectrum technique.
The system will operate at the carrier frequency of 2442 MHz (channel 6).

## Tasks 
* Use the same PN Sequence Generator as in the previous lab (Generator polynomial = 'z^7+z^6+1' or in an alternative notation [7 6 0] and Initial states = [1 1 1 1 1 1 1]). Set the Sample time correctly, knowing that the data rate is 1 Mbit/s.
* The M parameter in the Unipolar to Bipolar converter should be set to 2.
* Set the frequency of the Sine wave to the carrier frequency and the Sample time to 0.1 ns.
* The Spectrum Analyzer should be taken from the DSP System Toolbox. Adjust its settings: Sample rate should be set to Inherited and the Method to Welch. Since we want to observe the spectrum in the frequency range of 2.4 to 2.484 GHz, disable Full frequency span, set Fstart to 2.4e9 and Fstop to 2.484e9. In the Trace options set Averaging method to Running ,and Averages = 8. Uncheck Two-sided spectrum.
* The recommended simulation time is 160 μs (in MatLab is has to be 160e-6). Observe the spectrum. Save the obtained plot.

* Next, implement the spectrum spreading using the Barker Code Generator
* >> set_param('wifi/Product','SampleTime','0.1e-9') (To MatLab, change wifi to your file name)

* Next, build the receiver. In the AWGN block set the Signal to noise ratio (SNR) to 100 (attention: SNR not Eb/No).
* he receiver uses the same Barker code as the transmitter. In some versions of Matlab, the Sign block is difficult to find in and the easiest way to find it is to search for “signum”. In the Integrate and Dump set the Integration period to 10000.

* Make sure that you receive the data correctly using the Scope. To see all three plots, open the Scope, go to View → Layout and select three rectangles vertically. Save the obtained plot. Make sure that you undestand the shape of the waveform obtained after Product3.

## Conclusion
Compare the spectrum at the receiver input (that is after the AWGN channel) and the spectrum after the multiplication with the Barker code in the receiver. To do that, enable the second input in the Spectrum Analyzer1 and connect there the output of Product2. Make sure that you see the correlation effect explained in the lecture.

## Project Result (Output of Scope)

## Project File
[Project 3 File]()
