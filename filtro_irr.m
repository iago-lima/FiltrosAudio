clc
close all
clear all

[x, fs, Nbits] = wavread('audio_voz.wav'); %carrega o audio
[N, M] = size(x); %Tamanho do vetor
f= [0:N]*(fs/N); % tamanho do grafico de 0 a frequencia da amostragem

[num, den] = butter(20, 0.11);
[H,W] = freqz(num, den, 512, fs);

%Espectro do sinal filtrado
p = filter(num, den, x); 
P = fft(p);
soundsc(p, fs);
  