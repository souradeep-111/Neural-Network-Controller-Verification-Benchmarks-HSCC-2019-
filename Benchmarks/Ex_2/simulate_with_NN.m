Ts = 0.2;  % Sample Time
N = 3;    % Prediction horizon
Duration = 10; % Simulation horizon

global simulation_result;

for m=1:1000

    
x0 = 0.7 + 0.2*rand(1);
y0 = 0.4 + 0.2*rand(1);

x = [x0;y0;];

simulation_result = x;


% Things specfic to the model  ends here

options = optimoptions('fmincon','Algorithm','sqp','Display','none');
uopt = zeros(N,1);

u_max = 0;


x_now = zeros(2,1);
x_next = zeros(2,1);
z = zeros(3,1);

x_now = x;

% Start simulation

for ct = 1:(Duration/Ts)
    
    x_now(1) = x_now(1);

    x_now(2) = x_now(2) ;

%      u = NN_output(x_now, 4, 1,'neural_network_controller');
       u = NN_output(x_now, 4, 1,'modified_controller');

     z(1) = x_now(1) ;
     z(2) = x_now(2) ;
     z(3) = u ;
     
%      u = u + 0.9 ;
      
%     x_next = system_eq_NN(x_now, Ts, u);
    x_next = system_eq_dis(x_now, Ts, u);

    x = x_next;
    x_now = x_next;


end
plot(simulation_result(1,:),simulation_result(2,:), 'color', 'r');
xlabel('x');
ylabel('y');
hold on;

    
    
end


