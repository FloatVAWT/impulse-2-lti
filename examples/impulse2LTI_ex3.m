%--------------------------------------------------------------------------
% impulse2LTI_ex3.m
% Complex "step-like" kernel function
%--------------------------------------------------------------------------
% This kernel function was used in the following reference:
% C Lin, DR Herber, Vedant, YH Lee, A Ghosh, RH Ewoldt, JT Allison. 
% 'Attitude control system complexity reduction via tailored viscoelastic
% damping co-design.' In 2018 AAS Guidance & Control Conference, 
% Breckenridge, CO, Feb 2018.
%--------------------------------------------------------------------------
% Primary contributor: Daniel R. Herber (danielrherber), University of 
% Illinois at Urbana-Champaign
% Project link: https://github.com/danielrherber/impulse-2-lti
%--------------------------------------------------------------------------
close all; clear; clc

% impulse/kernel function
K = @(t) (tanh(-14*(t-0.5))+1)/2;

% options
opts.plotflag = 1; % create the plots
opts.saveflag = 0; % don't save, save the solution to disk
opts.name = 'impulse2LTI_ex3'; % name of the example
opts.path = mfoldername(mfilename('fullpath'),''); % path for saving
opts.displevel = 3; % very verbose, controls displaying diagnostics to the command window
opts.parallel = 1; % yes, parallel computing
opts.points.tf = 2; % length of the time horizon
opts.points.N = 2000; % number of testing points
opts.points.reduceflag = 0; % no, reduce the number of testing points based on MFX 52552
opts.points.normflag = 1; % yes, normalize the testing points
opts.fitting.method = 'multistart-lsqnonlin'; % fitting method
opts.fitting.N = 5; % number of basis functions, 2*N states
opts.fitting.T1min = -500; % minimum amplitude bound
opts.fitting.T1max = 500; % maximum amplitude bound
opts.fitting.T2min = 1e-4; % minimum decay rate bound
opts.fitting.T2max = 100; % maximum decay rate bound
opts.fitting.T3max = 300; % maximum frequency bound
opts.fitting.nStart = 10; % number of start points to test with multistart option
opts.modred = 1; % perform model reduction to reduce the number of states
opts.plot.simulation = 1; % yes, perform the additional simulations for validating the fit

% generate LTI (A,B,C) system matrices that best approximate provided K
[A,B,C,opts] = impulse2LTI(K,opts);