% Allocate space
x_hat_vector_tdoa2 = zeros(2, length(tphat));
tphat_dist_diff = zeros(3, length(tphat));

% Convert tphat to distance instead of time
tphat_dist = tphat(1:4,:)*343;

% Construct pairwise differnces, sensor 1 is reference
for time_index = 1:length(tphat_dist)
    tphat_dist_diff(1,time_index) = tphat_dist(1,time_index) - tphat_dist(2,time_index);
    tphat_dist_diff(2,time_index) = tphat_dist(1,time_index) - tphat_dist(3,time_index);
    tphat_dist_diff(3,time_index) = tphat_dist(1,time_index) - tphat_dist(4,time_index);
end

% Create a SIG object of the measured time differences of arrival
y_diff = sig(tphat_dist_diff', 2);

for time_index = 1:length(tphat_dist)-1
    x_hat_tdoa2 = estimate(s_setup_1_tdoa2, y_diff(time_index,:), 'thmask', zeros(8,1)); % esitmate target position from sensor setup and measurements
    x_hat_vector_tdoa2(:,time_index) = x_hat_tdoa2.x0; % store measurements for ploting
    s_setup_1_tdoa2.x0 = x_hat_tdoa2.x0; % update the target position and pulse time
end

% Plot the target path together with sensor positions
figure(54)
plot(x_hat_vector_tdoa2(1,:), x_hat_vector_tdoa2(2,:))
hold on 
plot(s_setup_1_tdoa2)