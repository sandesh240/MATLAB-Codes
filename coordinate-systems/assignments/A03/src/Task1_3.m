% -------------------------------------------------
% Question 3: Geocentric vs Geodetic Latitude
% -------------------------------------------------

clc; clear;

% -------------------------
% Given Cartesian coordinates
% -------------------------
x = 4831342.4634;   % m
y = 2833965.0779;   % m
z = 5289590.6351;   % m

% -------------------------
% Geocentric latitude
% -------------------------
p = sqrt(x^2 + y^2);
psi = atan(z / p);                 % radians
psi_deg = rad2deg(psi);            % degrees

% -------------------------
% Geodetic latitude (from Task 1.1)
% -------------------------
phi_deg = 43.520000025;             % degrees
phi = deg2rad(phi_deg);             % radians

% -------------------------
% Difference in latitude
% -------------------------
diff_deg = phi_deg - psi_deg;       % degrees
diff_rad = deg2rad(diff_deg);       % radians

% -------------------------
% Error in meters
% -------------------------
R = 6378137;                        % Earth radius [m]
delta_S = R * diff_rad;

% -------------------------
% Display results
% -------------------------
fprintf('Geocentric latitude ψ  = %.9f deg\n', psi_deg);
fprintf('Geodetic latitude  φ  = %.9f deg\n', phi_deg);
fprintf('Difference (φ − ψ)    = %.9f deg\n', diff_deg);
fprintf('Linear error ΔS       = %.2f m\n', delta_S);
