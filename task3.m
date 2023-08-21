% Set constants and create target_start_pos, data from lab session
nr_targets = 1;
nr_sensors = 4;
target_start_pos = [position(1,2), position(1,3), position(1,1)];

% Square, setup 1
sensor_setup_1_pos = [2.0133, 2.7216, -1.9919, 2.6033, -2.1295, -2.4340, 1.8988, -2.6645];

% L-shaped, setup 2
sensor_setup_2_pos = [-2.5393, 0.2055, -2.6009, -0.9686, -1.3848, -3.2034, 0.0435, -3.2329];

% Calculate pe for setup 1 tdoa2
pe_1 = variance(1)*ones(3,3);
pe_1 = pe_1 + diag([variance(2), variance(3), variance(4)]);

% Calculate pe for setup 2 tdoa2
pe_2 = variance(5)*ones(3,3);
pe_2 = pe_2 + diag([variance(6), variance(7), variance(8)]);

% Create sensor network for setup 1, tdoa1
s_setup_1_tdoa1 = sensormod(h_tdoa1, [3, 0, 4, 8]);
s_setup_1_tdoa1.x0 = target_start_pos;
s_setup_1_tdoa1.th = sensor_setup_1_pos;
s_setup_1_tdoa1.pe = diag(variance(1:4));
R_setup_1_tdoa1 = diag(variance(1:4));
figure(31)
plot(s_setup_1_tdoa1)

% Create sensor network for setup 2, tdoa1
s_setup_2_tdoa1 = sensormod(h_tdoa1, [3, 0, 4, 8]);
s_setup_2_tdoa1.x0 = target_start_pos;
s_setup_2_tdoa1.th = sensor_setup_2_pos;
s_setup_2_tdoa1.pe = diag(variance(5:8));
R_setup_2_tdoa1 = diag(variance(5:8));
figure(32)
plot(s_setup_2_tdoa1)

% Create sensor network for setup 1, tdoa2
s_setup_1_tdoa2 = sensormod(h_tdoa2, [2, 0, 3, 8]);
s_setup_1_tdoa2.x0 = target_start_pos(1:2);
s_setup_1_tdoa2.th = sensor_setup_1_pos;
s_setup_1_tdoa2.pe = pe_1;

% Create sensor network for setup 2, tdoa2
s_setup_2_tdoa2 = sensormod(h_tdoa2, [2, 0, 3, 8]);
s_setup_2_tdoa2.x0 = target_start_pos(1:2);
s_setup_2_tdoa2.th = sensor_setup_2_pos;
s_setup_2_tdoa2.pe = pe_2;