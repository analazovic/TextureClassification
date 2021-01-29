clear all
close all
clc


load('Wavelet_Features_RGB.mat')
%% Test

test_data = readtable("../Outex-TC-00010-c/000/test.txt");

% Total number of correct classified images
num_correct_Wavelet = 0;

% Number of corrected classified images per class
correct_per_class = zeros(1, 24);

% Test image names
data_text = test_data.Var1;

% Test image labels
data_class = test_data.Var2;

% Predicted labels of test images
outputs = data_class;

for q = 1 : numel(data_text)
    
    if mod(q, 384) == 0
        disp([num2str(q / 38.4) '%'])
    end
    
    % Original test image
    name = strcat('../Outex-TC-00010-c/images/', cell2mat(data_text(q)));
    I = imread(name);
    
    % Wavelet features of current test image
    T_test = Wavelet_image_features(I);
    
    % Distance between wavelet features of the test image and wavelet features calculated on train set
    distance = zeros(24,3);
    for i = 1 : 24
        distance(i, :) = sum(abs(squeeze(T_train(i,:, :)) - T_test));
    end
    distance = sum(distance, 2);
    
    % Test image is assigned to the class with minimum distance between wavelet features of the test image and wavelet features calculated on train set
    [~, class_Wavelet] = min(distance);
    class_Wavelet = class_Wavelet - 1; 
    outputs(q) = class_Wavelet;
    
    if class_Wavelet == data_class(q)
        num_correct_Wavelet = num_correct_Wavelet + 1;
        correct_per_class(class_Wavelet + 1) = correct_per_class(class_Wavelet + 1) + 1;
    end
end


%% Results
percentage_wavelet = num_correct_Wavelet / numel(data_class) * 100;
disp(['Accuracy of the Wavelet algorithm: ' num2str(percentage_wavelet) '%'])
disp('')
disp('Percent of correct classified images per class:')
for i = 1 : numel(correct_per_class)
   disp([num2str(i)  '. class: '  num2str(correct_per_class(i) / 160 * 100) '%']) 
end
