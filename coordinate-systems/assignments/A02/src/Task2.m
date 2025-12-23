%% Coordinate Geometry Assignment 2%%
% Author- Sandesh Pokhrel %


% Task 2 - Rodrigues Formula %

%--Loading the Cartesian  Datasets point clouds obtained from Task 1 --%

S1= load("Data/S1_CartesianCoords.txt");
S2= load("Data/S2_CartesianCoords.txt");
S3= load("Data/S3_CartesianCoords.txt");
S4= load("Data/S4_CartesianCoords.txt");
S9= load("Data/S9_CartesianCoords.txt");
S10= load("Data/S10_CartesianCoords.txt");

% The process of transformation goes Like : %

%S9 cloud  --transform (rotation & translation ) -->S1 frame%
%S1 cloud  --transform-->  S2 frame%
%S2 cloud  --transform-->  S3 frame%
%S3 cloud  --transform-->  S4 frame%


% Rodrigues Rotation Function (Axis-Angle → Rotation Matrix)

rodrigues = @(axis, angle_deg) ...
    (cosd(angle_deg)*eye(3)) + ...
    (1-cosd(angle_deg))*(axis(:)*axis(:)') + ...
    (sind(angle_deg)) * [ ...
        0        -axis(3)  axis(2);
        axis(3)   0        -axis(1);
        -axis(2)  axis(1)   0      ];


% Transformation Parameters %

% S9 → S10
t_9_10 = [6.937, -20.959, -5.135];
axis_9_10 = [0.6860, -0.2068, -0.6976]; axis_9_10 = axis_9_10/norm(axis_9_10);
R_9_10 = rodrigues(axis_9_10, 1.692);

% S10 → S1
t_10_1 = [13.355, 37.179, 4.224];
axis_10_1 = [-0.0290, -0.0024, 0.9996]; axis_10_1 = axis_10_1/norm(axis_10_1);
R_10_1 = rodrigues(axis_10_1, 43.537);

% S1 → S2
t_1_2 = [20.672, 33.373, 0.119];
axis_1_2 = [0.0005, 0.0001, -1.0000]; axis_1_2 = axis_1_2/norm(axis_1_2);
R_1_2 = rodrigues(axis_1_2, 79.015);

% S2 → S3
t_2_3 = [-12.077, 23.572, 0.247];
axis_2_3 = [0.0228, -0.0020, 0.9997]; axis_2_3 = axis_2_3/norm(axis_2_3);
R_2_3 = rodrigues(axis_2_3, 36.099);

% S3 → S4
t_3_4 = [-3.715, -33.172, 0.109];
axis_3_4 = [-0.0062, -0.0089, 0.9999]; axis_3_4 = axis_3_4/norm(axis_3_4);
R_3_4 = rodrigues(axis_3_4, 93.143);



% Performing registration in the correct sequence
%         S9 → S10 → S1 → S2 → S3 → S4 %

cloud_point = S9; 

% Transform S9 to S10
cloud_point = (R_9_10 * cloud_point' + t_9_10')';
% Transform S10 to S1
cloud_point = (R_10_1 * cloud_point' + t_10_1')';
% Transform S1 to S2
cloud_point = (R_1_2 * cloud_point' + t_1_2')';
% Transform S2 to S3
cloud_point = (R_2_3 * cloud_point' + t_2_3')';
% Transform S3 to S4
cloud_point = (R_3_4 * cloud_point' + t_3_4')';


% Saving the updated coordinates in S4 frame % 
save( "Data/Registered_S4_frame","cloud_point", "-ascii" );
fprintf("The task has been Completed, file has been saved successfully");

