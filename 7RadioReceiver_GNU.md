# Implementing a practical software radio receiver in GNU Radio


## Overview
The goal of this lab is to build a simple FSK receiver that makes use of a USRP device to receive signals transmitted in the ISM 860 MHz band by the instructor. This exercise will introduce you to practical aspects of digital communication systems using software-defined radio.


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


## Results
**Here are my schematics:** <img width="1744" alt="Ekran Resmi 2024-04-25 23 52 13" src="https://github.com/xkyleann/FIRFilters_Labs/assets/128597547/4bbe5984-e018-4fa4-b17b-7bc0188e8401">

**With Throttle Block**
<img width="1719" alt="Ekran Resmi 2024-04-26 00 06 00" src="https://github.com/xkyleann/FIRFilters_Labs/assets/128597547/b0c5c6d6-ba9a-4f24-a72d-c3064181c9b0">

**Spectrum Results 500kHz**
<img width="2044" alt="Ekran Resmi 2024-04-26 00 14 54" src="https://github.com/xkyleann/FIRFilters_Labs/assets/128597547/8d855c70-5f0d-4641-8ce4-2dc4751ffdde">


**Spectrum Results 8MHz**
<img width="2048" alt="Ekran Resmi 2024-04-26 00 16 17" src="https://github.com/xkyleann/FIRFilters_Labs/assets/128597547/52beaa60-abeb-4f49-be84-4996752c3c68">


## Conclusion

As result, in the end of the lab we have to observe those points:

* **Small Sampling Frequency** (e.g., 8 MHz) Observations:
* **Limited Spectrum Capture:** With a sampling frequency such as 8 MHz, the spectrum analyzer captures only a restricted portion of the entire GSM signal, which typically occupies around 200 kHz. This restricted view can hinder comprehensive signal analysis.
* **Aliasing Issues:** Since the Nyquist limit (half of the sampling frequency) for 8 MHz is 4 MHz, any higher frequency components present will be folded back into the observable range. This aliasing results in a distorted representation of the spectrum, potentially misleading the analysis.
* **Large Sampling Frequency (e.g., Greater than 2 MHz) Benefits**:
* **Extended Spectrum Visibility:** By utilizing a sampling rate significantly above 2 MHz, a broader range of the spectrum becomes observable. This expanded range can accommodate multiple GSM base stations simultaneously or various other signal types within the receiver's capability, offering a more versatile use of the spectrum analyzer.
* **Reduced Aliasing:** A higher sampling rate decreases the chance of aliasing, thereby providing a truer depiction of the actual signals. This accuracy is critical for reliable signal analysis and system design.


**Trade-offs and Computational Considerations:**
 While I was doing this lab, I also realized processing a higher volume of data can lead to computational strain, increasing the likelihood of data loss or system performance issues.
 
**Summary and Practical Implications:**
Experimenting with both lower and higher sampling frequencies illustrates how the choice of sampling rate influences the amount of information captured and the fidelity of that information. Opting for a small sampling rate may suffice for narrowband signals but falls short for comprehensive spectrum analysis or when accuracy in wideband is required. A larger sampling rate, while more computationally demanding, enables a **more accurate** and **extensive analysis** of the **radio environment.**

The key takeaway is the importance of selecting an appropriate sampling frequency that balances the need for detailed, accurate spectrum analysis against the limitations of hardware and software capabilities. This balance is crucial for effective signal analysis and system performance in practical applications.

However, if I look to my result spectrums, because of I do not have device and some calculation errors there might be mistake. 
