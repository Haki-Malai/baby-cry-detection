function [convertedImage] = resizeImage(sourceImage)
    image = imread(sourceImage);
    convertedImage = imresize(image, [224,224]);
end
