pkg load image;

ogim = im2double(imread('pratica4.jpg')); % 1, 2
filt = 9;
b = ones(filt,filt)/81; %

sobel1 = [-1 -2 -1; 0 0 0; 1 2 1];
sobel2 = [-1 0 1; -2 0 2; -1 0 1]; % 8

filterim = filter2(b, ogim); % 4
% imshow(filterim); Cria imagem com borda preta, 5

pad = (filt - 1) / 2;

paddim = padarray(ogim, [pad, pad], 'replicate'); % 6
filtpadim = filter2(b, paddim, 'valid'); % 7

% imshow(filtpadim);

sobel_paddim = padarray(ogim, [1, 1], 'replicate');
sobel_im1 = filter2(sobel1, sobel_paddim, 'valid');
sobel_im2 = filter2(sobel2, sobel_paddim, 'valid'); % 9

[altura, largura] = size(sobel_im1);
sobel_im = zeros(altura, largura);

for x = 1:largura
  for y = 1:altura
    sobel_im(x, y) = abs(sobel_im1(x, y)) + abs(sobel_im2(x, y)); %10
  endfor
endfor

imshow(sobel_im);

imwrite(filterim, 'filtered_img.jpg');
imwrite(filtpadim, 'padding_filtered_img.jpg');
imwrite(sobel_im, 'sobel_img.jpg');
