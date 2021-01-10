%Algorithm.
% Read Image.
% Apply Noise.
%Convert into Grey Scale.
% Take the Complement of Grey Scale.
% Apply Filters
% Apply Erosion
% Apply Llyod Segmentation
% Extract Biggest Blob.
% Subtract the Image.
% Remove Smallest Blob.
% Count the Blob.

%Add path
addpath('C:\VSG_IPA_toolbox');
%Clear environment
clc;
clear all;

% Reading Image
%image = imread('number_plate_1.jpg');
%image = imread('number_plate_2.jpg');
%image = imread('number_plate_3.jpg');
%image = imread('number_plate_4.jpg');
%image = imread('number_plate_5.jpg');
image = imread('number_plate_6.jpg');
disp('Image read sucessfully');

dimension = figure;
imshow(image);
set(dimension,'Name','Given Input Image');
%Adding Noise
imageNoise = imnoise(image,'gaussian',0,0.2);

%Converting into Grey Scale Image.
GreyImage = rgb2gray(imageNoise);
disp('Converted into  GreyScale Sucessfully');

% Applying NOT on the Grey Scale Image.
GreyImage_Not = vsg('NOT',GreyImage);
GreyImage_Not = uint8(GreyImage_Not);
disp('Converted GreyScale Image to its Complement');
% Applying the Filter
j = 2;
for i = 1:j
%     GreyImage_Not = vsg('Midpoint',GreyImage_Not);
    GreyImage_Not = vsg('LowPass',GreyImage_Not);
end


% Applying Erosion.
j = 2;
for i = 1:j
    GreyImage_Not = vsg('Erosion',GreyImage_Not,9);
end
GreyImage_Not = uint8(GreyImage_Not);
% Applying Llyod Alogrithm for segmenatation.
ErosionClose_Llyod = vsg('LloydSeg',GreyImage_Not);
ErosionClose_Llyod = uint8(ErosionClose_Llyod);



% Removing Big Blob from the image.
ErosionClose_LlyodErosionBB = vsg('BiggestBlob',ErosionClose_Llyod);
ErosionClose_LlyodErosionBB = uint8(ErosionClose_LlyodErosionBB);
% 
% Subtracting Big Blob
LlyodErosionBB = vsg('Subtract',ErosionClose_Llyod,ErosionClose_LlyodErosionBB);
LlyodErosionBB = uint8(LlyodErosionBB);

% Removing Smallest Blob from the image.
j = 2;
for i = 1:j
    LlyodErosionSmallest_Blob = vsg('SmallestBlob',LlyodErosionBB);
    LlyodErosionSmallest_Blob = uint8(LlyodErosionSmallest_Blob);
    LlyodErosionBB = vsg('Subtract',LlyodErosionBB, LlyodErosionSmallest_Blob);

    
end
LlyodErosionBB = uint8(LlyodErosionBB);
dimension = figure;
imshow(uint8(LlyodErosionBB));
set(dimension,'Name','Erosion');
% Counting the Blob on the image.
CountBlob = vsg('CountBlobs',LlyodErosionBB);
Display = ['Count of AplhaNumeric on the licence Plate: ', num2str(CountBlob)];
disp(Display);
title(Display);



