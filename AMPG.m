function xhat=AMPG(y,H,sigmas2,sigma2)
%   AMP algorithm with Gaussian prior 
%   written by Shanxiang Lyu (shanxianglyu@gmail.com), was with Imperial College, now with Jinan University
%   Last updated on oct 2018
%   Ref: "Hybrid Vector Perturbation Precoding: The Blessing of Approximate Message Passing,", IEEE Transactions on Signal Processing 
%   Digital Object Identifier: 10.1109/TSP.2018.2877205

% sigmas2: signal power
% sigma2: noise power
    [m,n]=size(H);
    if nargin <= 2
        sigmas2=2;
        sigma2=(norm(y)^2)/(m^1.5); 
    elseif nargin <= 3
        sigma2=(norm(y)^2)/(m^1.5); 
    end

r=y;%residual vector
x_hat=zeros(n,1);
l_hat=1*ones(n,1);
alpha=1e4;
alphabar=1e4;
Theta=diag(1./(diag(H'*H)));
 
for t=1:20
    r=y-H*x_hat+(n/m)*alphabar/alpha*r; 
    alpha=sigma2+(n/m)*alphabar; 
    x_in=Theta*H.'*r+x_hat;
    u=x_in;
    v=Theta*alpha*ones(n,1);
    for i=1:n
        v(i)=min(25,max(v(i),1e-4));%bound the variance for stability
        x_hat(i)=u(i)*sigmas2/(sigmas2+v(i));
        l_hat(i)=v(i)*sigmas2/(sigmas2+v(i));
    end
    alphabar=mean(Theta^(-1)*l_hat);

    x_hat_all(1:n,t)=round(x_hat);%integer estimation
    FIT(t)=norm(y-H*x_hat_all(1:n,t));
    if FIT(t)>=1e5
        break;
    end
end


ind=find(FIT==min(FIT));% find the smallest fitness
if isempty(ind)==1
     xhat=zeros(n,1);
else
    xhat=x_hat_all(1:n,ind(end));
    if norm(y)<=FIT(ind(end))
        xhat=zeros(n,1);
    end
end
