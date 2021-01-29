function energy_array = Wavelet_image_features(I)

% If image is RGB
if size(I, 3) == 3
    
    % Array of energy
    energy_array = zeros(16, 3);%zeros(1, 16)
    
    % Wavelet packet tree corresponding to the wavelet packet decomposition of the image I at level 2
    t = wpdec2(I, 2, 'db1');
    
    for m = 1:16
        % Coefficients of the tree nodes
        b = read(t,'data',[m + 4]);
        
        % Energy
        energy_array(m, :)= 1 / 32 / 32 * sum( sum( abs( b(:,:) ) ) );
    end
else % If image is grayscale
    
    % Array of energy
    energy_array = zeros(1, 16);
    
    % Wavelet packet tree corresponding to the wavelet packet decomposition of the image I at level 2
    t = wpdec2(I, 2, 'db1');
    
    for m = 1:16
        % Coefficients of the tree nodes
        b = read(t,'data', [m + 4]);
        
        % Energy
        energy_array(m)= 1 / 32 / 32 * sum( sum( abs( b ) ) );
    end
end