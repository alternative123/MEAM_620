% This script implement a vision-based 3-D velocity estimator and compare 
% against the ground truth provided by the vicon.

% Written by Qiong Wang for MEAM 620 at the University of Pennsylvania.
% April 16th, 2013

%% INITIALIZE.
% Clear up.
close all;

% Load data if there is no data.
run startup

% Length of real time points.
lengDat = length(sensorLog);

% Record the intial time point.
for i = 1:lengDat
    if ~isempty(sensorLog{i}.id)
        t0 = qdTimeLog{i};
        Xest_init = pos_est(sensorLog{i}, tagID, K1, BRC, tagPos);
        stFlg = i;
        break
    end    
end

for i = lengDat:-1:1
    if ~isempty(sensorLog{i}.id)
        tf = qdTimeLog{i};
        edFlg = i;
        break
    end
end
% EKF initialization
run EKF_init
%% REAL-TIME LOOP
% Initialize.
posEst = zeros(6,lengDat);
posEKF = zeros(6,lengDat);
t = zeros(1,lengDat);
vicon = zeros(6,lengDat);
t(1) = t0;

for i = 2: lengDat%lengDat
    if isempty(sensorLog{i}.id) || ~sensorLog{i}.isReady
        t(i) = t(i - 1);
        continue
    end
    %============================ POSE ESTIMATION =========================
    t(i) = qdTimeLog{i};
    posEst(:,i) = pos_est(sensorLog{i}, tagID, K1, BRC, tagPos);
    X = posEst(:, i);
    vel = qdLog{i}{1}.vel_body;
    omega = qdLog{i}{1}.omega;
    U = [vel; omega];
    dt = t(i) - t(i - 1);
    run EKF_loop;
    posEKF(:, i) = Xest;
    vicon(1:3,i) = qdLog{i}{1}.euler;
    vicon(4:6,i) = qdLog{i}{1}.pos;
end

%% PLOTS.
posLog = all(posEst,1);
plot_all(posEKF, posEst, vicon, t, posLog, t0, tf);