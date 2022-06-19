clear all; close all;
%% Paramters
a=4; 
N=25; %length of H filter
M=600; %length of input signal
xn=2*a*(rand(1,M)-0.5); %input signal
hk=zeros(1,N); % initialize with zeros
b=[1 4 7]; % b coefficients (numerator)
a=[1 0.45 0.45 ]; % a coefficients (denominator)
dn=filter(b,a,xn); %creating the IIR filter
delta=0.00333333; %Convergence rate
%% Algorithm:
for n=N:M
    xn_k=xn(n:-1:n-N+1);
   
    y(n)=xn_k*hk';
    e(n)=dn(n)-y(n); %error vector
    hk=hk+delta*xn_k*e(n); % update the impulse response
end
%% Plotting:
figure(1)
impz(b,a)
hold on
impz(hk)
legend('IIR','FIR');
hold off
figure(2)
hold on;
plot(dn,'r');
plot(y,'g');
legend('dn','yn');
grid on
hold off;