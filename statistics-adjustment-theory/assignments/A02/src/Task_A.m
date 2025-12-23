% ==============================================================
%   Statistics and Adjustment Theory
%   Authors: Om Prakash Bhandari & Sandesh Pokhrel
%   Date: 08.11.2025
% ==============================================================


% [A] Setting up a covariance matrix

n = 40;

% Standard deviations
sx = 1;
sy = 1;
sz = 3;

% Build index difference matrix
[idxI, idxJ] = ndgrid(1:n, 1:n);
D = abs(idxI - idxJ);

% Correlation structure
R = zeros(n);
R(D==0) = 1;                          % diagonal
R(D>0)  = 0.5 ./ D(D>0);              % off diagonal

% Covariance blocks
Cx = sx^2 * R;
Cy = sy^2 * R;
Cz = sz^2 * R;

% Final block diagonal covariance matrix
C = blkdiag(Cx, Cy, Cz);

% Visualize
imagesc(C);
colorbar;
axis equal tight;
title('Covariance Matrix');