clc;
clear;

img1 = imread('cameramen.tif');

img1 = double(img1);

figure;
imshow(uint8(img));
title("Original Grayscale Image");

h_avg = (1/9) * [ ...
    1 1 1;
    1 1 1;
    1 1 1 ];

h_sharp = [ ...
    0 -1 0;
    -1 5 -1;
    0 -1 0 ];

img_avg = conv2(img,h_avg,'same');
img_sharp = conv2(img,h_sharp,"same");

figure;

subplot(1,3,1);
imshow(uint8(img));
title('Original Image');

subplot(1,3,2);
imshow(uint8(img_avg));
title('Averaged (Blurred) Image');

subplot(1,3,3);
imshow(uint8(img_sharp));
title('Sharpened Image');