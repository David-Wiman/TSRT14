clear
clc

plot_on = 0;
run('startup');

% Change for your folder
run('C:\Users\David Wiman\OneDrive\Dokument\MATLAB\TSRT14\initSigSys.m')

%% Calibration

filename = 'calibration';
run('SFlabRun');
run('task1');

%% Live run

filename = 'grupp7';
run('SFlabRun');
run('task2');
run('task3');
run('task4');
run('task5b');
run('task5d');
run('task6a');
run('task6b');
run('task7');