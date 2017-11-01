function [ img2DNMS ] = nms_2D(img, radius)

    neighborhood = 2*radius+1; %size of mask
    domain = ones(3,3);

    img2DNMS = ordfilt2(img, neighborhood^2, domain);
end