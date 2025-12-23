% ---------------------------------------------
% Distance between altimeter footprint and tide gauge
% ---------------------------------------------

clc; clear;

fprintf('--- Ellipsoid parameters (Topex/Poseidon) ---\n');

% Ellipsoid parameters
a  = 6378136.3;                 % semi-major axis [m]
f  = 1/298.257000;
e2 = 2*f - f^2;

fprintf('a  = %.4f m\n', a);
fprintf('f  = %.12f\n', f);
fprintf('e^2 = %.12f\n\n', e2);

% ---------------------------------------------
% Satellite geodetic coordinates (from Q1)
% ---------------------------------------------
phi_s = deg2rad(43.520000025);  % latitude [rad]
lam_s = deg2rad(30.395000005);  % longitude [rad]

fprintf('--- Satellite geodetic coordinates ---\n');
fprintf('Latitude  φ_s = %.9f deg\n', rad2deg(phi_s));
fprintf('Longitude λ_s = %.9f deg\n\n', rad2deg(lam_s));

% ---------------------------------------------
% Altimeter footprint (h = 0)
% ---------------------------------------------
Nf = a / sqrt(1 - e2*sin(phi_s)^2);

Xf = Nf * cos(phi_s) * cos(lam_s);
Yf = Nf * cos(phi_s) * sin(lam_s);
Zf = Nf * (1 - e2) * sin(phi_s);

fprintf('--- Altimeter footprint (ECEF) ---\n');
fprintf('Prime vertical radius N_f = %.3f m\n', Nf);
fprintf('X_f = %.3f m\n', Xf);
fprintf('Y_f = %.3f m\n', Yf);
fprintf('Z_f = %.3f m\n\n', Zf);

% ---------------------------------------------
% Tide gauge coordinates
% ---------------------------------------------
phi_tg = deg2rad(43.592000088);
lam_tg = deg2rad(30.329000100);
h_tg   = 30.888;

Nt = a / sqrt(1 - e2*sin(phi_tg)^2);

Xt = (Nt + h_tg) * cos(phi_tg) * cos(lam_tg);
Yt = (Nt + h_tg) * cos(phi_tg) * sin(lam_tg);
Zt = (Nt*(1 - e2) + h_tg) * sin(phi_tg);

fprintf('--- Tide gauge coordinates (ECEF) ---\n');
fprintf('Latitude  φ_tg = %.9f deg\n', rad2deg(phi_tg));
fprintf('Longitude λ_tg = %.9f deg\n', rad2deg(lam_tg));
fprintf('Height h_tg    = %.3f m\n', h_tg);
fprintf('Prime vertical radius N_tg = %.3f m\n', Nt);
fprintf('X_tg = %.3f m\n', Xt);
fprintf('Y_tg = %.3f m\n', Yt);
fprintf('Z_tg = %.3f m\n\n', Zt);

% ---------------------------------------------
% Euclidean distance
% ---------------------------------------------
d = sqrt((Xf - Xt)^2 + (Yf - Yt)^2 + (Zf - Zt)^2);

fprintf('--- Distance computation ---\n');
fprintf('ΔX = %.3f m\n', Xf - Xt);
fprintf('ΔY = %.3f m\n', Yf - Yt);
fprintf('ΔZ = %.3f m\n', Zf - Zt);
fprintf('Distance footprint–tide gauge = %.3f m\n', d);
