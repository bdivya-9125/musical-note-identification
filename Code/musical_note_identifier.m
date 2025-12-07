 
% Read audio file 
[data, Fs] = audioread('piano_A2.wav'); 
tic; 
 
% Get note windows 
w = notewindows(data); 
 
% How many notes in this sample 
num_notes = length(w) - 1; 
disp(['Number of notes: ', num2str(num_notes)]); 
 
% Initialize frequency array 
freq = zeros(1, num_notes);   
 
% Create a new figure for plotting 
figure; 
 
% Plot the original audio signal 
subplot(3, 1, 1); % 3 rows, 1 column, 1st subplot 
t = (0:length(data)-1) / Fs; % Time vector for the original audio 
plot(t, data); 
title('Original Audio Signal'); 
xlabel('Time (seconds)'); 
ylabel('Amplitude'); 
grid on; 
 
for i = 1:num_notes 
    % Take the window for the current note 
    cur_note = data(w(i):w(i+1)); 
    len = length(cur_note); 
     
    % Compute FFT of the current note 
    cur_fft = abs(fft(cur_note)); 
    cur_fft = cur_fft(1:len/2+1);  % Retain positive frequencies 
     
    % Create frequency axis 
    freq_axis = (0:len/2) * Fs / len; 
 
    % Find maximum magnitude and its index 
    [Y, I] = max(cur_fft); 
    max_frequency = freq_axis(I); 
     
    % Store frequency 
freq(i) = max_frequency; 
% Display frequency and note info 
disp(['Frequency: ', num2str(max_frequency)]); 
[p, o] = findpitch(max_frequency); 
disp(['Pitch: ', num2str(p)]); 
disp(['Octave: ', num2str(o + 4)]); 
% Plot the FFT for the current note 
subplot(3, 1, 2); % 3 rows, 1 column, 2nd subplot 
hold on; % Hold on to plot multiple FFTs 
plot(freq_axis, cur_fft); 
title('FFT of Notes'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude'); 
xlim([0, Fs/2]);  % Set x-axis limits 
grid on;  % Add a grid for better visualization 
% Highlight the peak frequency on the plot 
plot(max_frequency, Y, 'ro', 'MarkerSize', 10); % Highlight the peak 
end 
% Finalize the FFT plot 
legend('FFT Magnitude', 'Peak Frequency'); 
% Plot frequencies detected for each note 
subplot(3, 1, 3); % 3 rows, 1 column, 3rd subplot 
plot(1:num_notes, freq, 'o-'); 
title('Detected Frequencies of Notes'); 
xlabel('Note Index'); 
ylabel('Frequency (Hz)'); 
grid on; 
toc; 
quiet = 1;  % flag for quiet/noisy state 
j = 1; 
% Additional Functions (include these below your main code) 
function divs = noteparse(data) 
len = length(data); 
threshup = 0.2 * max(data);  % 20% of the maximum value 
threshdown = 0.04 * max(data); 
for i = 51:len-50 
        if quiet == 1  % looking for beginning of a note 
            if (max(abs(data(i-50:i+50))) > threshup) 
                quiet = 0;  % found the start 
                divs(j) = i;  % record division point 
                j = j + 1; 
            end 
        else 
            if (max(abs(data(i-50:i+50))) < threshdown) 
                quiet = 1;  % note's over 
                divs(j) = i; 
                j = j + 1; 
            end 
        end 
    end 
end 
 
function w = notewindows(data) 
    divs = noteparse(data); 
    d2(1) = 0; 
 
    for i = 1:length(divs) 
        d2(i + 1) = divs(i); 
    end 
 
    d2(length(divs) + 2) = length(data); 
 
    for i = 1:length(d2)/2 
        w(i) = (d2(2*i - 1) + d2(2*i)) / 2; 
    end 
end 
 
function [pitch, octave] = findpitch(freq) 
    octave = helpfindoctave(freq, 0); 
    pitch = choosepitch(freq / 2^octave); 
end 
 
function oct = helpfindoctave(f, o) 
    if f >= 254.284 && f <= 508.5675 
        oct = o; 
    elseif f < 254.284 
        oct = helpfindoctave(2*f, o - 1); 
    elseif f > 508.5675 
        oct = helpfindoctave(f / 2, o + 1); 
    end 
 
end 
 
function p = choosepitch(f) 
    if f >= 254.284 && f < 269.4045 
        p = 1; disp('C'); 
    elseif f >= 269.4045 && f < 285.424 
        p = 2; disp('C#'); 
    elseif f >= 285.424 && f < 302.396 
        p = 3; disp('D'); 
    elseif f >= 302.396 && f < 320.3775 
        p = 4; disp('D#'); 
    elseif f >= 320.3775 && f < 339.428 
        p = 5; disp('E'); 
    elseif f >= 339.428 && f < 359.611 
        p = 6; disp("F"); 
    elseif f >= 359.611 && f < 380.9945 
        p = 7; disp("F#"); 
    elseif f >= 380.9945 && f < 403.65 
        p = 8; disp("G"); 
    elseif f >= 403.65 && f < 427.6525 
        p = 9; disp("G#"); 
    elseif f >= 427.6525 && f < 453.082 
        p = 10; disp("A"); 
    elseif f >= 453.082 && f < 480.0235 
        p = 11; disp("A#"); 
    elseif f >= 480.0235 && f < 508.567 
        p = 12; disp("B"); 
    else 
        error('Frequency outside of acceptable range'); 
    end 
end
