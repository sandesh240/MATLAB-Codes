% ==============================================================
%   Statistics and Adjustment Theory
%   Authors: Om Prakash Bhandari & Sandesh Pokhrel
%   Date: 08.11.2025
% ==============================================================

%% Q4 ---------------------------------------------------------

load ex02_data.mat

n = length(x);
d = zeros(n-1,1);

for i = 1:n-1
    dx = x(i) - x(i+1);
    dy = y(i) - y(i+1);
    d(i) = sqrt(dx^2 + dy^2);
end

% requested distances
pairs = [1 2; 11 12; 21 22; 31 32];

for k = 1:size(pairs,1)
    i = pairs(k,1);
    j = pairs(k,2);
    fprintf("Distance pair %d,%d = %.6f\n",i,j,d(i));
end



%% Q5 ---------------------------------------------------------

load ex02_data.mat;

Ncov = size(Cx,1);       % = 40
Sigma_xy = blkdiag(Cx, Cy);   % 80x80

Sigma_d = zeros(Ncov-1); % 39x39 covariance matrix

for i = 1:Ncov-1
    % build Ji (1x80)
    Ji = zeros(1, 2*Ncov);

    Di = sqrt((x(i)-x(i+1))^2 + (y(i)-y(i+1))^2);

    Ji(i)     = (x(i) - x(i+1)) / Di;
    Ji(i+1)   = (x(i+1) - x(i)) / Di;

    Ji(Ncov + i)   = (y(i) - y(i+1)) / Di;
    Ji(Ncov + i+1) = (y(i+1) - y(i)) / Di;

    for j = 1:Ncov-1

        % build Jj (1x80)
        Jj = zeros(1, 2*Ncov);

        Dj = sqrt((x(j)-x(j+1))^2 + (y(j)-y(j+1))^2);

        Jj(j)     = (x(j) - x(j+1)) / Dj;
        Jj(j+1)   = (x(j+1) - x(j)) / Dj;

        Jj(Ncov + j)   = (y(j) - y(j+1)) / Dj;
        Jj(Ncov + j+1) = (y(j+1) - y(j)) / Dj;

        % compute covariance
        Sigma_d(i,j) = Ji * Sigma_xy * Jj';
    end
end

figure;
imagesc(Sigma_d);
colorbar;
title('Covariance Matrix of Distances');

std_d = sqrt(diag(Sigma_d));
[min_std, i_min] = min(std_d);
[max_std, i_max] = max(std_d);

fprintf("Smallest std: %.6f at distance %d\n", min_std, i_min);
fprintf("Largest  std: %.6f at distance %d\n", max_std, i_max);

