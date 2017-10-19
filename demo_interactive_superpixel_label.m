%% Script: Interactive Superpixel Labeling
%
% This folder contains an example in MATLAB for plotting the boundaries of
% superpixels in a pre-segmented image and then interactively manually
% labeling each superpixel labels.
% 
% # interative superpixel labeling
% 
% Matlab implementation of interative superpixel labeling
% 
% *************************************************************** Script:
% "demo_interactive_superpixel_label.m" - the main demo script
% 
% Data: "image_rgb.mat" - a Image structure variable, where Image.RGB is
% the RGB of the image (size N1xN2x3) that the user is labeling. In this
% example, the RGB image is from MATLAB's pre-packaged demo image
% peppers.png "Seg_peppers.mat" - a pre-segmentaion of the peppers image.
% The variable "Seg" (size N1xN2) contains segmentation label values for
% each pixel in the image, the pixels with the same value belong to the
% same segment, or "superpixel". Note the values in Seg starts from 0 to
% (NumSegments - 1). *This pre-segmentation is done by SLIC algorithm
% (http://ivrl.epfl.ch/research/superpixels).
% 
% *************************************************************** The
% purpose of this demo script is to illustrate plotting an RGB image file
% with its segmented superpixels and then interactively label each
% superpixel. A possible application for this example could be
% crowdsourcing manual labels from many users for supervised or
% semi-supervised learning.
%
% The example first loads the RGB data and draws a bounary for each
% superpixel segmentation of the whole image. Then, for the total number of
% superpixels (or the number of superpixels the user is desiring to label),
% an interactive labeling interface was built and the manual labeling is
% stored in the variable "SuperpixelLabel_dataset". Note that the manual
% label only works for number. One may change what each label number
% represents at will.
% 
% In addition, a feature that can highlight a particular segment using
% transparent alpha colors was implemented and demonstrated in the code.
% 
% ***********************************************************************
% 
% 
%  Authors: Xiaoxiao Du University of Missouri, Department of Electrical
%  and Computer Engineering Email Address: xdy74@mail.missouri.edu Latest
%  Revision: February 2017
% 
% This code uses Matlab Image Processing Toolbox.

%% Preset
%%%%%% 1. Need to load your image as "Image.RGB"
%%%%%% 2. "Seg" is the matrix that has segmentation labels for your superpixel/polygon
% Here is an Example:
load('image_rgb.mat')
load('Seg_peppers.mat')
figure;imagesc(Seg) % Your superpixel segmenetation labels

%% Draws a boundary for superpixel segmentatiodrn of the whole image

B = [];
for i = 1:numel(unique(Seg)) %number of Seg
BW=double(Seg==(i-1));
BWSegize(i) = sum(sum(BW));
[B{i},L{i}] = bwboundaries(BW,'noholes');
end
figure;imagesc(Image.RGB);hold on;
for i = 1:length(B)
visboundaries(B{i});hold on
end
% for i = 1:length(B)
%     boundary = B{i};
% plot(boundary{1}(:,2),boundary{1}(:,1),'r','LineWidth',2);hold on
% end

%% Highlight a particular segment using transparent alpha colors
AlphaDataMatrix = ones(size(Seg));
figure;
h=imagesc(Image.RGB);hold on;
for i = 24:24  %The 24th segment highlights the little onion on top; the user may change the index  to whichever segment they desire to highlight
    BW=double(Seg==(i-1));
 BWidx = find(BW==1);
 AlphaDataMatrix(BWidx) = 0.3;
  visboundaries(B{i});hold on
end
    set(h, 'AlphaData', AlphaDataMatrix);

    
%% Highlight/Fill a particular segment with transparent pink alpha colors, for example
load('image_rgb.mat')

AlphaDataMatrix = ones(size(Seg));
 Image.RGBr = reshape( Image.RGB,[size(Image.RGB,1)*size(Image.RGB,2),size(Image.RGB,3)]);

for i = 24:24 %The 24th segment highlights the little onion on top; the user may change the index to whichever segment they desire to highlight
    BW=double(Seg==(i-1));
 BWidx = find(BW==1);
 Image.RGBr(BWidx,:) = repmat([255 0 0],numel(BWidx),1); %add red color
end
 Image.RGB = reshape( Image.RGBr,[size(Image.RGB,1),size(Image.RGB,2),size(Image.RGB,3)]);

figure;
h=imagesc(Image.RGB);hold on;
for i = 24:24  %The 24th segment highlights the little onion on top; the user may change the index to whichever segment they desire to highlight
    BW=double(Seg==(i-1));
 BWidx = find(BW==1);
 AlphaDataMatrix(BWidx) = 0.3; %add transparency
  visboundaries(B{i});hold on
end
    set(h, 'AlphaData', AlphaDataMatrix);
    
%% Interactive labeling
SuperpixelLabel_dataset = []; %this stores your labels. The first row is your segment #; the second row is your manual label. 


     fig = figure(100);
    set(gcf, 'Position', [0 0 1920 1010]);%get(0,'Screensize'));
    SuperpixelLabel_dataset(1,:) = 1:max(max(Seg));
    
    for iseg = 24:24  %One may change it to the total number of superpixels. such as 1:length(B). Notice that "Seg" starts from "0" value.
        Btemp{1} = B{iseg};
        I = squeeze(Image.RGB(:,:,1));
        imagesc(Image.RGB);hold on;
        for i = 1:length(Btemp)
        visboundaries(Btemp{1});hold on
        end
        title(['Superpixel Segment #' num2str(iseg)]);
        x = inputdlg('Is this an Onion? Yes-1 No-0', 'Types');  %One may enter customized labels here
        SuperpixelLabel_dataset(2,iseg) = str2num(x{:}); 
    end
    
    
    
    
    
    
    %% Script: Labeling superpixels
