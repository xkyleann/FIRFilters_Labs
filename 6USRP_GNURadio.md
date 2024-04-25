# USRP and GNU Radio environment
- Wireless Techniques and Systems Lab Classes.



## Tasks 
 
### Section 1
**Task 1: Set Up and Prepare the Environment** 
1. Open a **Terminal** in Linux.
2. Create a new directory using command **'mkdir <name>'** then **cd <directory_name>**
3. Connect **USRP Device** and ensure it is recognized by the system by running **uhd_find_devices**


**Task 2: Initialize GNU Radio Companion** 
1. Run **gnuradio-companion**
2. Create a **new schematic** by selecting **File → New** in the **GNU Radio**
3. In the **Options** block, switch from **QTGUI** to **WXGUI**. --> NOTE: Some versions do not have WXGUI so it can be done with QTGUI. S


**Task 3: Configure the USRP Source Block** 
1. **ctrl+f** and find **USRP Source Block**
2. In **RF Options**
  - Set **Center Frequency** to **939 MHz** which is **(939e6)**
  - Configure **Grain** based on the USRP model:
  - For most devices, set **Ch0: Gain to 25 dB.**
  - If using a **B210** device, set the gain to **42 dB.**
3. Select the **Antenna connector** as **Ch0: Antenna** and set it to **TX/RX**. Ensure it is properly connected to the **RF board**.


**Task 4: Set Up the Spectrum Analyzer** 
1. Add the **WX GUI FFT Sink**  (spectrum analyzer) or **QT GUI Frequency Sink** block to the schematic.
2. Turn the **Average** to **ON**.
3. Set the **Average Alpha** to **0.6**.
4. Connect the spectrum analyzer to the **USRP Source** by linking the input and output ports.

**Task 5: Experiment with Sampling Frequency** 
1. Define a **Variable block** for the sampling frequency **(samp_rate)**.
2. Test different values to understand how sampling **frequency affects** the observable **frequency bandwidth**:
3. Use a **small value** and a **large value** of sampling frequency (e.g., 8e6 for 8 MHz).
4. Finally, set the **sampling frequency** to **8 MHz or 12.5 MHz** (for N200) to observe multiple base stations simultaneously.

**Task 6: Experiment with Sampling Frequency** 
1. After identifying the frequency with the cleanest GSM signal, set it as the **center frequency** of your **USRP Source**.
2. Change the sampling frequency to **1 MHz** to focus on this **GSM base station**.
3. Use the **Peak Hold** feature during a frequency correction burst to capture the spectrum.

### Section 1 - Results
**Here are my schematics:**
<img width="863" alt="Ekran Resmi 2024-04-25 21 46 11" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/7b676559-9f71-4e08-a13c-986ae33ce577">
<img width="1501" alt="Ekran Resmi 2024-04-25 22 33 46" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/8c7819ee-bb9e-4f80-9a25-3ed34d867bde">



#### Here are my results (Var Block Value = 2e6 and K=2 for CPFSK Amplitude .02):
<img width="2045" alt="Ekran Resmi 2024-04-25 22 08 14" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/c22d8ca3-a1bc-48dc-817b-eb1cae8cb29c">


#### (Var Block Value = 2e6 and K=1 for CPFSK Amplitude .02):
<img width="2046" alt="Ekran Resmi 2024-04-25 22 08 34" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/684b7546-10d3-4aa3-a156-cade6a4c3de9">

#### (Var Block Value = 8e6 and K=2 for CPFSK and Amplitude .02):
<img width="2048" alt="Ekran Resmi 2024-04-25 22 09 07" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/b7fe8ae0-818b-4454-bfd1-19da4069eba0">


#### (Var Block Value = 8e6 and K=1 for CPFSK and Amplitude .08):
<img width="2015" alt="Ekran Resmi 2024-04-25 22 07 29" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/99ee0ee5-723f-4b24-a411-6ae187e156ad">


--------


### Section 1C Analysis of FSK modulatin using GNU Radio
NOTE: Done with QT GUI

#### **Here are my schematic:**
<img width="1653" alt="Ekran Resmi 2024-04-25 22 29 07" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/b976981c-77d3-4e16-bd1a-cd0ed78b4f84">

#### Here are my results (Var Block Value = 2e6 and K=1 for modulation index equal to 1 ):
<img width="2048" alt="Ekran Resmi 2024-04-25 22 30 58" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/441afd7f-3e5b-4ced-b2a1-ce122e7ebccd">


#### (Var Block Value = 2e6 and K=1 for modulation index equal to 0.5 ):
<img width="2048" alt="Ekran Resmi 2024-04-25 22 31 36" src="https://github.com/xkyleann/FIR_Filters/assets/128597547/933e1801-29ed-4561-bb11-a7bef65ee0eb">


---
### Section 1 - Conclusion

As conclusion, when we used a small sampling frequency (e.g. 8MHz) compared to the bandwidth of interest ((GSM signals typically occupy around 200 kHz), here is what I observed:
- The spectrum analyzer will capture a limited portion of the actual signal.
- Higher frequency components beyond the Nyquist limit (half the sampling frequency) will be folded back (aliased) into the observable bandwidth. This creates a distorted view of the actual spectrum.

Conversely, using a large sampling frequency (e.g., much higher than 2 MHz) offers several advantages:
- A wider range of the spectrum becomes observable, allowing you to potentially capture multiple GSM base stations or other signals within the receiver's range.
- Aliasing is minimized, providing a more accurate representation of the actual signal.

However, there's a trade-off. A higher sampling rate requires the SDR to process more data, which can strain computational resources and potentially lead to data loss.

To sum up, by trying a small and large sampling frequency, the user can observe how the visible spectrum on the spectrum analyzer changes. The small value will likely capture only a portion of the GSM signal, while the large value might show multiple signals if present within the receiver's range. This helps the user understand the impact of sampling frequency on the amount of information captured by the SDR.
The chosen sampling frequency determines the balance between the observable bandwidth and the detail captured within that bandwidth. It's crucial to select a sampling rate high enough to avoid aliasing the signal of interest while considering computational limitations.

