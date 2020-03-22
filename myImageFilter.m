function [img1] = myImageFilter(img0, h)
[kernel_size, kernel_size1] = size(h);
padding_size = double(int16((kernel_size-1)/2));
%padding image
img = padarray(img0, [padding_size padding_size], 0,'both');

[length, width] = size(img);
img1 = zeros(size(img));

%find index of middle pixel in kernel
mid = (kernel_size + 1)/2;

for i = 1:kernel_size
    for j = 1:kernel_size
        conv_img = h(i,j)*img;
        if i > mid
            %move top i-mid row to bottom
            size_add = size(conv_img(1:(i-mid),:));
            conv_img(1:(i-mid),:) = [];
            conv_img = [conv_img; zeros(size_add)];
        elseif i < mid
            %move bottom mid-i row to top
            size_add = size(conv_img((length-mid+i+1):length,:));
            conv_img((length-mid+i+1):length,:) = [];
            conv_img = [zeros(size_add); conv_img];
        end
        
        if j > mid
            % move left j-mid cloumn to right
            size_add = size(conv_img(:,1:(j-mid)));
            conv_img(:,1:(j-mid)) = [];
            conv_img = [conv_img zeros(size_add)];
        elseif j < mid
            % remove right mid-j cloumn
            size_add = size(conv_img(:,(width-mid+j+1):width));
            conv_img(:,(width-mid+j+1):width) = [];
            conv_img = [zeros(size_add) conv_img];
        end
        
        % sum conv_img
        img1 = img1 + conv_img;
    end
end
%img1 = img1/kernel_size^2;

%remove padding
img1 = img1((padding_size+1):(length-padding_size), (padding_size+1):(width-padding_size));

%A = zeros(size(h));
%for j = 1:length
%    for k = 1:width
%        % 3*3 kernel filter (kernel_size = 1)
%        A = [img(padding_size+j-1, padding_size+k-1) img(padding_size+j-1, padding_size+k) img(padding_size+j-1, padding_size+k+1);
%             img(padding_size+j, padding_size+k-1)   img(padding_size+j, padding_size+k)   img(padding_size+j, padding_size+k+1);
%             img(padding_size+j+1, padding_size+k-1) img(padding_size+j+1, padding_size+k) img(padding_size+j+1, padding_size+k+1)]
%         
%        img1(j,k) = sum(dot(A,h));
%    end
%end

end