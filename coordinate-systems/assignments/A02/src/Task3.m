%% Coordinate Geometry Assignment 2%%
% Author- Sandesh Pokhrel %


% Task 3 - WGS84 %

data = load("Data/Registered_S4_frame.txt");

%Global Transformation Parameters % 

% Translation (X0, Y0, Z0)
T = [4014686.692, 499058.356, 4914517.523];

% Rotation axis 
axis_global = [-0.3488, 0.1186, -0.9297];
axis_global = axis_global / norm(axis_global);

% Rotation angle
angle_global = 131.509;   % degrees


% Rodrigues Formula % 
rodrigues = @(u, ang) ...
    (cosd(ang)*eye(3)) + ...
    (1-cosd(ang))*(u(:)*u(:)') + ...
    (sind(ang))*[ 0       -u(3)   u(2);
                  u(3)     0     -u(1);
                 -u(2)    u(1)    0    ];

%computing rotation matrix%
R = rodrigues(axis_global, angle_global);

%Applying Global rotation + translation % 
transf = (R * data')' + T;

% Saving ECEF Output % 
save('ECEF_WGS_Output.txt', "transf", "-ascii")

% Conversion of ECEF coordinates into Latitude, Longitude and height % 

% Extracting ECEF coordinates %
X = transf(:, 1);
Y = transf(:, 2);
Z = transf(:, 3);

wgs84= wgs84Ellipsoid("meters");


% Conversion
[lat, lon, h] = ecef2geodetic(wgs84, X, Y, Z);
WGS_84 = [lat, lon, h];

% Saving the coordinates % 
save('WGS84_Coordinates.txt', "WGS_84");

%Showing Centroid %
lat_centroid = mean(lat);
lon_centroid = mean(lon);

fprintf ("The approximate location of the Building is :")
fprintf('Latitude: %.6f, Longitude: %.6f\n', lat_centroid, lon_centroid);
