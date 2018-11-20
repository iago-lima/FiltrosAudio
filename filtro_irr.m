clc
close all
clear all

[x, fs, Nbits] = wavread('audio_voz.wav'); %carrega o audio
[N, M] = size(x); %Tamanho do vetor
f= [0:N]*(fs/N); % tamanho do grafico de 0 a frequencia da amostragem

[num, den] = butter(20, 0.11);
[H,W] = freqz(num, den, 512, fs);
figure(1);
plot(W, abs(H), 'color', 'blue');
title('ESPECTRO DO AUDIO ORIGINAL NA FREQUENCIA COM FILTRO BUTTERWORTH');
xlabel('FREQUENCIA (Hz)');
ylabel('MAGNITUDE');

grid on;
hold on;

%Espectro do sinal filtrado
p = filter(num, den, x); %filtra o sinal
P = fft(p);
figure(2);
plot(f(1:N/2), abs(P(1:N/2)));
title('ESPECTRO DE FREQUENCIA DO SINAL FILTRADO');
xlabel('FREQUENCIA (Hz)');
ylabel('MAGNITUDE');
grid on;

figure(3);
plot(p,'color','blue');
title('GRAFICO DO AUDIO FILTRADO NO TEMPO');
xlabel('Tempo');
ylabel('Amplitude');

wavwrite(p, fs, 'audio_iir.wav');