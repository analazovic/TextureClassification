clear all
close all
clc

load('GLCM_Features.mat')
load('Wavelet_Features.mat')
addpath('./Feature Extraction/');
%% Test
test_data = readtable("Outex-TC-00010/000/test.txt");
num_correct_combo = 0; num_correct_GLCM = 0; num_correct_Wavelet = 0; num_correct_Wavelet2 = 0; num_correct_Wavelet3 = 0; num_correct_combo3 = 0;
correct_per_class = zeros(4, 24);

% Test image names
data_text = test_data.Var1;

% Test image class labels
data_class = test_data.Var2;

% Predicted labels of test images
outputs = data_class;

for q = 1 : numel(data_text)
    if mod(q, 384) == 0
        disp([num2str(q / 38.4) '%'])
    end
    
    % Original test image
    name = strcat('Outex-TC-00010/images/',cell2mat(data_text(q)));
    I = imread(name);
    
    % GLCM features based on test image
    T_test_avg = GLCM_image_features(I);
    
    % Classification based on GLCM features
    weights_per_class = zeros(24, 1);
    for i = 1 : 24
        if(T_test_avg(1) >=  Tc_boundary(i, 1) && T_test_avg(1) <=  Tc_boundary(i, 2))
            weights_per_class(i) = weights_per_class(i) + 1;
        end
        
        if(T_test_avg(2) >=  Th_boundary(i, 1) && T_test_avg(2) <=  Th_boundary(i, 2))
            weights_per_class(i) = weights_per_class(i) + 1;
        end
        
        if(T_test_avg(3) >=  Tm_boundary(i, 1) && T_test_avg(3) <=  Tm_boundary(i, 2))
            weights_per_class(i) = weights_per_class(i) + 1;
        end
        
        if(T_test_avg(4) >=  Tv_boundary(i, 1) && T_test_avg(4) <=  Tv_boundary(i, 2))
            weights_per_class(i) = weights_per_class(i) + 1;
        end
    end
    
    % Test image is assigned to the class with maximum weight
    [maximum, class_GLCM] = max(weights_per_class);
    class_GLCM = class_GLCM - 1;
    if class_GLCM == data_class(q) && maximum > 0
        num_correct_GLCM = num_correct_GLCM + 1;
        correct_per_class(1, class_GLCM + 1) = correct_per_class(1, class_GLCM+1) + 1;
    end
    
    % Classification based on Wavelet features
    T_test = Wavelet_image_features(I);
    
    % Distance between wavelet features of the test image and wavelet features calculated on train set
    distance = zeros(24,1);
    for i = 1 : 24
        distance(i) = sum(abs(T_train(i,:) - T_test));
    end
    
    % Test image is assigned to the class with minimum distance between wavelet features of the test image and wavelet features calculated on train set
    [~, class_Wavelet] = min(distance);
    class_Wavelet = class_Wavelet - 1; 
    outputs(q) = class_Wavelet;
    if class_Wavelet == data_class(q)
        num_correct_Wavelet = num_correct_Wavelet + 1;
        correct_per_class(2, class_Wavelet + 1) = correct_per_class(2, class_Wavelet + 1) + 1;
    end
    
    % Sort distance in ascending order
    [~, idx] = sort(distance);
    
    % Wavelet top 2 classes
    class_Wavelet2 = idx(2) - 1;
    
    % Wavelet top 3 classes
    class_Wavelet3 = idx(3) - 1;
    
    if class_Wavelet == data_class(q) || class_Wavelet2 == data_class(q)
        num_correct_Wavelet2 = num_correct_Wavelet2 + 1;
    end
    
    if class_Wavelet == data_class(q) || class_Wavelet2 == data_class(q) || class_Wavelet3 == data_class(q)
        num_correct_Wavelet3 = num_correct_Wavelet3 + 1;
    end
    
    % Classification based on combination of GLCM and Wavelet top 2 classes
    pom_weight = [weights_per_class(class_Wavelet + 1) weights_per_class(class_Wavelet2 + 1)];
    [~, ind] = max(pom_weight);
    if ind == 1
        class_combo = class_Wavelet;
    else
        class_combo = class_Wavelet2;
    end
    if class_combo == data_class(q)
        num_correct_combo = num_correct_combo+1;
        correct_per_class(3, class_combo+1) = correct_per_class(3, class_combo + 1) + 1;
    end
    
    % Classification based on combination of GLCM and Wavelet top 3 classes
    pom_weight = [weights_per_class(class_Wavelet + 1) weights_per_class(class_Wavelet2 + 1) weights_per_class(class_Wavelet3 + 1)];
    [~, ind] = max(pom_weight);
    if ind == 1
        class_combo3 = class_Wavelet;
    elseif ind == 2
        class_combo3 = class_Wavelet2;
    else
        class_combo3 = class_Wavelet3;
    end
    if class_combo3 == data_class(q)
        num_correct_combo3 = num_correct_combo3 + 1;
        correct_per_class(4, class_combo3 + 1) = correct_per_class(4, class_combo3 + 1) + 1;
    end
    
end
correct_per_class = correct_per_class./160.*100; correct_per_class=correct_per_class';

%% Results
percentage_wavelet = num_correct_Wavelet / numel(data_class) * 100;
disp(['Accuracy of the Wavelet algorithm: ' num2str(percentage_wavelet) '%'])

percentage_GLCM = num_correct_GLCM/numel(data_class) * 100;
disp(['Accuracy of the GLCM algorithm: ' num2str(percentage_GLCM) '%'])

percentage = num_correct_Wavelet2 / numel(data_class);
disp(['Accuracy of the Wavelet algorithm for the first two: ' num2str(percentage * 100) '%'])

percentage_combo = num_correct_combo / numel(data_class) * 100;
disp(['Accuracy of the combination of the algorithms (Wavelet 2): ' num2str(percentage_combo) '%'])

percentage = num_correct_Wavelet3 / numel(data_class);
disp(['Accuracy of the Wavelet algorithm for the first three: ' num2str(percentage * 100) '%'])

percentage = num_correct_combo3 / numel(data_class);
disp(['Accuracy of the combination of the algorithms (Wavelet 3): ' num2str(percentage * 100) '%'])


num_correct_GLCM_wavelet_combo = correct_per_class(:, 1 : 3);

Table_GLCM = [Tc_boundary Th_boundary Tm_boundary Tv_boundary];
save('Results.mat','T_train','Table_GLCM','num_correct_GLCM_wavelet_combo',...
     'percentage_GLCM','percentage_wavelet','percentage_combo')
