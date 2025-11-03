pkg load image;

fotinha = im2double(imread('pratica5.png'));

[altura, largura] = size(fotinha)

P = altura*2;
Q = largura*2;

f_fotinha = fft2(fotinha, P, Q); % Transformada Bidimensional (2D)

fs_fotinha = fftshift(f_fotinha);

mag = uint8(abs(fs_fotinha));

imshow(mag);

d_0 = 20;

d_f = 0;

filtro = zeros(P, Q);

for u = 1:P-1
  for v = 1:Q-1
    d_f = sqrt((u-P/2)^2+(v-Q/2)^2);
    filtro(u, v) = exp((-d_f^2)/(2*d_0^2));
  endfor
endfor

% imshow(filtro);

fsf_fotinha = fs_fotinha .* filtro;

fsfd_fotinha = ifftshift(fsf_fotinha);

fsfdi_fotinha = ifft2(fsfd_fotinha);

fsfdir_fotinha = real(fsfdi_fotinha);

fsfdiru_fotinha = zeros(altura, largura);

for u = 1:P/2
  for v = 1:Q/2
    fsfdiru_fotinha(u, v) = fsfdir_fotinha(u, v);
  endfor
endfor

fsfdiru_fotinha = im2uint8(fsfdiru_fotinha);

imshow(fsfdiru_fotinha);
imwrite(fsfdiru_fotinha, 'output.png');

