clear all
close all
clc



% number of classes
num_class = 24;

%% Train data
train_data = readtable("../Outex-TC-00010-c/000/train.txt");

% Length of train data
train_len = size(train_data.Var2,1);

% Wavelet features for each train image
x_train = zeros(train_len,16, 3);

% Label for each train image
y_train = train_data.Var2; 

% Wavelet features for current train image
T_train_individually = zeros(train_len/num_class, 16, 3);

% Wavelet features per class
T_train = zeros(num_class, 16, 3);

for p = 0 : num_class-1
    for q = 1 : train_len/num_class
        name = strcat('../Outex-TC-00010-c/images/', cell2mat(train_data.Var1(q + p * 20)));
        I = imread(name);
        
        % Wavelet features for the train image I
        T_train_individually(q, :, :) = Wavelet_image_features(I);
    end
    T_train(p + 1, :, :) = mean(T_train_individually);
    x_train( p*train_len/num_class+1 :(p+1)*train_len/num_class, :, :) = T_train_individually;
end

%% Test data
test_data = readtable("../Outex-TC-00010-c/000/test.txt");

% Length of test data
test_len = size(test_data.Var2,1);

% Wavelet features for each test image
x_test = zeros(test_len,16, 3);

% Label for each test image
y_test = test_data.Var2;

% Wavelet features for current test image
T_test_individually = zeros(test_len/num_class, 16, 3);

for p = 0 : num_class-1
    for q = 1 : test_len/num_class
        name = strcat('../Outex-TC-00010-c/images/', cell2mat(test_data.Var1(q + p * test_len/num_class)));
        I = imread(name);
        
        % Wavelet features for the train image I
        T_test_individually(q, :, :) = Wavelet_image_features(I);
    end
    x_test( p*test_len/num_class+1 :(p+1)*test_len/num_class, :, :) = T_test_individually;
end

%%
% Save Wavelet features in .mat file
save('Wavelet_Features_RGB.mat', 'T_train', 'x_train', 'y_train', 'x_test', 'y_test');






