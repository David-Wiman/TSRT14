% Motion models
motion_model_7 = exmotion('cv2d');

% Measurement model
measurement_model_7 = s_setup_1_tdoa2;
amp = 0.5;
measurement_model_7.th = measurement_model_7.th + amp*randn(8,1); % At 0.7 the estimation fail

% Motion models with measurement models
motion_model_7 = addsensor(motion_model_7, measurement_model_7);

% Particle filter
x_hat_7 = ekf(motion_model_7, y_diff);

% Plotting particle filter estimates
figure(71)
xplot2(x_hat_7, y_diff.y, 'conf', 90)

% Plotting true and disturbed sensor position
figure(72)
plot(s_setup_1_tdoa2)
hold on
plot(motion_model_7.th(1), motion_model_7.th(2), 'd')
plot(motion_model_7.th(3), motion_model_7.th(4), 'd')
plot(motion_model_7.th(5), motion_model_7.th(6), 'd')
plot(motion_model_7.th(7), motion_model_7.th(8), 'd')

