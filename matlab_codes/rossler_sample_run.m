%% generate rossler flow
% define parameters
n = 1000;
level = 1;
a = 0.2;
b = 0.4;
c = 5.7;
x0 = 0.1;
y0 = 0.2;
z0 = 0.1;
h = 0.1;
% run rossler
[x,y,z] = rossler(n,level,a,b,c,x0,y0,z0,h);
%% get power spectrum of first two flows
[p1,f] = pwelch(x,[],[],[],[]);
[p2,f] = pwelch(y,[],[],[],[]);
%% reconstruct phase space of rossler
% define parameters
dim = 2;
tau = 1;
% generate phase space
[Y,T] = phasespace(x,dim,tau);
[Y2,T2] = phasespace(y,dim,tau);
%% plot flows and phase space
w = 0.4;
h = 0.24;
s = 0.06;
l1 = 0.08;
l2 = l1+w+s;
b1 = 0.1;
b2 = b1+h+s;
b3 = b2+h+s;

subplot('Position',[l1,b3,w,h])
plot(x)
title('Rossler flow 1')
box off

subplot('Position',[l2,b3,w,h])
plot(y)
title('Rossler flow 2')
set(gca,'YTickLabel','')
box off

subplot('Position',[l1,b2,w,h])
semilogx(f,p1)
box off

subplot('Position',[l2,b2,w,h])
semilogx(f,p2)
set(gca,'YTickLabel','')
box off

subplot('Position',[l1,b1,w,h])
plot(Y(:,1),Y(:,2))
box off

subplot('Position',[l2,b1,w,h])
plot(Y2(:,1),Y2(:,2))
set(gca,'YTickLabel','')
box off
