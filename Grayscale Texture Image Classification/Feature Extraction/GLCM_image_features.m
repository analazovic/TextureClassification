function T_test_avg = GLCM_image_features(I)

% Distance
d = 1;
offset = [0 d; -d d; -d 0; -d -d];

% Number of gray levels of an image
grayLevels = length(unique(I));

% GLCM (Symmetric and normalized gray level co-occurrence matrix)
GLCM = graycomatrix(I,'Offset', offset, 'NumLevels', grayLevels, 'Symmetric', true, 'GrayLimits', []);

% GLCM for direction theta = 0°
GLCM_0 = GLCM(:, :, 1)/sum(sum(GLCM(:, :, 1)));

% GLCM for direction theta = 45°
GLCM_45 = GLCM(:, :, 2)/sum(sum(GLCM(:, :, 2)));

% GLCM for direction theta = 90°
GLCM_90 = GLCM(:, :, 3)/sum(sum(GLCM(:, :, 3)));

% GLCM for direction theta = 135°
GLCM_135 = GLCM(:, :, 4)/sum(sum(GLCM(:, :, 4)));

% Dimension of matrices of texture features
N = grayLevels;

% Contrast, homogeneity, mean value and variance based on GLCM_0
Gc0 = 0;
Gh0 = 0;
Gm0 = 0;
Gv0 = 0;
for i = 1 : N
    for j = 1 : N
        Gc0 = Gc0 + GLCM_0(i, j) * (i - j)^2;
        Gh0 = Gh0 + GLCM_0(i, j)/(1 + (i-j)^2);
        Gm0 = Gm0 + GLCM_0(i, j) * i;
        Gv0 = Gv0 + GLCM_0(i, j) * (j - Gm0)^2;
    end
end

% Contrast, homogeneity, mean value and variance based on GLCM_45
Gc45 = 0;
Gh45 = 0;
Gm45 = 0;
Gv45 = 0;
for i = 1 : N
    for j = 1 : N
        Gc45 = Gc45 + GLCM_45(i, j) * (i - j)^2;
        Gh45 = Gh45 + GLCM_45(i, j)/(1 + (i-j)^2);
        Gm45 = Gm45 + GLCM_45(i, j) * i;
        Gv45 = Gv45 + GLCM_45(i, j) * (j - Gm45)^2;
    end
end

% Contrast, homogeneity, mean value and variance based on GLCM_90
Gc90 = 0;
Gh90 = 0;
Gm90 = 0;
Gv90 = 0;
for i = 1 : N
    for j = 1 : N
        Gc90 = Gc90 + GLCM_90(i, j) * (i - j)^2;
        Gh90 = Gh90 + GLCM_90(i, j)/(1 + (i-j)^2);
        Gm90 = Gm90 + GLCM_90(i, j) * i;
        Gv90 = Gv90 + GLCM_90(i, j) * (j - Gm90)^2;
    end
end

% Contrast, homogeneity, mean value and variance based on GLCM_135
Gc135 = 0;
Gh135 = 0;
Gm135 = 0;
Gv135 = 0;
for i = 1 : N
    for j = 1 : N
        Gc135 = Gc135 + GLCM_135(i, j) * (i - j)^2;
        Gh135 = Gh135 + GLCM_135(i, j)/(1 + (i-j)^2);
        Gm135 = Gm135 + GLCM_135(i, j) * i;
        Gv135 = Gv135 + GLCM_135(i, j) * (j - Gm135)^2;
    end
end

% Contrast, homogeneity, mean value and variance calculated as mean value of features based on GLCM_0, GLCM_45, GLCM_90 and GLCM_135
T_test_avg = [mean([Gc0, Gc45, Gc90, Gc135]) mean([Gh0, Gh45, Gh90, Gh135]) mean([Gm0, Gm45, Gm90, Gm135]) mean([Gv0, Gv45, Gv90, Gv135])];
