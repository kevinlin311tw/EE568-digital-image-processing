%% DIP homework6 UW EE Kevin Lin
%% Line detection via Hough transform

function kevin_hw6
    close all;
    clear;
    figure;
    rgb_img = imread('lane.jpg');
    img = rgb2gray(rgb_img);
    %imshow(img);
    edge = Edge(img);
    %figure;
    %imshow(uint8(edge));
end


function result = Edge(I)
    my_gauss_filter = gauss2d(3,0.9,0);
    result = conv2(double(I),double(my_gauss_filter));
    imshow(uint8(result));
    my_lapacian_filter = [1 1 1; 1 -8 1; 1 1 1];
    result = conv2(double(result),double(my_lapacian_filter)); 
    result = (result>70);
    result = result*255;
    imshow(result);
end


function kernel = gauss2d(n,std,theta)
    r=[cos(theta) -sin(theta);
   sin(theta)  cos(theta)];
    for i = 1:n
        for j = 1:n
            u = r*[j-(n+1)/2 i-(n+1)/2]';
            kernel(i,j) = gauss(u(1),std)*gauss(u(2),std);
        end
    end
    kernel = kernel / sqrt(sum(sum(kernel.*kernel)));
end

function y = gauss(x,std)
    y = exp(-x^2/(2*std^2)) / (std*sqrt(2*pi));
end
