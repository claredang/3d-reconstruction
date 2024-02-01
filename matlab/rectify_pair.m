function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m


%% ADD-ON
conv1 = -inv(K1*R1) * (K1*t1);
conv2 = -inv(K2*R2) * (K2*t2);
rand_1 = abs(conv1 - conv2)/ norm(conv1 - conv2);
rand_2 = cross(R1(3, :), rand_1);

% Normalize
rand_2 = rand_2 / norm(rand_2);
rand_3 = cross(rand_1, rand_2);
rand_3 = rand_3 / norm(rand_3);
R_h = [rand_1.'; rand_2; rand_3];
R1n = R_h;
rand_2 = cross(R2(3, :), rand_1);
rand_3 = cross(rand_1, rand_2);
R_h = [rand_1.'; rand_2; rand_3];
R2n = R_h;
K1n = K2;
K2n = K2;
t1n = -R1n * conv1;
t2n = -R2n * conv2;
M1 = (K1n * R1n)*inv(K1*R1);
M2 = (K2n * R2n)*inv(K2*R2);
% R2n = R_h;