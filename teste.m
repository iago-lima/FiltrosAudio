clc
close all
clear all

[x, fs, Nbits] = wavread('audio_voz.wav'); %carrega o audio
[N, M] = size(x); %Tamanho do vetor
f= [0:N]*(fs/N); % tamanho do grafico de 0 a frequencia da amostragem

%Recorte do audio de 1 a 8 segundos
N = length(x);
t = (0 : N - 1)/fs;
y_sub = x((t >= 1) & (t <= 7));

N = length(y_sub) - 1;
f = 0:fs/N:fs;
X = abs(fft(y_sub));

%Espectro do filtro FIR
num = fir1(447,[0.11]); %Passa banda com janela de Hamming de ordem 447
[H,w] = freqz(num, 1, 512, fs); %Passa o filtro para o dominio da frequencia

y_teste = conv(w, y_sub);



soundsc(y_teste, fs);

