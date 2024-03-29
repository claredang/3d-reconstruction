%% ADD-ON

%% Display matrix
function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
    contro_matrix = ones(windowSize, windowSize);
    dispM = zeros(size(im1));
    for y = 1 : size(im1,1)
        for x = 1 : size(im1,2)
            length_ = zeros(1, maxDisp);
            for d = 1: maxDisp
                length_(d) = dist(im1, im2, y, x, d, windowSize);
            end
            [~, argmin] = min(length_);
            dispM(y,x) = argmin-1;
        end
    end
end

%% Dist
function dis = dist(im1, im2, y, x, d, windowSize)
    w = fix((windowSize-1) / 2);
    m = im1(max(y-w,1):min(y+w, size(im1,1)), max(x-w, 1):min(x+w, size(im1,2)));
    n = im2(max(y-w,1):min(y+w, size(im2,1)), max(x-w-d, 1):min(x+w-d,size(im2,2)));

    if size(m,2) > size(n,2)
        n = [zeros(size(m,1), size(m,2) - size(n,2)),n];
    elseif size(m,2) < size(n,2)
        m = [zeros(size(n,1), size(n,2) - size(m,2)),m];
    end

    if size(m,1) > size(n,1)
        n = [n; zeros(size(m,1), size(m,2) - size(n,2))];
        m = [m; zeros(size(n,1), size(n,2) - size(m,2))];
    end
    dis = sum((m-n).^2,'all');
end