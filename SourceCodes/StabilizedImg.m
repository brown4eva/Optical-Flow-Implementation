function [ NewImage ] = StabilizedImg( u,v,a,b )
% This code was done by Meldrick Reimmer 
% Guided by Prof. Yannick Benezeth

% Taking all values
[xm_new , ym_new] = meshgrid(1 : size(b,2) , 1 : size(b,1)); 
xm_new = xm_new + u;         
ym_new = ym_new + v;         
NewImage = zeros(size(b));  
xm_new = floor(xm_new);      
ym_new = floor(ym_new);      

for i = 1 : size(b,1)
    for j = 1 : size(b,2)       
        if xm_new(i,j) > 0 && ym_new(i,j) > 0 && xm_new(i,j) < size(b,2) && ym_new(i,j) < size(b,1)
            
            % New values assigned 
            NewImage(i,j) = a( ym_new(i,j) , xm_new(i,j)); 
            
        end
    end
end

end