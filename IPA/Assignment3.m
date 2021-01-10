%Algorithm
% Loading the Data.
% Apply Gaussian Noise on the image.
% Pad the image.
% Convert the image into GreyScale.
% Apply the threshold.
% Apply Thin function.
%------ Template Image----------
% Apply the filter.
% Load the template image.
% Convert the template into Grey Scale Image.
% Apply the threshold to the Grey Scale Image.
% Apply Thin function
% Apply Convolution between Converted Original Image and Template Image.

% Adding the Path.
addpath('C:\VSG_IPA_toolbox');
% Clearing the data
clc; 
clear all;
% Loading the image.
image = imread('tie.jpg');
disp('Image Loaded sucessfully');
% Displaying the Input Image
dimension = figure;
imshow(image);
set(dimension,'Name','Input Image');
% Applying the Gaussian Noise

% image = imnoise(image,'gaussian',0,0.13);

% Padding the Image
imageMask = padarray(image, 100 , 0, 'both');
% Converting into GreyScale
Greyimage = rgb2gray(imageMask);


%Applying the Threshold.

Threshold_Image = vsg('Threshold', Greyimage,127);

disp('Mid Threshold appiled sucessfully');


% Applying Thin Function.
ThinImage = vsg('ThinImg',Threshold_Image,0);
disp('Full Thinning Sucessfully');
ThinImage = uint8(ThinImage);

%Apply Filter.
% ThinImageFilter = vsg('Median', ThinImage);
    

% Loading Template Image.
TemplateImage = imread('template_tie.jpg');
disp('Template Image loaded successfully');
dimension = figure;
imshow(TemplateImage);
set(dimension,'Name','Input Template Image');

% Converting template into Grey Scale.
TemplateImage = rgb2gray(TemplateImage);

% Applying the Threshold
TemplateImageThreshold = vsg('MidThresh',TemplateImage);

disp('Applied MidThreshold Successfully');


% Applying Thin Function.
ThinTemplateImage = vsg('ThinImg',TemplateImageThreshold,5);
disp('Full Thinning Sucessfully');

ThinTemplateImage = uint8(ThinTemplateImage);




%Applying the Convolution on the Input Image.
ImageConvolution = vsg('Convolution',ThinImage, ThinTemplateImage);
disp('Convolution Done');

% Displaying the Convoluted Image.
dimension = figure;
imshow(ImageConvolution);
set(dimension,'Name', 'Convoluted Image');




