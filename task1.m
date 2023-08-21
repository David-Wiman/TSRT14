% Allocate space
measurement_error = zeros(8,24);
mean_value = zeros(1,24);

% Turn tphat from time to distance
tphat_dist = tphat*343; % Speed of sound at sea level

% Calculate the mean across all sensors per measurement
for index = 1:length(tphat_dist)
    mean_value(index) = mean(tphat_dist(:,index));
end

% Calculate measurement error vectors, we assume the mean is the true time
% of arrival
for sensor = channels
        measurement_error(sensor,:) = tphat_dist(sensor,:) - mean_value;
end

% Calculate histogram, etc.
for index = channels
    if plot_on
        figure(index);
        histfit(measurement_error(index,:), 20);
    end    
    bias(index) = mean(measurement_error(index,:));
    variance(index) = var(measurement_error(index,:));
end