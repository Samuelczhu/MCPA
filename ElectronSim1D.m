% Clear all
clear all
clearvars
clearvars -GLOBAL
close all

% Make plot easier
set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth', 2);

% Declare some constant
C.q_0 = 1.60217653e-19;             % electron charge
C.m_0 = 9.10938215e-31;             % electron mass

% Simulation status
deltaTime = 1e-5; % Change in time per simulation step (in second)
pauseTime = 0.5; % Pause time per simulation step for the graph (in second)
nSim = 1000; % Number of simulations

% Electrons status
E = 0.1; % electric field (V/m)
F = C.q_0*E; % force on the electron: F=qE
x = zeros(1,nSim); % position array of the electron
v = zeros(1,nSim); % velocity array of the electron
driftV = zeros(1,nSim); % array for the drift velocity
t = zeros(1,nSim); % Time array

% Loop for simulation
for index = 1:nSim
    % Plot position vs time
    subplot(2,1,1);
    plot(t(1:index), x(1:index)); 
    xlabel("t")
    ylabel("x")
    % Plot velocity vs time
    subplot(2,1,2);
    plot(t(1:index), v(1:index));
    xlabel("t")
    ylabel("v")
    % Plot drift velocity vs time
    plot(t(1:index), driftV(1:index), "-bo");
    hold on

    % Increment time
    t(index+1) = t(index) + deltaTime;
    % Calculate the acceleration F=ma => a = F/m
    a = F/C.m_0;

    % Check for random
    if rand() <= 0.05
        v(index+1) = -0.25*v(index);
    else
        % Update the velocity
        v(index+1) = v(index) + a*deltaTime;
    end

    % Update the position
    x(index+1) = x(index) + v(index)*deltaTime;

    % Calculate the drift velocity
    sum_v = 0; % Hold the sum of the velocity so far
    for d = 1:index
        sum_v = sum_v + v(d);
    end
    driftV(index+1) = sum_v/index; % drift velocity = average velocity
    
    % Pause for some time
    pause(pauseTime)
end


