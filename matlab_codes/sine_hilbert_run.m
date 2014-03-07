%% Hilbert as a phase detector
% define a sine wave and plot the wave plus its unwrapped phase
% add successively large amounts of noise and see how well the phase is
% detected
%% sine wave parameters
w = 0.1*2*pi;
w2 = 0.02*2*pi;
fs = 1;
p0 = 0;
A = 1;
d = 100;
nrange = [0.05; 0.4];
plot_key = 1;
%% plot wave and phase
[sig,sigh,phw,phu,t,pt] = sinewave_hilbert_phase(w,fs,d,p0,A,nrange,plot_key);
    % output is a sine wave and its phase, with noise at 




