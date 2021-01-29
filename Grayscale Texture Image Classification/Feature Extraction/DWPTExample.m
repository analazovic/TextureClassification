clear all
close all
clc

q = 160 * 14 + 5; % select image for showing DWPT decomposition
test_data = readtable("../Outex-TC-00010/000/test.txt");

% Chosen test image
name = strcat('../Outex-TC-00010/images/', cell2mat(test_data.Var1(q)));
I = imread(name);

PlotDWPT(I)

