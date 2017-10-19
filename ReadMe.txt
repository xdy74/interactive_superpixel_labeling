This folder contains an example in MATLAB for plotting the boundaries of superpixels in a pre-segmented image and then interactively manually labeling each superpixel labels.

# interative superpixel labeling

Matlab implementation of interative superpixel labeling

***************************************************************
Script:
"demo_interactive_superpixel_label.m" - the main demo script

Data:
"image_rgb.mat" - a Image structure variable, where Image.RGB is the RGB of the image (size N1xN2x3) that the user is labeling. In this example, the RGB image is from MATLAB's pre-packaged demo image peppers.png
"Seg_peppers.mat" - a pre-segmentaion of the peppers image. The variable "Seg" (size N1xN2) contains segmentation label values for each pixel in the image, the pixels with the same value belong to the same segment, or "superpixel". Note the values in Seg starts from 0 to (NumSegments - 1). *This pre-segmentation is done by SLIC algorithm (http://ivrl.epfl.ch/research/superpixels).

***************************************************************
The purpose of this demo script is to illustrate plotting an RGB image file with its segmented superpixels and then interactively label each superpixel. 
A possible application for this example could be crowdsourcing manual labels from many users for supervised or semi-supervised learning. 

The example first loads the RGB data and draws a bounary for each superpixel segmentation of the whole image. Then, for the total number of superpixels (or the number of superpixels the user is desiring to label), an interactive labeling interface was built and the manual labeling is stored in the variable "SuperpixelLabel_dataset". Note that the manual label only works for number. One may change what each label number represents at will.

In addition, a feature that can highlight a particular segment using transparent alpha colors was implemented and demonstrated in the code.

***********************************************************************


 Authors: Xiaoxiao Du
 University of Missouri, Department of Electrical and Computer Engineering  
 Email Address: xdy74@mail.missouri.edu
 Latest Revision: February 2017  

This code uses Matlab Image Processing Toolbox. 


