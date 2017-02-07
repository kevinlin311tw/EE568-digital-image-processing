% DIP homework1 UW EE Kevin Lin
function hw1
clear;
close all;
problem2;
problem3;
problem4;
end

function problem2
% 2(a)
figure
img = imread('1_4.bmp');
imshow(img);
% 2(b)
min_value = min(img(:));
max_value = max(img(:));
% 2(c)
d_im = double(img);
imshow(d_im);
% 2(d)
d_im_show = im2double(img);
imshow(d_im_show);
end

function problem3
figure
[X,map]=imread('1_2.tif','tif');
I = ind2gray(X,map);
imshow(I);
rotated_I = imrotate(I, -45);
imshow(rotated_I);
end

function problem4
figure
X=load('1_3.asc');
Y1 = X;
Y2 = X;
[rows, cols] = size(X);

% (a) sampling pixel
Y1 = X(1:4:rows, 1:4:cols);
imshow(Y1/256);
imwrite(uint8(Y1),'reduced.jpg');

% (a) average the region
A = X(1:4:rows, 1:4:cols);
B = X(2:4:rows-1, 1:4:cols);
C = X(1:4:rows, 2:4:cols-1);
D = X(2:4:rows-1, 2:4:cols-1);
Y2 = (A+B+C+D)/4;
imshow(Y2/256);
imwrite(uint8(Y2),'reduced-avg.jpg');


% 4(b) repeating pixel
result = zeros(rows*4,cols*4);
for i = 1:4
    for j = 1:4
        result(i:4:rows*4, j:4:cols*4) = X;
    end
end
imshow(result/256);
imwrite(uint8(result),'enlarge.jpg');
% 4(b) bilinear

X=load('1_3.asc');
[rows, cols] = size(X);
result = zeros(rows*4,cols*4);
result(1:4:rows*4, 1:4:cols*4) = X;
for i = 1:rows
    for j = 1:cols-1
        p1 = X(i,j);
        p2 = X(i,j+1);
        d13 = 5 - 1;
        for k = 1:3
            d12 = k;
            d23 = 4 - k;
            result((i-1)*4+1,(j-1)*4+1+k) = d23/d13*p1 + d12/d13*p2;
        end
    end
end
temp = result;

for j = 1:cols*4
    for i = 1:4:(rows-1)*4
        p1 = result(i,j);
        p2 = result(i+4,j);
        d13 = 5 - 1;
        for k = 1:3
            d12 = k;
            d23 = 4 - k;
            result(i+k,j) = d23/d13*p1 + d12/d13*p2;
        end    
    end
end
for i = 0:2
    result(end-i,:) = result(end-4,:);
end
for i = 0:2
    result(:,end-i) = result(:,end-4);
end
imshow(result/256);
imwrite(uint8(result),'enlarge-bilinear.jpg');
end
