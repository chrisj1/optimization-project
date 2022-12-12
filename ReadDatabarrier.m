%function ReadData
close all
I1 = double(imread('barbara_contaminated.png'));
I2 = double(imread('cameraman_contaminated.png'));
figure;
imshow(I1,[]);
% figure;
% imshow(I2,[]);

I = I1;

load Omega  %%%%% I1(Omega), I2(Omega) are not contaminated 


%%% Soft Thresholding needs to apply on coef(:,:,2:end)
%%%%%  Inverse wavelet transformation W^T*u


gridSize = 1;

mus = linspace(0.01, 0.01, gridSize);
alpha = 0.001;

% parpool(6);
% D = parallel.pool.DataQueue;

for ii = 1:numel(mus)
    runtesthyperbarrier(I, mus(ii), alpha, Omega, "barbara", 10000);
end



