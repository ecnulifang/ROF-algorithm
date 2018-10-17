% solve ROF using negative gradient descent method
function  ROF_demo
clear all;
close all;
exact = double(imread('cameraman.tif'));
u0 = exact+50*randn(size(exact));
u = u0;

figure
subplot(1,2,1)
imshow(u,[]);axis off
title('original')

dt=0.1;lambda=0.001;
subplot(1,2,2)
ep=1e-4;
tic
for iter=1:6000
    u_old = u;
    ux = Dx(u);
    uy = Dy(u);
    Du = sqrt(ux.^2+uy.^2+ep);
    div = -Dxt(ux./Du)-Dyt(uy./Du);
    u = u + dt.*(div-lambda*(u-u0));
    if mod(iter,10)==0
        imshow(u,[]);axis off;
        iterNum=[num2str(iter), ' iterations'];
        title(iterNum);
        figure(gcf)
    end
end




function d = Dx(u)
[rows,cols,p] = size(u); 
d = zeros(rows,cols,p);
d(:,2:cols,:) = u(:,2:cols,:)-u(:,1:cols-1,:);
d(:,1,:) = u(:,1,:)-u(:,cols,:);
return

function d = Dxt(u)
[rows,cols,p] = size(u); 
d = zeros(rows,cols,p);
d(:,1:cols-1,:) = u(:,1:cols-1,:)-u(:,2:cols,:);
d(:,cols,:) = u(:,cols,:)-u(:,1,:);
return

function d = Dy(u)
[rows,cols,p] = size(u); 
d = zeros(rows,cols,p);
d(2:rows,:,:) = u(2:rows,:,:)-u(1:rows-1,:,:);
d(1,:,:) = u(1,:,:)-u(rows,:,:);
return

function d = Dyt(u)
[rows,cols,p] = size(u); 
d = zeros(rows,cols,p);
d(1:rows-1,:) = u(1:rows-1,:)-u(2:rows,:);
d(rows,:) = u(rows,:)-u(1,:);
return