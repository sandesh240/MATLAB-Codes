%% Task 3.2 -- Satellite footprint coordinates + ground track map
clear; clc;

%% Given orbital elements (deg)
i_deg    = 66.036006500;
Omega_deg= 335.188990200;     % RAAN
omega_deg= 289.450123600;     % argument of perigee

T_min = 110.0;
dt    = 1.0;

%% Constants
mu       = 3.986004418e14;      % [m^3/s^2]
omegaE   = 7.2921150e-5;        % [rad/s]

% TOPEX/Poseidon ellipsoid
a = 6378136.3;                  % [m]
f = 1/298.257;
b = a*(1-f);
e2 = f*(2-f);

%% Step 1: Period [s], mean motion n
T = T_min*60;                   % 6600 s
n = 2*pi/T;

%% Step 2: Orbital radius from Kepler (circular)
r = (mu*(T/(2*pi))^2)^(1/3);

fprintf('T = %.0f s\n', T);
fprintf('n = %.12e rad/s\n', n);
fprintf('r = %.3f m\n', r);

%% Time grid for one revolution
N = round(T/dt);                % 6600 samples
t = (0:N-1)'*dt;

%% Step 3: True anomaly (circular: nu = n*t, assume nu(t0)=0)
nu = n*t;

%% Rotation matrices
R1 = @(x)[1 0 0; 0 cos(x) -sin(x); 0 sin(x) cos(x)];
R3 = @(x)[cos(x) -sin(x) 0; sin(x) cos(x) 0; 0 0 1];

i     = deg2rad(i_deg);
Omega = deg2rad(Omega_deg);
omega = deg2rad(omega_deg);

Q = R3(Omega)*R1(i)*R3(omega);  % PQW -> ECI

%% Step 4: Position in PQW then ECI
rPQW = [r*cos(nu)'; r*sin(nu)'; zeros(1,N)];
rECI = Q*rPQW;  % 3xN

%% Step 5: ECI -> ECEF (simple Earth rotation, theta(t0)=0)
theta = omegaE*t';              % 1xN
rECEF = zeros(3,N);
for k=1:N
    rECEF(:,k) = R3(-theta(k))*rECI(:,k);
end

%% Step 6: Nadir footprint = intersection with ellipsoid along rECEF direction
x = rECEF(1,:); y = rECEF(2,:); z = rECEF(3,:);
den = (x.^2 + y.^2)/a^2 + (z.^2)/b^2;
s   = 1./sqrt(den);

xf = s.*x; yf = s.*y; zf = s.*z;

%% Step 7: Convert ECEF footprint to geodetic lat/lon (iterative)
lon = atan2(yf, xf);
p   = sqrt(xf.^2 + yf.^2);

lat = atan2(zf, p*(1-e2));  % initial guess

for it=1:10
    sinlat = sin(lat);
    Nphi   = a ./ sqrt(1 - e2*sinlat.^2);
    h      = p./cos(lat) - Nphi;
    latNew = atan2(zf, p .* (1 - (e2.*Nphi)./(Nphi + h)));
    if max(abs(latNew - lat)) < 1e-12
        lat = latNew;
        break;
    end
    lat = latNew;
end

lat_deg = rad2deg(lat);
lon_deg = rad2deg(lon);

% wrap lon to [-180,180]
lon_deg = mod(lon_deg + 180, 360) - 180;

%% Q1 output: range of lat/lon
fprintf('Latitude range  = [%.4f, %.4f] deg\n', min(lat_deg), max(lat_deg));
fprintf('Longitude range = [%.4f, %.4f] deg (wrapped)\n', min(lon_deg), max(lon_deg));

%% Save table for report
TBL = table(t, lon_deg', lat_deg', 'VariableNames', {'t_seconds','lon_deg','lat_deg'});
writetable(TBL, 'footprint_one_revolution.csv');

%% Q2 plot: global map with coastlines and axis labels
figure('Color','w'); hold on; grid on;
load coastlines;  % built-in dataset: coastlat, coastlon
plot(coastlon, coastlat, 'k', 'LineWidth', 0.5);
plot(lon_deg, lat_deg, '-', 'LineWidth', 1.0);

xlim([-180 180]); ylim([-90 90]);
xlabel('Longitude [deg]');
ylabel('Latitude [deg]');
title('Satellite ground track (one revolution)');


