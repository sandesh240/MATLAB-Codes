% Task 3.1.2
% Height difference using Topex/Poseidon and GRS80 ellipsoids


clc; clear;

% -------------------------------------------------
% Given Cartesian coordinates of the satellite
% -------------------------------------------------
x = 4831342.4634;   % m
y = 2833965.0779;   % m
z = 5289590.6351;   % m

p = sqrt(x^2 + y^2);

% -------------------------------------------------
% Ellipsoid parameters
% -------------------------------------------------
% Topex/Poseidon
a_TP = 6378136.3;
f_TP = 1/298.257;

% GRS80
a_GRS = 6378137.0;
f_GRS = 1/298.257222101;

% -------------------------------------------------
% Run iterations for both ellipsoids
% -------------------------------------------------
fprintf('\n=========== TOPEX / POSEIDON ELLIPSOID ===========\n');
[h_TP, phi_TP] = iterate_height(a_TP, f_TP, x, y, z);

fprintf('\n================== GRS80 ELLIPSOID =================\n');
[h_GRS, phi_GRS] = iterate_height(a_GRS, f_GRS, x, y, z);

% -------------------------------------------------
% Final comparison
% -------------------------------------------------
fprintf('\n================ FINAL COMPARISON ==================\n');
fprintf('Final height (T/P)    = %.3f m\n', h_TP);
fprintf('Final height (GRS80)  = %.3f m\n', h_GRS);
fprintf('Height difference    = %.3f m\n', h_GRS - h_TP);

% -------------------------------------------------
% Function performing iterations and printing results
% -------------------------------------------------
function [h_final, phi_final] = iterate_height(a, f, x, y, z)

    e2 = 2*f - f^2;
    p  = sqrt(x^2 + y^2);

    % Initial latitude
    phi = atan( z / (p*(1 - e2)) );

    fprintf('Iter | Latitude (deg) | Height (m)\n');
    fprintf('----------------------------------\n');

    for k = 1:5
        N = a / sqrt(1 - e2*sin(phi)^2);
        h = p/cos(phi) - N;
        phi = atan( z / ( p*(1 - (e2*N)/(N + h)) ) );

        fprintf('%4d | %14.9f | %10.3f\n', k, rad2deg(phi), h);
    end

    h_final  = h;
    phi_final = phi;
end
