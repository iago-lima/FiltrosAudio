clc
close all
clear all

[x, fs, Nbits] = wavread('audio_voz.wav'); %carrega o audio
[N, M] = size(x); %Tamanho do vetor
f= [0:N]*(fs/N); % tamanho do grafico de 0 a frequencia da amostragem


figure(1);
plot(x); %Plota  espectro do audio original no tempo
title('GRAFICO DO AUDIO ORIGINAL NO TEMPO');
xlabel('Tempo');
ylabel('Amplitude');
grid on

%Recorte do audio de 1 a 8 segundos
N = length(x);
t = (0 : N - 1)/fs;
y_sub = x((t >= 1) & (t <= 7));

N = length(y_sub) - 1;
f = 0:fs/N:fs;
X = abs(fft(y_sub));

figure(2), plot(f(1:N/2),X(1:N/2));
title('Espectro do audio na frequencia com filtro FIR');
xlabel('Frequencia em Hz');
ylabel('Magnitude');

%Espectro do filtro FIR
num = fir1(447,[0.11]); %Passa banda com janela de Hamming de ordem 447
[H,w] = freqz(num, 1, 512, fs); %Passa o filtro para o dominio da frequencia


figure(3), plot(w, abs(H), 'color', 'red');
title('Espectro do audio na frequencia com filtro FIR');
xlabel('Frequencia em Hz');
ylabel('Magnitude');
grid on
hold on

y_teste = conv(w, y_sub);

figure(4);
plot(y_teste);
title('GRAFICO DO AUDIO FILTRADO NO TEMPO');
xlabel('Tempo');
ylabel('Amplitude');
grid on


%soundsc(y_sub);
%wavwrite(y_teste, fs, 'audio_fir.wav');


