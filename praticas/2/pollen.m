img = imread('pollen.jpg');

info = size(img);

saida = uint8(zeros(info(1), info(2)));

r1 = 75;
s1 = 0;

r2 = 175;
s2 = 255;

T = zeros(1, 256);

for r = 0:255
    if r <= r1
        T(r+1) = (s1/ r1) * r;
    elseif r <= r2
        T(r+1) = ((s2 - s1)/(r2 - r1)) * (r - r1) + s1;
    else
        T(r+1) = ((255 - s2)/(255 - r2)) * (r - r2) + s2;
    end
end

plot(0:255, T);

for i = 1:info(1)
    for j = 1:info(2)
        saida(i,j) = T(img(i,j)+1);
    end
end

imshow(saida);
imwrite(saida, 'output.jpg');
