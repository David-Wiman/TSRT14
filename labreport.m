%% TSRT14, Lab 2: Orientation
%
% *Group members:*
%
% # Eric Moringe (000228-5435), erimo668
% # David Wiman (000120-8495), davwi279
%

if inpublish  % Load saved data when publishing.
  load DATAFILE
end


%% 1. Connect the phone with your lab computer
% *No need to document this step.*

%% 2. Get to know your data
% We saw a left-oriented coordinate system and quite noisy signals,
% especially the magnetic field. 

if ~inpublish  % Don't recollect data during publish
  [xhat2, meas2] = ekfFilter();
  save DATAFILE -append xhat2 meas2
end

% Accelerometer
mean_acc = mean(meas2.acc(:, ~any(isnan(meas2.acc), 1)), 2);
var_acc = diag( var(meas2.acc(:, ~any(isnan(meas2.acc), 1))')' );
calAcc.m = mean_acc;
calAcc.R = var_acc;

figure(21)
sgtitle('Accelerometer')
subplot(3,1,1)
histfit(meas2.acc(1, ~any(isnan(meas2.acc), 1)))
subplot(3,1,2)
histfit(meas2.acc(2, ~any(isnan(meas2.acc), 1)))
subplot(3,1,3)
histfit(meas2.acc(3, ~any(isnan(meas2.acc), 1)))
figure(24)
plot(meas2.t, meas2.acc)
title('Accelerometer')
legend('x-axis','y-axis','z-axis')

% Gyroscope
mean_gyr = mean(meas2.gyr(:, ~any(isnan(meas2.gyr), 1)), 2);
var_gyr = diag( var(meas2.gyr(:, ~any(isnan(meas2.gyr), 1))')' );
calGyr.m = mean_gyr;
calGyr.R = var_gyr;

figure(22)
sgtitle('Gyroscope')
subplot(3,1,1)
histfit(meas2.gyr(1, ~any(isnan(meas2.gyr), 1)))
subplot(3,1,2)
histfit(meas2.gyr(2, ~any(isnan(meas2.gyr), 1)))
subplot(3,1,3)
histfit(meas2.gyr(3, ~any(isnan(meas2.gyr), 1)))
figure(25)
plot(meas2.t, meas2.gyr)
title('Gyroscope')
legend('x-axis','y-axis','z-axis')

% Magnetometer
mean_mag = mean(meas2.mag(:, ~any(isnan(meas2.mag), 1)), 2);
var_mag = diag( var(meas2.mag(:, ~any(isnan(meas2.mag), 1))')' );
calMag.m = mean_mag;
calMag.R = var_mag;

figure(23)
sgtitle('Magnetometer')
subplot(3,1,1)
histfit(meas2.mag(1, ~any(isnan(meas2.mag), 1)))
subplot(3,1,2)
histfit(meas2.mag(2, ~any(isnan(meas2.mag), 1)))
subplot(3,1,3)
histfit(meas2.mag(3, ~any(isnan(meas2.mag), 1)))
figure(25)
plot(meas2.t, meas2.mag)
title('Magnetometer')
legend('x-axis','y-axis','z-axis')

%% 3. Add the EKF time update step

%
% <include>tu_qw.m</include>
%

% We picked no parameters of our own. All the formulas were from the
% course book. 

if ~inpublish  % Don't recollect data during publish
  [xhat3, meas3] = ekfFilter();
  save DATAFILE -append xhat3 meas3
end

figure(31)
visDiff(xhat3, meas3);

% The phone can now detect relative motion to its starting point. It has no
% idea of what is flat on the table since it cannot yet detect a magnetic
% field or the acceleration towards the earth's centre. 

%% 4. Add the EKF accelerometer measurement update step

%
% <include>mu_g.m</include>
%

% The paramter we picked was g0 and we chose [0, 0, 9.81]' as earths
% gravity works in the positive z-direction.

if ~inpublish  % Don't recollect data during publish
  [xhat4, meas4] = ekfFilter();
  save DATAFILE -append xhat4 meas4
end

figure(41)
visDiff(xhat4, meas4);

% The algorithm can tell which way is down by looking at what component has
% an acceleration of 9.81.
% If we shake the phone, we get high acceleration in the horizontal plane
% and the phone belives that the down direction is to the side, and alternating

%% 5. Add accelerometer outlier rejection

% We check if the norm of the acceleration measurement deviates too much
% from 9.81. More precisely, we check whether norm(acc) lies between 9.6
% and 10. When an outlier is detected, we don't update the measurement and
% light up the graphical indicator. 

% if norm(acc) < 10 && norm(acc) > 9.6
%     % OK
% else
%     % outlier detected
% end

if ~inpublish  % Don't recollect data during publish
  [xhat5, meas5] = ekfFilter();
  save DATAFILE -append xhat5 meas5
end

figure(51)
visDiff(xhat5, meas5);

% Since we can't get rid of the natural acceleration downwards, if we shake
% the phone the total acceleration becomes too great and the phone stops
% updating. This way, we ensure that in all instances we do update the
% measurement, we can tell which way is down since that direction has
% the only large acceleration value.

%% 6. Add the EKF magnetometer measurement update step

%
% <include>mu_m.m</include>
%

% The paramter we picked was m0 and we chose
% 1e-6*[0, sqrt(  calMag.m(1)^2 +  calMag.m(2)^2 ),  calMag.m(3)]'
% This was remomended in the lab-pm and ensures we have no magnetic field
% in the x-direction.

if ~inpublish  % Don't recollect data during publish
  [xhat6, meas6] = ekfFilter();
  save DATAFILE -append xhat6 meas6
end

figure(61)
visDiff(xhat6, meas6);

% The phone now knows what way is north and can orient itself absolutely.
% When a magnetic disturbance is introduced, the phone's understanding of
% north is skewed and it loses the absolut orientation.

%% 7. Add magnetometer outlier rejection

% We check if the norm of the magnetic field measurement deviates too much
% from normal values. More precisely, we check whether norm(mag) lies
% between 40 and 60 micro Tesla. When an outlier is detected, we don't
% update the measurement and light up the graphical indicator. 

% if norm(mag) < 60 && norm(mag) > 40
%     % OK
% else
%     % outlier detected
% end

if ~inpublish  % Don't recollect data during publish
  [xhat7, meas7] = ekfFilter();
  save DATAFILE -append xhat7 meas7
end

figure(71)
visDiff(xhat7, meas7);

% The phone detects a too strong magnetic field and stops updating. This
% way, we ensure that the phone only bases its understaning of north on the
% earths magnetic field and nothing else. 

%% 8. Test your filter without gyroscope measurements

if ~inpublish  % Don't recollect data during publish
  [xhat8, meas8] = ekfFilter();
  save DATAFILE -append xhat8 meas8
end

figure(81)
visDiff(xhat8, meas8);

% Very poor performance, e

%% APPENDIX: Main loop

%
% <include>ekfFilter.m</include>
%