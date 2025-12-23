
N=1000; %Total Number of experiment= 10

%Each dice Outcomes
dice1= randi(6,1,N);
dice2= randi(6,1,N);
sum_values= dice1 + dice2;

sums= 2:12; %sum possibility 

% Limit of Sum Values 
edges = 1.5:1:12.5; % Upper limit=12.5, LowerLimit= 1.5, Interval = 1

%Absolute Frequency 
Abs_freq = histcounts(sum_values, edges); %histcounts calculates the number of frequency for each event

% Relative Frequency 
Rel_freq = Abs_freq/sum(Abs_freq); 

%Display Results 
disp('Absolute Frequency:');
disp(Abs_freq);
disp('Relative Frequency:');
disp(Rel_freq);


% Here the output values of Absolute and Relative Frequency can be found in
% terms of 0,1,2 etc. It is because the sum_values (2-12) might or might
% not come during the rolling dices combinely. 

% Plotting Relative and Absolute Frequencies

figure

%Plotting Absolute Frequencies 
subplot(2,1,1)    %subplot(rows, columns, position)
bar(2:12 ,Abs_freq)  %Explanation for this : X and Y values ( x-value 2 to 12 with corresponding y value = abs value) 
xlabel('Sum of Dice Rolls')
ylabel('Count')
title('Absolute Frequency for N=1000')
grid on;


%Plotting Relative Frequencies
subplot(2,1,2)
bar(2:12, Rel_freq)
xlabel('Sum of Dice Rolls')
ylabel('Relative Frequency')
title('Relative Frequency for N=1000')
grid on; 