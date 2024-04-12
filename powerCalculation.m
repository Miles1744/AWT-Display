%% Script Info
% Michael Zelnick - 3/19/2024
% Imports torque data from csv files, plot, and calculates power
%% Setup MATLAB (Clean Slate)
clear
clc
close all

%% Input RAW data from files

Two_Wind_Data = readmatrix('Torque_2_Wind_by_Angle.csv');
Four_Wind_Data = readmatrix('Torque_4_Wind_by_Angle.csv');
Six_Wind_Data = readmatrix('Torque_6_Wind_by_Angle.csv');
Eigth_Wind_Data = readmatrix('Torque_8_Wind_by_Angle.csv');
Ten_Wind_Data = readmatrix('Torque_10_Wind_by_Angle.csv');

%% Prepare data for plotting torques vs wind incident angles

Angles = Two_Wind_Data(:,1);
Torques = [Two_Wind_Data(:,2) Four_Wind_Data(:,2) Six_Wind_Data(:,2) Eigth_Wind_Data(:,2) Ten_Wind_Data(:,2)];

%% Plot Torque (y) vs Wind Incident Angle (x)
% Plot a separate curve for each dataset on the same chart

figure(1)
% 
plot(Angles, Torques, ':o')
xlabel('Angle [deg]')
ylabel('Torque [N*m]')
title('Torque vs Wind Incident Angle')
% hold on
% plot(, , ':or')
% plot(, , ':og')
% plot(, , ':om')
% plot(, , ':ok')
% hold off

%% Average Torque for each wind speed

Avg_Torques = mean(Torques);

%% Calculate Power for each Wind Speed

% P = lambda * U * Tau / r  where:
%
%   lambda = tip-speed ratio (assume that of a Savonius rotor performing 
%            at peak efficiency
%   U = wind speed (m/s)
%   Tau = torque (N*m)
%   r = rotor diameter (m)

% Input values

lambda = 0.9; % Assuming peak efficiency for a Savonius-like rotor
U = 2:2:10; % Vector with all wind speeds
Tau = Avg_Torques;
r = 0.3 / 2;

P = lambda .* U .* Tau ./ r;

%% Plot Power (W) vs Wind Speed (m/s)

figure(2)
plot(U, P, 'o')
xlabel('U [m/s]')
ylabel('Power [W]')
title('Power vs Wind Speed')

%% Add a best fitting curve to the Power vs Wind Speed plot
% To run this code, install first the Curve Fitting add-on

bestfit = fit(U', P', 'power1');
hold on
plot (bestfit)
xlabel('U [m/s]')
ylabel('Power [W]')
hold off

%% Export Calculations to File


data = struct(P); % Example MATLAB data
jsonData = jsonencode(data);
fid = fopen('data.json', 'w');
fprintf(fid, '%s', jsonData);
fclose(fid);

