function camera_motion = stabilize(img,  u, v)
% This code was done by Meldrick Reimmer 
% Guided by Prof. Yannick Benezeth
 % To stabilize set of images

[xm_new , ym_new] = meshgrid(1 : size(img,2) , 1 : size(img,1)); % Taking all values
xm_new = xm_new + u;         % new value of x
ym_new = ym_new + v;         % new value of y
camera_motion = zeros(size(img));  
xm_new = floor(xm_new);      
ym_new = floor(ym_new);      

for i = 1 : size(img,1)
    for j = 1 : size(img,2)       
        if xm_new(i,j) > 0 && ym_new(i,j) > 0 && xm_new(i,j) < size(img,2) && ym_new(i,j) < size(img,1)
            camera_motion(i,j) = img( ym_new(i,j) , xm_new(i,j)); 
            
        end
    end
end
end

