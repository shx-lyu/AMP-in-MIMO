%   AMP detection in Massive MIMO
%   written by Shanxiang Lyu (shanxianglyu@gmail.com), was with Imperial College, now with Jinan University
%   Last updated on oct 2018
%   Ref: "Hybrid Vector Perturbation Precoding: The Blessing of Approximate Message Passing,", IEEE Transactions on Signal Processing 
%   Digital Object Identifier: 10.1109/TSP.2018.2877205

clc;clear all;close all;
linestyles = cellstr(char('-','--','-.','--'));
SetColors=lines(10);  
Markers=['o','x','+','*'];
legendbox={'MMSE','MMSE-AMPT', 'MMSE-AMPG'};
   
n=32;% # of users
m=64;% # of received antennas; m is much larger than n in massive mimo
SNR_range=[0:4:16]; % the tested range of SNR
count=0;
algorithms=[1:1:3];
for SNR=SNR_range
for monte=1:4e3 % the number of MonteCarlo simulations

    H=randn(m,n); %channel matrix
    A=7;% size of constellations
    u=1*randi([-A,A],n,1);% symbols in users 
    
    sigmas2=A*(A+1)/3;              % theoretical signal power;  
    sigma2=sigmas2/((10^(SNR/10))); % noise power
    y=H*u+sqrt(sigma2)*randn(m,1);  %the received signal
 
     for j=algorithms
          switch j
             case 1 %  MMSE
            xhat=round(pinv([H;sigma2/sigmas2*eye(n)])*[y;zeros(n,1)]);
            x_mmse=xhat;
             case 2 % MMSE-AMPT
            yp=y-H*x_mmse; %yp is the difference vector
            xhat=x_mmse+AMPT(yp,H,.5,.5); % AMP with ternery priors
             case 3  % MMSE-AMPG
            yp=y-H*x_mmse;
            xhat=x_mmse+AMPG(yp,H,sigmas2/20,.5);% AMP with Gaussian priors;the signal power is unknown
          end   
        uhat=max(min(xhat,A*ones(n,1)),-A*ones(n,1));%estimated symbols
        ser(j,monte)=sum(u~=uhat)/n; % symbol error rate    
     end
end
    count=count+1;
    SER(:,count)=mean(ser,2);
end
 
figure(1)
    for j=algorithms
semilogy(SNR_range,SER(j,:),[linestyles{j} Markers(j)],'Color',SetColors(j,:),'Linewidth',2);
        hold on;
        grid on;
    end
hold off;
h=legend(legendbox(algorithms)); 
xlabel('SNR/dB');ylabel('SER');

