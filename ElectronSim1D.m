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
pauseTime = 0.2; % Pause time per simulation step for the graph (in second)
nSim = 1000; % Number of simulations
nParticles = 3; % Number of particle

% Electrons status
E = 1e-6; % electric field (V/m)
F = C.q_0*E; % force on the electron: F=qE
x = zeros(nParticles,nSim); % position matrix of the electron
v = zeros(nParticles,nSim); % velocity matrix of the electron
t = zeros(1,nSim); % Time array

% Loop for simulation
for indexSim = 1:nSim
    % Loop for particle
    for indexParticle = 1:nParticles
        % Plot position vs time
        subplot(2,1,1);
        plot(t(1, 1:indexSim), x(indexParticle, 1:indexSim)); 
        xlabel("t")
        ylabel("x")
        hold on
        % Plot velocity vs time
        subplot(2,1,2);
        plot(t(1, 1:indexSim), v(indexParticle, 1:indexSim));
        xlabel("t")
        ylabel("v")
        hold on

        % Increment time
        t(1, indexSim+1) = t(1, indexSim) + deltaTime;
        % Calculate the acceleration F=ma => a = F/m
        a = F/C.m_0;

        % Check for random
        if rand() <= 0.05
            v(indexParticle, indexSim+1) = -0.25*v(indexParticle, indexSim);
        else
            % Update the velocity
            v(indexParticle, indexSim+1) = v(indexParticle, indexSim) + a*deltaTime;
        end

        % Update the position
        x(indexParticle, indexSim+1) = x(indexParticle, indexSim) + v(indexParticle, indexSim)*deltaTime;
    end

    % Calculate the drift velocity
    sum_v = sum(v, "all"); % sum of all of the velocity so far
    driftV = sum_v/(indexSim * nParticles); % drift velocity = average velocity
    % Display the drift velocity as title
    title("Drift Velocity:"+driftV)
    
    % Pause for some time
    pause(pauseTime)
end


