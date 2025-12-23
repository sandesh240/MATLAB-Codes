% Cartesian to Ellipsoidal Coordinates
% Topex/Poseidon Ellipsoid

clc; clear;

% -------------------------
% Given Cartesian coordinates
% -------------------------
x = 4831342.4634;   % m
y = 2833965.0779;   % m
z = 5289590.6351;   % m

% -------------------------
% Ellipsoid parameters
% -------------------------
a = 6378136.3;
f = 1 / 298.257000;
b = a * (1 - f);
e2 = 1 - (b^2 / a^2);

% -------------------------
% Longitude
% -------------------------
lambda = atan2(y, x);
lambda_deg = rad2deg(lambda);

% -------------------------
% Auxiliary quantity
% -------------------------
p = sqrt(x^2 + y^2);

% -------------------------
% Initial values
% -------------------------
phi = atan(z / (p * (1 - e2)));
h = 0;

% -------------------------
% Print header
% -------------------------
fprintf('\nIter | Longitude (deg) | Latitude (deg) | Height (m)\n');
fprintf('------------------------------------------------------\n');

% -------------------------
% Fixed 5 iterations
% -------------------------
for k = 1:5
    
    % Radius of curvature
    N = a / sqrt(1 - e2 * sin(phi)^2);
    
    % Height update
    h = p / cos(phi) - N;
    
    % Latitude update
    phi = atan( z / ( p * (1 - (e2 * N) / (N + h)) ) );
    
    % Print iteration result
    fprintf('%4d | %15.9f | %14.9f | %10.3f\n', ...
        k, lambda_deg, rad2deg(phi), h);
end

% -------------------------
% Final result after 5 iterations
% -------------------------
fprintf('\n============= FINAL RESULT (k = 5) =============\n');
fprintf('Longitude  = %.9f deg\n', lambda_deg);
fprintf('Latitude   = %.9f deg\n', rad2deg(phi));
fprintf('Height     = %.3f m\n', h);
