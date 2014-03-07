% generate 5 sine waves and compute their phases with the Hilbert transform

%%%% Inputs %%%%
% w: frequency (rad/s)
% fs: sample frequency (Hz)
% d: duration (s)
% p0: initial phase;
% A: wave amplitude;
% nrange: range of noise amplitudes as a 1x2 vector of percents
%         e.g. [0.1; 0.4] so the noise values will be 10,20,30,40%
%         of A
% plot_key: det to 1 if a plot of the signal and its phase is desired

%%%% Outputs %%%%
% sig = 5 column matrix with original signals in it
% sigh = matrix of Hilbert transforms of sig
% phw = matrix with wrapped phase of sig
% phu = matrix with unwrapped phase of sig
% t = time vector is seconds
% pt = true unwrapped phase of the sine wave


function [sig,sigh,phw,phu,t,pt] = sinewave_hilbert_phase(w,fs,d,p0,A,nrange,plot_key)
t = 1/fs:1/fs:d;
pt = w*t;

noi = zeros(length(t),5);
nrangel = linspace(nrange(1),nrange(2),4);

noi(:,1) = zeros(length(t),1);
noi(:,2) = (nrangel(1)*A).*randn(length(t),1);
noi(:,3) = (nrangel(2)*A).*randn(length(t),1);
noi(:,4) = (nrangel(3)*A).*randn(length(t),1);
noi(:,5) = (nrangel(4)*A).*randn(length(t),1);

sig = zeros(length(t),5);
    sig(:,1) = A*sin(w*t+p0)+noi(:,1)';
    sig(:,2) = A*sin(w*t+p0)+noi(:,2)';
    sig(:,3) = A*sin(w*t+p0)+noi(:,3)';
    sig(:,4) = A*sin(w*t+p0)+noi(:,4)';
    sig(:,5) = A*sin(w*t+p0)+noi(:,5)';

sigh = zeros(length(t),5);
    sigh(:,1) = hilbert(sig(:,1));
    sigh(:,2) = hilbert(sig(:,2));
    sigh(:,3) = hilbert(sig(:,3));
    sigh(:,4) = hilbert(sig(:,4));
    sigh(:,5) = hilbert(sig(:,5));

phw = zeros(length(t),5);
    phw(:,1) = angle(sigh(:,1));
    phw(:,2) = angle(sigh(:,2));
    phw(:,3) = angle(sigh(:,3));
    phw(:,4) = angle(sigh(:,4));
    phw(:,5) = angle(sigh(:,5));
    
phu = zeros(length(t),5);
    phu(:,1) = unwrap(phw(:,1));
    phu(:,2) = unwrap(phw(:,2));
    phu(:,3) = unwrap(phw(:,3));
    phu(:,4) = unwrap(phw(:,4));
    phu(:,5) = unwrap(phw(:,5));
    
if plot_key == 1
    w = 0.6;
    h = 0.4;
    s = 0.04;

    l1 = 0.2;
    b1 = 0.09;
    b2 = b1+h+s;

    subplot('Position',[l1,b2,w,h])
    plot(t,sig(:,5),t,sig(:,4),t,sig(:,3),t,sig(:,2),t,sig(:,1))
    ylabel 'Amplitude'
    set(gca,'XTickLabel','')

    subplot('Position',[l1,b1,w,h])
    plot(t,pt,t,phu(:,5),t,phu(:,4),t,phu(:,3),t,phu(:,2),t,phu(:,1))
    xlabel 'Time(s)'
    ylabel 'Phase (rad)'
        legend('True','Noise = 0%',['Noise = ' num2str(nrangel(4)*100) '%'],['Noise = ' num2str(nrangel(3)*100) '%'],['Noise = ' num2str(nrangel(2)*100) '%'],['Noise = ' num2str(nrangel(1)*100) '%'],'Location','NorthWest')
end