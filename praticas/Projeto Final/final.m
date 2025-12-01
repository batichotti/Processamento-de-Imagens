pkg load image;

img = imread('Imagem.jpg');
img = im2double(img);
[M, N, ~] = size(img);

img_hsv = rgb2hsv(img);

P = 2 * M;
Q = 2 * N;
fprintf('Tamanho original: %dx%d\n', M, N);
fprintf('Tamanho com padding: %dx%d\n', P, Q);

function Hs = symmetrize_filter(H)
    H_flip = rot90(H, 2);          % rotaciona 180°
    Hs = (H + H_flip) / 2;         % média — garante simetria
endfunction

img_hsv_filtered = img_hsv; % copia a imagem HSV

for canal = 1:3
    % Extrai canal HSV
    I = img_hsv(:,:,canal);

    % Aplica padding
    I_padded = zeros(P, Q);
    I_padded(1:M, 1:N) = I;

    % FFT + shift
    F = fft2(I_padded);
    F_shift = fftshift(F);

    H = im2double(imread("filter.jpg"));
    % converter para 1 canal se RGB
    if ndims(H) == 3
        H = rgb2gray(H);
    end
    % redimensionar para P x Q
    if (size(H,1) != P || size(H,2) != Q)
        H = imresize(H, [P, Q]);
    end
    % garantir faixa
    H = max(0, min(1, H));
    % deixar filtro simétrico
    H = symmetrize_filter(H);

    F_filtered = F_shift .* H;
    F_filtered = ifftshift(F_filtered);
    I_filtered_padded = real(ifft2(F_filtered));

    % remover padding
    I_filtered = I_filtered_padded(1:M, 1:N);

    % normalizar
    I_filtered = max(0, min(1, I_filtered));
    img_hsv_filtered(:,:,canal) = I_filtered;

    % Mostrar espectros só no canal 1 (H - Matiz)
    if canal == 1
        figure(1);
        % 1º subplot – Espectro Original
        subplot(3, 1, 1);
        imshow(log(1 + abs(F_shift)), []);
        title('Espectro Original (Canal H)');
        colormap(jet);
        colorbar;

        % 2º subplot – Filtro
        subplot(3, 1, 2);
        imshow(H, []);
        title('Filtro Notch Simétrico');
        colormap(hot);
        colorbar;

        % 3º subplot – Espectro filtrado
        subplot(3, 1, 3);
        imshow(log(1 + abs(F_shift .* H)), []);
        title('Espectro Filtrado (Canal H)');
        colormap(jet);
        colorbar;
    end
end

img_hsv_filtered(:,:,3) = imadjust(img_hsv_filtered(:,:,3));
img_final = hsv2rgb(img_hsv_filtered);

figure(2);
subplot(1,2,1);
imshow(img);
title('Original');
subplot(1,2,2);
imshow(img_final);
title('Processada');

imwrite(img_final, 'resultado_final.jpg');
