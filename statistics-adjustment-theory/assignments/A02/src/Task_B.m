% ==============================================================
%   Statistics and Adjustment Theory
%   Authors: Om Prakash Bhandari & Sandesh Pokhrel
%   Date: 08.11.2025
% ==============================================================

% Load data
load ex02_data.mat
n = length(x);

% Result storage
all_pairs = [];
m_vals = [];
b_vals = [];
sigma_m_vals = [];
sigma_b_vals = [];

% Loop over all point pairs
for i = 1:n-1
    for j = i+1:n
        
        xi = x(i); yi = y(i);
        xj = x(j); yj = y(j);

        %--------------------------------------------------------------
        % 1. Compute slope and intercept
        %--------------------------------------------------------------
        m = (yj - yi) / (xj - xi);
        b = yi - m*xi;

        %--------------------------------------------------------------
        % 2. Build covariance submatrix
        % Cov(z) = [C_ii  C_ij; C_ji  C_jj]
        % Each C_kk is 2x2
        % Global C is 2n x 2n arranged as (x1 y1 x2 y2 ...)
        %--------------------------------------------------------------
        idx_i = 2*i-1 : 2*i;
        idx_j = 2*j-1 : 2*j;

        Cii = C(idx_i, idx_i);
        Cjj = C(idx_j, idx_j);
        Cij = C(idx_i, idx_j);
        Cji = C(idx_j, idx_i);

        Sigma = [Cii, Cij; Cji, Cjj];   % 4x4

        %--------------------------------------------------------------
        % 3. Variance of m
        % m = (yj - yi) / (xj - xi)
        %--------------------------------------------------------------
        denom = (xj - xi)^2;

        dm_dxi = -(yj - yi) / denom;
        dm_dyi = -(xj - xi) / denom;
        dm_dxj = +(yj - yi) / denom;
        dm_dyj = +(xj - xi) / denom;

        grad_m = [dm_dxi; dm_dyi; dm_dxj; dm_dyj];

        sigma_m2 = grad_m' * Sigma * grad_m;
        sigma_m = sqrt(sigma_m2);

        %--------------------------------------------------------------
        % 4. Variance of b
        % b = yi - m*xi
        %--------------------------------------------------------------
        % Derivatives:
        % db/dxi = -m - xi * dm/dxi
        % db/dyi = 1  - xi * dm/dyi
        % db/dxj =     - xi * dm/dxj
        % db/dyj =     - xi * dm/dyj

        db_dxi = -m - xi * dm_dxi;
        db_dyi =  1 - xi * dm_dyi;
        db_dxj =    - xi * dm_dxj;
        db_dyj =    - xi * dm_dyj;

        grad_b = [db_dxi; db_dyi; db_dxj; db_dyj];

        sigma_b2 = grad_b' * Sigma * grad_b;
        sigma_b = sqrt(sigma_b2);

        %--------------------------------------------------------------
        % Store results
        %--------------------------------------------------------------
        all_pairs = [all_pairs; i, j];
        m_vals = [m_vals; m];
        b_vals = [b_vals; b];
        sigma_m_vals = [sigma_m_vals; sigma_m];
        sigma_b_vals = [sigma_b_vals; sigma_b];

    end
end

% Report extremes

[~, idx_min_m] = min(m_vals);
[~, idx_max_m] = max(m_vals);
[~, idx_min_b] = min(b_vals);
[~, idx_max_b] = max(b_vals);

[~, idx_min_sm] = min(sigma_m_vals);
[~, idx_max_sm] = max(sigma_m_vals);
[~, idx_min_sb] = min(sigma_b_vals);
[~, idx_max_sb] = max(sigma_b_vals);

fprintf('\n===== RESULTS =====\n');
fprintf('Minimum slope m: pair (%d,%d), m = %f\n', all_pairs(idx_min_m,:), m_vals(idx_min_m));
fprintf('Maximum slope m: pair (%d,%d), m = %f\n', all_pairs(idx_max_m,:), m_vals(idx_max_m));

fprintf('Minimum intercept b: pair (%d,%d), b = %f\n', all_pairs(idx_min_b,:), b_vals(idx_min_b));
fprintf('Maximum intercept b: pair (%d,%d), b = %f\n', all_pairs(idx_max_b,:), b_vals(idx_max_b));

fprintf('\nVariance propagation:\n');
fprintf('Minimum sigma_m: pair (%d,%d), σ_m = %g\n', all_pairs(idx_min_sm,:), sigma_m_vals(idx_min_sm));
fprintf('Maximum sigma_m: pair (%d,%d), σ_m = %g\n', all_pairs(idx_max_sm,:), sigma_m_vals(idx_max_sm));

fprintf('Minimum sigma_b: pair (%d,%d), σ_b = %g\n', all_pairs(idx_min_sb,:), sigma_b_vals(idx_min_sb));
fprintf('Maximum sigma_b: pair (%d,%d), σ_b = %g\n', all_pairs(idx_max_sb,:), sigma_b_vals(idx_max_sb));
