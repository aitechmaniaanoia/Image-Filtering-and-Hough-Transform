clear;

datadir     = '../data';    %the directory containing the images
resultsdir  = '../results'; %the directory for dumping results

%parameters
sigma     = 1;
threshold = 0.5;
rhoRes    = 1;
thetaRes  = pi/180;
nLines    = 50;
%end of parameters

imglist = dir(sprintf('%s/*.jpg', datadir));

for i = 1:numel(imglist)
    
    %read in images%
    [path, imgname, dummy] = fileparts(imglist(i).name);
    img = imread(sprintf('%s/%s', datadir, imglist(i).name));
    
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
   
    %actual Hough line code function calls%  
    [Im] = myEdgeFilter(img, sigma);
    %imshow(Im);
    
    [H,rhoScale,thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes);
    %[H1,T,R] = hough(Im);
    
    %imshow(H/max(H(:)));
    %hold on;
    
    [rhos, thetas] = myHoughLines(H, nLines);
    P = houghpeaks(H,nLines);
    
    %plot(rhos, thetas, 's','color','white');
    
    %lines = houghlines(Im>threshold, 180*((thetaScale/thetaRes)/pi), rhoScale, [rhos,thetas],'FillGap',5,'MinLength',10);
    lines = houghlines(Im>threshold, 180*(thetaScale/pi), rhoScale, [rhos,thetas],'FillGap',5,'MinLength',10);
    %lines1 = houghlines(Im, T, R, P,'FillGap',5,'MinLength',10);
    
    %everything below here just saves the outputs to files%
    fname = sprintf('%s/%s_01edge.png', resultsdir, imgname);
    imwrite(sqrt(Im/max(Im(:))), fname);
    fname = sprintf('%s/%s_02threshold.png', resultsdir, imgname);
    imwrite(Im > threshold, fname);
    fname = sprintf('%s/%s_03hough.png', resultsdir, imgname);
    imwrite(H/max(H(:)), fname);
    fname = sprintf('%s/%s_04lines.png', resultsdir, imgname);
    
    img2 = img;
    for j=1:numel(lines)
       img2 = drawLine(img2, lines(j).point1, lines(j).point2); 
       imshow(img2);
    end
    
    imwrite(img2, fname);
    
end
    
