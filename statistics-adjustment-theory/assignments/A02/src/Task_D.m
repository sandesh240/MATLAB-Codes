% ==============================================================
%   Statistics and Adjustment Theory
%   Authors: Om Prakash Bhandari & Sandesh Pokhrel
%   Date: 08.11.2025
% ==============================================================


%% Task 6: Compute angles r_i = atan2(y(i+1)-y(i), x(i+1)-x(i))

load ex02_data.mat   % loads x, y and sigma_x, sigma_y

n = length(x);       % should be 55
r = zeros(n-1,1);    % 54 angles

for i = 1:n-1
    dx = x(i+1) - x(i);
    dy = y(i+1) - y(i);
    r(i) = atan2(dy, dx);
end

disp('Angle values r(i):');
disp(r);


%% Task 7: Variance propagation for angles

n = length(x);

% Build diagonal covariance matrices
Sigma_x = diag(sigma_x.^2);
Sigma_y = diag(sigma_y.^2);

% Assemble full covariance matrix
Sigma_xy = blkdiag(Sigma_x, Sigma_y);    % (110 × 110)

% Jacobian for all angles
J = zeros(n-1, 2*n);                      % 54 × 110

for i = 1:n-1

    % Geometric differences
    X = x(i+1) - x(i);
    Y = y(i+1) - y(i);
    denom = (X^2 + Y^2);

    % Partial derivatives of atan2(Y,X)
    d_dX = -Y / denom;
    d_dY =  X / denom;

    % Chain rule to x_i, x_{i+1}, y_i, y_{i+1}
    d_dx_i     = -d_dX;
    d_dx_ip1   =  d_dX;
    d_dy_i     = -d_dY;
    d_dy_ip1   =  d_dY;

    % Fill Jacobian row
    J(i, i)       = d_dx_i;
    J(i, i+1)     = d_dx_ip1;
    J(i, n + i)   = d_dy_i;
    J(i, n + i+1) = d_dy_ip1;

end

% Covariance matrix of angles
Sigma_r = J * Sigma_xy * J';

% Standard deviations
std_r = sqrt(diag(Sigma_r));

disp('Standard deviations of angle values:');
disp(std_r);

[minStd, idxMin] = min(std_r);
[maxStd, idxMax] = max(std_r);

fprintf('Smallest std: %.6f at angle %d\n', minStd, idxMin);
fprintf('Largest  std: %.6f at angle %d\n', maxStd, idxMax);
