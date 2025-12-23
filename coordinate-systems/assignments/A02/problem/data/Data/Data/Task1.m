%% Coordinate Geometry Assignment 2%%
% Author- Sandesh Pokhrel %


% Task 1 - Coordinate Conversion %
 
%file_index 
files = ["S1", "S2", "S3", "S4", "S9", "S10"];

% function to load & convert point clouds in Spherical Coordinates
% into Cartesian Coordinates

for i = 1:length(files)
    name= files(i); 

   % Load input file%
   infile = "Data/"+ name + "_PointCloud.txt";
   data = load(infile);

d = data(:,1);
phi= data(:,2);
theta = data(:,3);

x= d .* cos(theta).* cos(phi);
y = d .* cos(theta) .* sin(phi);
z = d.* sin (theta);

%Storing the cartesian Coordinates% 
cartesian_coords = [x,y,z];

%  Save the cartesian coordinates % 
outfile = "Data/"+ name + "_CartesianCoords.txt";
   save(outfile, 'cartesian_coords', '-ascii');

end 



