function pts3d = triangulate(P1, p1, P2, p2)
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

%% ADD-ON

% Build fundamental matrix
pts3d = [zeros(size(p1)), zeros(size(p1,1),2)];
for i = 1: size(p1,1)
    x = p1(i,1);
    y = p1(i,2);
    x_temp = p2(i,1);
    y_temp = p2(i,2);
    matrix_trans = [y.*P1(3,:) - P1(2,:); P1(1,:) - x.*P1(3,:); y_temp.*P2(3,:) - P2(2,:); P2(1,:) - x_temp.*P2(3,:)];
    [u,s,v] = svd(matrix_trans);
    matrix_X = v(:,end).';
    pts3d(i,:) = matrix_X/matrix_X(4);
end
