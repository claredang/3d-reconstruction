function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).

%% ADD-ON
conv_1 = -inv(K1*R1) * (K1*t1);
conv_2 = -inv(K2*R2) * (K2*t2);

b = norm(conv_2 - conv_1);
f = K1(1,1);

depthM = zeros(size(dispM));

for x = 1: size(dispM,2)
    for y = 1: size(dispM,1)
        if dispM(y,x) == 0
            depthM(y,x) = 0;
        else          
            depthM(y,x) = (b*f)/dispM(y,x);
        end
    end
end