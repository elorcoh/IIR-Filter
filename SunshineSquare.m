%% initialize:
clear all; close all;

%% original signal:
[y,Fs] = audioread('SunshineSquare.wav');

%% Spectroom analysis:
L=length(y);
NFFT=2^(nextpow2(L)); %calculate the closest next power of 2 to the signal length, required for the FFT algorythm
Y_FFT=abs(fft(y,NFFT));% Calculate the DFT of the signal (Amplitude as function of frequency) using FFT ,require for finding the unwanted frequencies /
%Y_FFT1=abs(fftshift(Y_FFT));%-""- dont have to use!
f=(Fs).*(0:(NFFT/2-1))/NFFT;% xaxis for ploting normalize in NFFT.
subplot(2,2,1)
plot(f,Y_FFT(1:length(f)));
title('DFT of orignal signal using FFT')
xlabel('frequency normalized by NFFT');
ylabel('Magnitude');
subplot(2,2,2)
title('input signal');
plot(y);
grid;


%% Filtering using 4 Fir:
hn1=[1,-2.0000000000,1];
hn2=[1,-1.246979654,1];
hn3=[1,0.445041864,1];
hn4=[1,1.801937747,1];
hn=conv(hn1,hn2);
hn=conv(hn,hn3);
hn=conv(hn,hn4);
con=conv(y,hn);%final signal after been filtered
confft=abs(fft(con));
subplot(2,2,2);
plot(con)
title('Signal distrect time after filter')
%% frequency response of ecery filter:
figure(2); freqz(hn1)
title('Hn1 Frequency response')
figure(3); freqz(hn2)
title('Hn2 Frequency response')
figure(4); freqz(hn3)
title('Hn3 Frequency response')
figure(5); freqz(hn4)
title('Hn4 Frequency response')
figure(6); freqz(hn);
title('Hn filter frequency response')
%% spectogram analysis :
figure(7)
spectrogram(y,L,NFFT/2,NFFT,Fs)%before
figure(8)
spectrogram(con,L,NFFT/2,NFFT,Fs)%after
%% New audio filtered:
audiowrite('SunshineSquare_filtered.wav',con,Fs);