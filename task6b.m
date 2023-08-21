% Measurement model
measurement_model_2 = s_setup_1_tdoa2;

% Motion models with measurement models
motion_model_1_2 = addsensor(motion_model_1, measurement_model_2);
motion_model_2_2 = addsensor(motion_model_2, measurement_model_2);

motion_model_2_2.x0 = [0 ; 0 ; 0 ; 0 ; 0];

% Kalman filter
x_hat_kalman_1_tdoa2 = ekf(motion_model_1_2, y_diff);
x_hat_kalman_2_tdoa2 = ekf(motion_model_2_2, y_diff);

% Plotting Kalman filter estimates
figure(63)
xplot2(x_hat_kalman_1_tdoa2, y_diff.y, 'conf', 90)
figure(64)
xplot2(x_hat_kalman_2_tdoa2, y_diff.y, 'conf', 90)