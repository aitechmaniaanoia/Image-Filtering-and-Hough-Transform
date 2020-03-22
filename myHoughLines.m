function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here
%[thetaScale, rhoScale] = size(H);
thetas = [];
rhos = [];
%count = nLines;
%max_peak = max(H(:));

while nLines > 0
    %for i = 1:thetaScale
        %for j = 1:rhoScale
    % find peak
    [max_val, idx] = max(H(:));
    [i,j] = ind2sub(size(H),idx);
            %if H(i,j) == max_peak
    % save theta and rho 
    thetas = [thetas; i];
    rhos = [rhos; j];

    % move neighbor value
    H = padarray(H, [1 1], 0,'both'); % padding 0 avid error when remove neighbors
    H(i:i+2,j:j+2) = 0; % index changed after padding
    H = H(2: end-1, 2:end-1); % remove padding 

    H(i,j) = 0;
            %max_val = max(H(:));
            %end
        %end
    %end
    nLines = nLines - 1;
end

%if length(rhos) > count
%    rhos = rhos(1:count);
%    thetas = thetas(1:count);
%end

end
        