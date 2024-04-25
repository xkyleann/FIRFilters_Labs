# Implementing a practical software radio receiver in GNU Radio


## Overview
The goal of this lab is to build a simple FSK receiver that makes use of a USRP device to receive signals transmitted in the ISM 860 MHz band by the instructor. This exercise will introduce you to practical aspects of digital communication systems using software-defined radio.

![Two methods for generating a modulated signal](URL_to_figure_1)

_Figure 1. Two methods for generating a modulated signal_

## Task 1: Setting Up the Environment

1. **Open a Terminal in Linux**
2. **Create a Directory:**
   - Run `mkdir <directory_name>` to create a new directory.
   - Navigate into the directory using `cd <directory_name>`.
3. **Connect the USRP:**
   - Connect the USRP device to your system.
   - Verify the device is recognized with the command `uhd_find_devices`.
   - Consult the instructor if there are any issues recognizing the device.

## Task 2: Initializing GNU Radio

1. **Launch GNU Radio Companion:**
   - Run `gnuradio-companion` in the terminal.
2. **Create a New Schematic:**
   - In GNU Radio Companion, create a new schematic by selecting **File → New**.
   - In the Options block, select **WXGUI** as the graphical toolkit (if available, otherwise use **QTGUI**).

## Task 3: Configure USRP and Spectrum Analyzer

1. **Add USRP Source Block:**
   - Place a UHD USRP Source block to receive the signals.
   - Set the receiving frequency to `864e6`, gain to `25`, and antenna to `TX/RX`.
2. **Add and Configure Spectrum Analyzer:**
   - Place a WX GUI FFT Sink (spectrum analyzer) block.
   - Set `Average` to `ON` and `Average Alpha` to `0.2` to smooth the spectrum display.

## Task 4: Signal Detection and Frequency Adjustment

1. **Detect Signal Frequency:**
   - Initially, set a high sampling frequency (6.25 MHz for N devices or 8 MHz for B devices) to capture the full range of potential transmission frequencies (861-867 MHz).
   - Identify the exact frequency of the transmitted signal.
2. **Adjust USRP Source Settings:**
   - Once the frequency is identified, adjust the USRP Source frequency to this value and reduce the sampling rate to `500 KHz`.
   - Confirm the center frequency is at the middle of the spectrum display (at `0`).

## Task 5: Building the Software Receiver

1. **Shift Signal to Intermediate Frequency:**
   - Multiply the signal by a complex sine wave to upconvert it to an intermediate frequency (`150 kHz`).
   - Use a Complex to Real block to extract the real part of the signal.
2. **Verify Spectrum Shift:**
   - Change the format in the spectrum analyzer from Complex to Float to observe the shifted spectrum.

## Task 6: Analyze and Filter the Signal

1. **Filter Design:**
   - Implement two Band Pass filters:
     - First filter for `ones` set between the intermediate frequency and the end of the first lobe.
     - Second filter for `zeros` set between the start of the first lobe and the intermediate frequency.
     - Configure `Transition Width` to `10 kHz` and `Gain` to `4`.
2. **Signal Squaring and Envelope Detection:**
   - Place a Multiply block after each filter to square the signals.
   - Add Low Pass filters to extract the signal envelope and eliminate higher frequency components.

## Task 7: Decode the Transmitted Binary Sequence

1. **Signal Decoding:**
   - Subtract the outputs of the two signal paths using a Subtract block.
   - Apply a Threshold block to detect when the signal crosses zero.
2. **Observe and Analyze:**
   - Use a two-input scope to observe the signals post-Subtraction and post-Threshold.
   - Adjust settings in the scope (V Scale to 0.3, T Scale to 0.1 ms, and AC Couple to OFF) to analyze the waveform properly.

## Conclusion

Present the final results and the decoded binary sequence to the instructor for verification.
