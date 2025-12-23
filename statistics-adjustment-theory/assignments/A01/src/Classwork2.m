
f= @(x) (x .*(x>0 & x<=1) + ((2-x).*(x>1 & x<2)));
x_values= -0.5:1.5:2.5;
y_values= f(x_values);
figure;
plot(x_values, y_values, 'b-', 'LineWidth',3);

