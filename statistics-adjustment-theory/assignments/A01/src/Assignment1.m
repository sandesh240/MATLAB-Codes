% Task 2: Plotting Frequencies (Using randi)

% Use  of randi function to realize the N=10. 
dice1= randi(6,1,10);
dice2 = randi(6,1,10);
sum_values = dice1 + dice2;

% Plot the frequency of the sum values
histogram(sum_values, 'Normalization', 'probability');
xlabel('Sum of Dice Rolls');
ylabel('Probability');
title('Frequency Distribution of Dice Rolls');

%Absolute and Relative Frequency  
limit= 1.5:5:12.5;
% Calculate absolute and relative frequencies
absoluteFreq = histcounts(sum_values, limit);
relativeFreq = absoluteFreq / sum(absoluteFreq);
% Display the absolute and relative frequencies in the command window
disp('Absolute Frequencies:');
disp(absoluteFreq);
title("Absolute Frequency for N=10");

disp('Relative Frequencies:');
disp(relativeFreq);
title("Relative Frequency for N=10");