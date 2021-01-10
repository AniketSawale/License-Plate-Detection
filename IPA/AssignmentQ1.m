%Setting the VSG path.
addpath('C:\\VSG_IPA_toolbox');

% Load the image.
image = imread('myface.jpg');
disp('Loaded Image sucessfully');

%Displaying the Image.
dimension = figure;
imshow(uint8(image));
set(dimension, 'Name', 'My Face');

% Adding Noise
NoiseImage = imnoise(image,'gaussian',0,0.05);

% Converting into GreyScale using rgb2gray function & converting into uint8.
GreyImage = rgb2gray(NoiseImage); 
disp('Converted RGB image into GreyScale successfully');
GreyImage = uint8(GreyImage);


% Applying the low Pass filter.
LowPassImage = vsg('LowPass',GreyImage);
disp('Appiled LowPass filter sucessfully');
LowPassImage = uint8(LowPassImage);


% % Finding Global Threshold at different value.
% j = 145;
% for i = 110:7:j
%     ThresholdImage = vsg('Threshold',LowPassImage,i);
%     dimension = figure;
%     imshow(uint8(ThresholdImage));
%     set(dimension,'Name', 'Global Threshold Image');
%     
% end

% % Finding 5x5 Adaptive Threshold to Grey Image.
% j = 10;
% for i = 0:1:j
%     AdaptiveThresholdImage = vsg('5x5Thresh', LowPassImage, i);
%     dimension = figure;
%     imshow(uint8(AdaptiveThresholdImage));
%     set(dimension,'Name', '5x5 Threshold Image');
%     
% end
%  
% % Applying the Global Threshold
ThresholdImage = vsg('Threshold',LowPassImage,138);
ThresholdImage = uint8(ThresholdImage);
disp('Appiled Global Threshold successfully');
%Displaying the Image with Global Threshold
dimension = figure;
imshow(uint8(ThresholdImage));
set(dimension,'Name', 'Global Threshold Image');

% Applying 5x5 Adaptive Threshold to Low Pass Grey Image.
 AdaptiveThresholdImage = vsg('5x5Thresh', LowPassImage, 5);
 
 disp('Appiled 5x5 Adaptive Threshold Sucessfully');
  AdaptiveThresholdImage = uint8(AdaptiveThresholdImage);
 % Displaying the Image with Adaptive Threshold.
 dimension = figure;
 imshow(uint8(AdaptiveThresholdImage));
 set(dimension,'Name', '5x5 Threshold Image');
 

     


