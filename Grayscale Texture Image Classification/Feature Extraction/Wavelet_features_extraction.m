clear all
close all
clc


% Number of classes
num_class = 24;

%% Train
train_data = readtable("../Outex-TC-00010/000/train.txt");

% Number of train images
train_len = size(train_data.Var2,1);

% Wavelet features of train images
x_train = zeros(train_len,16);

% Class labels for train images
y_train = train_data.Var2; 

% Wavelet features of current train image
T_train_individually = zeros(train_len/num_class, 16);

% Wavelet features images per class
T_train = zeros(num_class, 16);

for p = 0 : num_class-1
    for q = 1 : train_len/num_class
        name = strcat('../Outex-TC-00010/images/', cell2mat(train_data.Var1(q + p * 20)));
        I = imread(name);
        
        % Wavelet features for the train image I
        T_train_individually(q, :) = Wavelet_image_features(I);
    end
    T_train(p + 1, :, 1) = mean(T_train_individually);
    x_train( p*train_len/num_class+1 :(p+1)*train_len/num_class, :) = T_train_individually;
end

%% Test
test_data = readtable("../Outex-TC-00010/000/test.txt");

% Number of test images
test_len = size(test_data.Var2,1);

% Wavelet features of test images 
x_test = zeros(test_len,16);

% Class labels for test images
y_test = test_data.Var2;

% Wavelet features of current test image
T_test_individually = zeros(test_len/num_class, 16);

for p = 0 : num_class-1
    for q = 1 : test_len/num_class
        name = strcat('../Outex-TC-00010/images/', cell2mat(test_data.Var1(q + p * test_len/num_class)));
        I = imread(name);
        
        % Wavelet features for the train image I
        T_test_individually(q, :) = Wavelet_image_features(I);
    end
    x_test( p*test_len/num_class+1 :(p+1)*test_len/num_class, :) = T_test_individually;
end


%%
% Save Wavelet features in .mat file
save('../Wavelet_Features.mat', 'T_train', 'x_train', 'y_train', 'x_test', 'y_test');






