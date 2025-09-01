tungsten = im2double(imread('.\res\tungsten_filament_shaded.tif'));
shade = im2double(imread('.\res\tungsten_sensor_shading.tif'));
shade = shade + 0.00001;
fixed_image = tungsten ./ shade;
imwrite(fixed_image, 'itworks.tif');