% Compute V across a grid of possible car positions, -3 to 3 by -2.5 to 2.5 meters

% Allocate space and create temporary sensormod objects
V_setup_1_tdoa1 = zeros(61, 51);
V_setup_2_tdoa1 = zeros(61, 51);
s_setup_1_tdoa1_tmp = s_setup_1_tdoa1;
s_setup_2_tdoa1_tmp = s_setup_2_tdoa1;

% V for setup 1
y = simulate(s_setup_1_tdoa1_tmp, 1);
for x_index = 1:61
    for y_index = 1:51
        s_setup_1_tdoa1_tmp.x0 = [(x_index/10)-3; (y_index/10)-2.5; position(1,1)];
        h = h_tdoa1(0, s_setup_1_tdoa1_tmp.x0, 0, s_setup_1_tdoa1_tmp.th);
        
        R = R_setup_1_tdoa1;   
        
        V_setup_1_tdoa1(x_index, y_index) = (y.y'-h)'*inv(R)*(y.y'-h);
    end
end

% V for setup 2
y = simulate(s_setup_2_tdoa1_tmp, 1);
for x_index = 1:61
    for y_index = 1:51
        s_setup_2_tdoa1_tmp.x0 = [(x_index/10)-3; (y_index/10)-2.5; position(1,1)];
        h = h_tdoa1(0, s_setup_2_tdoa1_tmp.x0, 0, s_setup_2_tdoa1_tmp.th);
        
        R = R_setup_2_tdoa1;
        
        V_setup_2_tdoa1(x_index, y_index) = (y.y'-h)'*inv(R)*(y.y'-h);
    end
end

% Plot the results
figure(41)
surf([-2.5:0.1:2.5]', [-3:0.1:3], V_setup_1_tdoa1);

figure(42)
surf([-2.5:0.1:2.5]', [-3:0.1:3], V_setup_2_tdoa1);
