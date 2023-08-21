% Motion models
motion_model_1 = exmotion('cv2d'); % ca2d gives almost identical results
motion_model_2 = exmotion('ctcv2d');

% Measurement model
h_1 = inline('[x(1,:) ; x(2,:)]', 't', 'x', 'u', 'th');
measurement_model_1 = sensormod(h_1, [4, 0, 2, 0]);
measurement_model_1.pe = 0.1^2*eye(2); % low on this means we trust the measurement model
measurement_model_1.px0 = eye(4);
measurement_model_1.x0 = [x_hat_vector_tdoa2(:,1) ; 0 ; 0];

% Motion models with measurement models
motion_model_1_1 = addsensor(motion_model_1, measurement_model_1);
motion_model_2_1 = addsensor(motion_model_2, measurement_model_1);

% Tuning parameter
q_1 = 0.1^2*eye(2);
q_2 = 0.1^2*eye(3);

T = 0.5; % Since fs from exmotion is 2
G_1 = kron([T^2/2 ; T], eye(2)); % CV2D noise model
G_2 = G_1;
G_2(5,3) = T; % CTCV2D noise model

motion_model_1_1.pv = G_1*q_1*G_1';
motion_model_2_1.pv = G_2*q_2*G_2';

% Create a SIG object of the artificial measurements
y = sig(x_hat_vector_tdoa2');

% Kalman filter
x_hat_kalman_1 = ekf(motion_model_1_1, y);
x_hat_kalman_2 = ekf(motion_model_2_1, y);

% Plotting Kalman estimates
figure(61)
xplot2(x_hat_kalman_1, y.y, 'conf', 90)
figure(62)
xplot2(x_hat_kalman_2, y.y, 'conf', 90)