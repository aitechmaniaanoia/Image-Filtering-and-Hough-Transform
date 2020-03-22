function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
[length, width] = size(Im);

% threshold the edge magnitude image
Im(Im >= threshold) = 1;
Im(Im < threshold) = 0;

M = int16(sqrt(length^2 + width^2));

thetaScale = 0:thetaRes:2*pi;
rhoScale = 0:rhoRes:M;

thetaScale = thetaScale(1:end-1);
rhoScale = rhoScale(1:end-1);
rhoScale = double(rhoScale);

H = zeros(max(size(thetaScale)), max(size(rhoScale)));

for i = 1:length
    for j = 1:width
        if Im(i,j) == 1
            rho = i*sin(thetaScale) + j*cos(thetaScale);
            %rho = int16(rho/rhoRes);
            
            rho = rho/rhoRes;
            
            idx = sub2ind(size(H), int16((thetaScale(int16(rho)>0))/thetaRes)+1, int16(rho(int16(rho)>0)));
            H(idx) = H(idx) + 1;
            %H(int16((thetaScale(rho>0))/thetaRes)+1, rho(rho>0)) = H(int16((thetaScale(rho>0))/thetaRes)+1, rho(rho>0)) + 1;
            %H(int16((thetaScale(rho>0))/thetaRes)+1, rho(rho>0)) = 1;           
            %imshow(H);
        end
        
    end
end

end
        
        