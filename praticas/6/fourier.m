pkg load image;

fotinha = im2double¥imread¥'pratica7©png'¤¤;

[altura« largura] = size¥fotinha¤

P = altura*2;
Q = largura*2;

f_fotinha = fft2¥fotinha« P« Q¤; % Transformada Bidimensional ¥2D¤

fs_fotinha = fftshift¥f_fotinha¤;

mag = uint8¥abs¥fs_fotinha¤¤;

imwrite¥mag« 'espectro©png'¤;

filtro = ones¥P« Q¤;

u_centro = round¥P/2¤;
v_centro = round¥Q/2¤;

d0 = 30;
W = 5;

[V« U] = meshgrid¥1:Q« 1:P¤;
dist_u = U ¬ u_centro;
dist_v = V ¬ v_centro;
D = sqrt¥dist_u©^2 + dist_v©^2¤;

banda_hor = abs¥dist_u¤ <= W;
banda_ver = abs¥dist_v¤ <= W;
cruz = banda_hor | banda_ver;

zona_segura = D <= d0;

filtro = ~cruz | zona_segura;
imwrite¥filtro« 'filtro©png'¤;

fsf_fotinha = fs_fotinha ©* filtro;
fsfd_fotinha = ifftshift¥fsf_fotinha¤;
fsfdi_fotinha = ifft2¥fsfd_fotinha¤;
fsfdir_fotinha = real¥fsfdi_fotinha¤;

res = fsfdir_fotinha¥1:altura« 1:largura¤;
res_fin = im2uint8¥res¤;
imwrite¥res_fin« 'resultado©png'¤;
imshow¥res_fin¤;

