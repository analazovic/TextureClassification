# TextureClassification

Implementation of different texture feature extractors and texture classifiers for both [Grayscale](https://github.com/analazovic/TextureClassification/tree/main/Grayscale%20Texture%20Image%20Classification) and [RGB](https://github.com/analazovic/TextureClassification/tree/main/RGB%20Texture%20Image%20Classification) images.<br/> 

## Grayscale Texture Image Classification
Methods used for [Feature Extraction](https://github.com/analazovic/TextureClassification/tree/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction) of grayscale texture images are based on:
 1. Gray level co-occurrence matrix (GLCM)
    - [GLCM_image_features](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction/GLCM_image_features.m)<br/> 
    - [GLCM_features_extraction](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction/GLCM_features_extraction.m)<br/>
 2. Discrete wavelet package transform (DWPT)
    - [Wavelet_image_features](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction/Wavelet_image_features.m)
<br/>
    - [Wavelet_features_extraction](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction/Wavelet_features_extraction.m)<br/> 

Inside the [folder](https://github.com/analazovic/TextureClassification/tree/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction), there is example of plotting Wavelet energy that is used for extracting features for texture classification:
 - [PlotDWPT](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction/PlotDWPT.m)<br/>
 - [DWPTExample](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Feature%20Extraction/DWPTExample.m)<br/> 

The classification is done in the [Main_program](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Main_program.m), as well as classifier evaluation.<br/>
There is also an implementation of [SVM](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/SVM.ipynb) classifier that classifies texture images using Wavelet features.<br/>
 
Inside the folder, there are three .mat files containing extracted GLCM features, Wavelet features and obtained results:<br/>
 - [GLCM_Features](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/GLCM_Features.mat)<br/> 
 - [Wavelet_Features](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Wavelet_Features.mat)<br/> 
 - [Results](https://github.com/analazovic/TextureClassification/blob/main/Grayscale%20Texture%20Image%20Classification/Results.mat)<br/> 

## RGB Texture Image Classification
Features of RGB texture images are extracted using:
 1. Discrete wavelet package transform (DWPT)
 2. Pretrained AlexNet CNN with modified last layer

[Wavelet based classification](https://github.com/analazovic/TextureClassification/tree/main/RGB%20Texture%20Image%20Classification/Wavelet%20based%20classification)<br/>
[AlexNet feature extraction and SVM](https://github.com/analazovic/TextureClassification/tree/main/RGB%20Texture%20Image%20Classification/AlexNet%20feature%20extraction%20and%20SVM)<br/>

### AlexNet feature extraction and SVM
[AlexNet_Feature_Extraction](https://github.com/analazovic/TextureClassification/blob/main/RGB%20Texture%20Image%20Classification/AlexNet%20feature%20extraction%20and%20SVM/AlexNet_Feature_Extraction.ipynb)<br/>
[SVMclassification](https://github.com/analazovic/TextureClassification/blob/main/RGB%20Texture%20Image%20Classification/AlexNet%20feature%20extraction%20and%20SVM/SVMclassification.ipynb)<br/>

### Wavelet based classification
[Wavelet_image_features](https://github.com/analazovic/TextureClassification/blob/main/RGB%20Texture%20Image%20Classification/Wavelet%20based%20classification/Wavelet_image_features.m)<br/>
[Wavelet_features_extraction_RGB](https://github.com/analazovic/TextureClassification/blob/main/RGB%20Texture%20Image%20Classification/Wavelet%20based%20classification/Wavelet_features_extraction_RGB.m)<br/>
[Main_program_RGB](https://github.com/analazovic/TextureClassification/blob/main/RGB%20Texture%20Image%20Classification/Wavelet%20based%20classification/Main_program_RGB.m)<br/>

Inside the folder, there is also a .mat file containing obtained Wavelet features:<br/>
 - [Wavelet_Features_RGB](https://github.com/analazovic/TextureClassification/blob/main/RGB%20Texture%20Image%20Classification/Wavelet%20based%20classification/Wavelet_Features_RGB.mat)<br/>


