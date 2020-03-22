function [img1] = myEdgeFilter(img0, sigma)
%Your implemention

hsize = 2 * ceil(3 * sigma) + 1;
h = fspecial('gaussian',hsize,sigma);
img = myImageFilter(img0, h);

% image gradients in the x direction and y direction
h_sobel_x = [1 0 -1; 2 0 -2; 1 0 -1];
h_sobel_y = [1 2 1; 0 0 0; -1 -2 -1];

imgx = myImageFilter(img, h_sobel_x);
imgy = myImageFilter(img, h_sobel_y);

img_sobel = sqrt(imgx.^2 + imgy.^2);
%img1 = abs(imgx) + abs(imgy);

angle = atan2(imgy,imgx)*180/pi;

[length, width] = size(img_sobel);
img1 = zeros(length, width);

%non-maximum suppression
for i = 2:length-1
    for j = 2:width-1
        if (angle(i,j)>=0 && angle(i,j)<=45) || (angle(i,j)< -135 && angle(i,j)>=-180)
            if (img_sobel(i,j) >= img_sobel(i,j+1)) && (img_sobel(i,j) >= img_sobel(i,j-1))
                img1(i,j) = img_sobel(i,j);
            else
                img1(i,j) = 0;
            end
        elseif(angle(i,j)>45 && angle(i,j)<=90) || (angle(i,j)<-90 && angle(i,j)>=-135)
            if (img_sobel(i,j) >= img_sobel(i+1,j+1)) && (img_sobel(i,j) >= img_sobel(i-1,j-1))
                img1(i,j) = img_sobel(i,j);
            else
                img1(i,j) = 0;
            end
        elseif (angle(i,j)>90 && angle(i,j)<=135) || (angle(i,j)<-45 && angle(i,j)>=-90)
            if (img_sobel(i,j) >= img_sobel(i+1,j)) && (img_sobel(i,j) >= img_sobel(i-1,j))
                img1(i,j) = img_sobel(i,j);
            else
                img1(i,j) = 0;
            end
        elseif (angle(i,j)>135 && angle(i,j)<=180) || (angle(i,j)<0 && angle(i,j)>=-45)
            if (img_sobel(i,j) >= img_sobel(i+1,j-1)) && (img_sobel(i,j) >= img_sobel(i-1,j+1))
                img1(i,j) = img_sobel(i,j);
            else
                img1(i,j) = 0;
            end
        end   
    end
end
end
    
                
        
        
