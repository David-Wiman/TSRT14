% Allocate space and create temporary sensormod objects
x_hat_vector_tdoa1 = zeros(2, length(tphat));
s_setup_1_tdoa1_tmp = s_setup_1_tdoa1;

% Convert tphat to distance instead of time
tphat_dist = tphat*343;

% Create a SIG object of the measured time of arrivals
y = sig(tphat_dist(1:4,:)', 2);

% Set the target start position and a probable first r0 (earliest TOA for the first pulse)
s_setup_1_tdoa1_tmp.x0 = [position(1,2) ; position(1,3) ; min(tphat_dist(1:4,1))];

for time_index = 1:length(tphat_dist)-1
    x_hat_tdoa1 = estimate(s_setup_1_tdoa1_tmp, y(time_index,:), 'thmask', zeros(8,1)); % esitmate target position from sensor setup and measurements
    x_hat_vector_tdoa1(:,time_index) = x_hat_tdoa1.x0(1:2); % store measurements for ploting
    s_setup_1_tdoa1_tmp.x0 = [x_hat_tdoa1.x0(1:2) ;  min(tphat_dist(1:4,time_index+1))]; % update the target position and pulse time
end

% We think we need to update the target position and pulse time since
% "esitmate" will performe a Gauss-Newton search in a small box around x0.
% If the true position is outside of this search-box, the best guess will
% be somewhere along the edge of the box where the loss functions is
% minimized. Moving the search-box along with
% each estimated position ensures we are sufficiently close, both in
% position and time, to the next position that it will be within the
% search-box.

% Plot the target path together with sensor positions
figure(52)
plot(x_hat_vector_tdoa1(1,:), x_hat_vector_tdoa1(2,:))
hold on 
plot(s_setup_1_tdoa1)