function f = PlotDWPT(I)

% Wavelet packet tree corresponding to the wavelet packet decomposition of the image I at level 2
t = wpdec2(I, 2, 'db1');

% Array of energy
energy_array = zeros(1, 16);

figure(1)
for m = 1 : 16
    subplot(4, 4, m)
    
    % Coefficients of the tree nodes 
    b = read(t, 'data', [m + 4]);
    
    imagesc(uint8(b))
    colormap gray
    axis off
    energy_array(m) = 1 / 32 / 32 * sum( sum( abs( b ) ) );
end
suptitle('Image decomposition using DWPT')

figure(2)
imshow(I)
title('Original image')

