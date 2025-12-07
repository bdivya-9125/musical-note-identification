# 🎵 Musical Note Identification Using Signal Processing

This project implements a MATLAB-based **musical note recognition system** that identifies musical notes from recorded or uploaded audio using FFT and digital signal processing techniques.  
The system extracts the dominant frequency of each segmented note and maps it to the nearest musical pitch and octave.  
This project was completed as part of the **Signals and Systems (BECE202L)** laboratory course.

---

## 🚀 Features

- Time-domain and frequency-domain analysis of audio signals  
- Automatic note segmentation using amplitude-based windowing  
- FFT-based dominant frequency detection  
- Musical note & octave mapping  
- Noise handling and normalization  
- Visualizations for waveform, FFT spectrum, and extracted peaks  
- Supports `.wav` audio input  

---

## 🧠 Methodology

### 1️⃣ Audio Input  
- User uploads or records a `.wav` file  
- Converted into a time-domain signal  

### 2️⃣ Preprocessing  
- Normalization  
- Basic noise reduction  
- Windowing to separate individual notes  

### 3️⃣ FFT-Based Frequency Extraction  
- Time-domain → Frequency-domain  
- Find the **dominant frequency peak**  
- Visualize magnitude spectrum  

### 4️⃣ Note Identification  
Detected frequency is mapped to the closest musical note using standard A440 tuning.

Example:  
- 440 Hz → A4  
- 261.63 Hz → C4  

### 5️⃣ Visualization  
- Time-domain signal  
- FFT spectrum  
- Dominant frequency marker  
- Final identified notes  

---

## ▶️ How to Run

### 1. Open MATLAB  
### 2. Add the project folder to the path:

```matlab
addpath(genpath('musical-note-identification'));
```

### 3. Run the main script:

```musical_note_identifier.m```

### 4️⃣ Select an audio file when prompted  
The script displays:  
- FFT plot  
- Dominant frequency  
- Musical note + octave classification  

---

## 📘 Full Project Report
📄 [View Report](report/Musical%20Notes%20Identification%20Application%20using%20Signal%20Processing%20(2).pdf)

---

## 🎤 Presentation  
📽️ **[View Presentation](presentation/SIGNALS.pptx)**  

---

## 👥 Contributors  
- **Bojja Divya** 
- **Sujithra S**  
- **Thershna T K**  
- **T Lasya**   
- **Dr. S. Sivakumar** *(Supervisor)*  

---

## 🛠 Technologies Used  
- MATLAB  
- Fast Fourier Transform (FFT)  
- Signal Preprocessing  
- Peak Detection  

---


## 📜 License  
This project is licensed under the **MIT License**.




