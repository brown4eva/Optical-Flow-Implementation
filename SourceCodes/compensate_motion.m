function warped = compensate_motion(img,  u, v)

[x,y] = meshgrid(1:size(img,2), 1:size(img,1));

warped = interp2(double(img), x-u, y-v, 'linear',0);