clear all
close all
clc

%% Train

train_data = readtable("../Outex-TC-00010/000/train.txt");
test_data = readtable("../Outex-TC-00010/000/test.txt");

% Distance
d = 1;
offset = [0 d; -d d; -d 0; -d -d];

T_train = zeros(numel(train_data.Var1), 8);
T_train_individually = zeros(20, 4);

% Contrast
Tc_boundary = zeros(24, 2);

% Homogeneity
Th_boundary = zeros(24, 2);

% Mean value
Tm_boundary = zeros(24, 2);

% Variance
Tv_boundary = zeros(24, 2);

x_train = zeros(size(train_data.Var1, 1), 4);
x_test = zeros(size(test_data.Var1, 1), 4);

y_train = train_data.Var2; 
y_test = test_data.Var2;

for p = 0 : 23
    for m = 1 : 20 
        name = strcat('../Outex-TC-00010/images/', cell2mat(train_data.Var1(m + p * 20)));
        
        % Original image 
        I = imread(name);
        
        % GLCM features for the train image I
        T_train_individually(m, :) = GLCM_image_features(I);
        x_train( p*20 + m,:) = T_train_individually(m, :);
    end
    
    % Boundaries for contrast
    Tc_boundary(p + 1, :) = [min(T_train_individually(:, 1)) max(T_train_individually(:, 1))]; 
    
    % Boundaries for homogeneity
    Th_boundary(p + 1, :) = [min(T_train_individually(:, 2)) max(T_train_individually(:, 2))]; 
    
    % Boundaries for mean value
    Tm_boundary(p + 1, :) = [min(T_train_individually(:, 3)) max(T_train_individually(:, 3))]; 
    
    % Boundaries for variance
    Tv_boundary(p + 1, :) = [min(T_train_individually(:, 4)) max(T_train_individually(:, 4))];
end

for p = 0 : 23
    for m = 1 : numel(y_test)/24 
        name = strcat('../Outex-TC-00010/images/', cell2mat(test_data.Var1(m + p * numel(y_test)/24 )));
        
        % Original image 
        I = imread(name);
        
        % GLCM features for the test image I
        x_test( p*numel(y_test)/24 + m,:) = GLCM_image_features(I);
    end
end
%%
% Save GLCM features in .mat file
save('../GLCM_Features.mat', 'Tc_boundary', 'Th_boundary', 'Tm_boundary', 'Tv_boundary', 'x_train', 'y_train', 'x_test', 'y_test')
