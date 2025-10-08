pkg load image;

img = imread('imagem.jpg');
[img_M, img_N] = size(img);
img_MN = img_M*img_N;

[counts, x] = imhist(img);
L = length(counts);

T = zeros(1, L);

for i = 1:L
  T(i) = round(((L-1)/img_MN)*sum(counts(1:i)));
  endfor;

img_output = uint8(zeros(img_M, img_N));

for i = 1:img_M
  for j = 1:img_N
    img_output(i, j) = T(img(i, j));
    endfor;
  endfor;

[countsf, xf] = imhist(img_output);

imwrite(img_output, 'imagem_saida.jpg');

plot(0:L-1, T);
axis([0 L-1 0 L-1]);

plot(xf, countsf);