%%%% Written by: X. Du 02/2017



%% Preset
%%%%%% 1. Need to load your image as "Image.RGB"
%%%%%% 2. "Seg" is the matrix that has segmentation labels for your superpixel/polygon
% Here is an Example:
load('image_rgb.mat')
load('Seg_peppers.mat')
figure;imagesc(Seg) % Your superpixel/polygon(?) segmenetation labels
%% Draws a boundary for superpixel segmentation of the whole image

B = [];
for i = 1:numel(unique(Seg)) %number of Seg
BW=double(Seg==(i-1));
BWSegize(i) = sum(sum(BW));
[B{i},L{i}] = bwboundaries(BW,'noholes');
end
figure;imagesc(Image.RGB);hold on;
for i = 1:length(B)
visboundaries(B{i});hold on
end
% for i = 1:length(B)
%     boundary = B{i};
% plot(boundary{1}(:,2),boundary{1}(:,1),'r','LineWidth',2);hold on
% end

%% Highlight a particular segment using transparent alpha colors
AlphaDataMatrix = ones(size(Seg));
figure;
h=imagesc(Image.RGB);hold on;
for i = 1:1
    BW=double(Seg==(i-1));
 BWidx = find(BW==1);
 AlphaDataMatrix(BWidx) = 0.3;
  visboundaries(B{i});hold on
end
    set(h, 'AlphaData', AlphaDataMatrix);

    
%% Highlight/Fill a particular segment with transparent pink alpha colors, for example
load('image_rgb.mat')

AlphaDataMatrix = ones(size(Seg));
 Image.RGBr = reshape( Image.RGB,[size(Image.RGB,1)*size(Image.RGB,2),size(Image.RGB,3)]);

for i = 1:1
    BW=double(Seg==(i-1));
 BWidx = find(BW==1);
 Image.RGBr(BWidx,:) = repmat([255 0 0],numel(BWidx),1); %add red color
end
 Image.RGB = reshape( Image.RGBr,[size(Image.RGB,1),size(Image.RGB,2),size(Image.RGB,3)]);

figure;
h=imagesc(Image.RGB);hold on;
for i = 1:1
    BW=double(Seg==(i-1));
 BWidx = find(BW==1);
 AlphaDataMatrix(BWidx) = 0.3; %add transparency
  visboundaries(B{i});hold on
end
    set(h, 'AlphaData', AlphaDataMatrix);
    
%% Interactive labeling
SuperpixelLabel_dataset = []; %this stores your labels. The first row is your segment #; the second row is your manual label. 


     fig = figure(100);
    set(gcf, 'Position', [0 0 1920 1010]);%get(0,'Screensize'));
    SuperpixelLabel_dataset(1,:) = 1:max(max(Seg));
    
    for iseg = 1:1%length(B) %total number of superpixels. Notice that "Seg" has "0" value!
        Btemp{1} = B{iseg};
        I = squeeze(Image.RGB(:,:,1));
        imagesc(Image.RGB);hold on;
        for i = 1:length(Btemp)
        visboundaries(Btemp{1});hold on
        end
        title(['Superpixel Segment #' num2str(iseg)]);
        x = inputdlg('Enter labels (XXXYour Label HereXXX)', 'Types');
        SuperpixelLabel_dataset(2,iseg) = str2num(x{:}); 
    end
    
    