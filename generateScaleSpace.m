function [ scaleSpace ] = generateScaleSpace( img_GrayScale, scales, sigma, k, n)

    [h,w] = size(img_GrayScale);
    scaleSpace = zeros(h, w, scales); % structure to hold the scale space 
    switch n %Downsize the image by 1/k, filter with same kernel, and then rescale/upsize back (efficient)
        case 1

            LogKernel = createFilterConst(sigma); %Generate just 1 normalized filter
            reUpscaledImg = zeros(h,w);
            downsizedImg = img_GrayScale;
            i = 1;
            while i <= scales
                % Downsize the image by 1/k
                if i==1
                    downsizedImg = img_GrayScale;
                else
                    downsizedImg = imresize(img_GrayScale, 1/(k^(i-1)), 'bicubic');
                end
                % Filter the image to generate a response to the laplacian of
                % gaussian 
                filteredImage = imfilter(downsizedImg, LogKernel,'same', 'replicate');
                %Save square of Laplacian response for current level of scale space
                filteredImage = filteredImage .^ 2;
                % Upscale the filter response
                reUpscaledImg = imresize(filteredImage, [h,w], 'bicubic');
                % Store it at the appropriate level in the scale space
                scaleSpace(:,:,i) = reUpscaledImg;
                i = i + 1;
            end
        
        case 2 %increase kernel size for each scale and original image remains unchanged (inefficient)
            j = 1;
            while j <= scales
                
                LoGKernel = createFilter(j, sigma, k); %regenerate kernel for each scale

                
                filteredImage = imfilter(img_GrayScale, LoGKernel,'same', 'replicate'); %filter image with generated kernel to obtain LoG response for that scale
                filteredImage = filteredImage .^ 2;

                % Store it at the appropriate level in the scale space
                scaleSpace(:,:,j) = filteredImage;   
                j = j + 1;
            end
    end
    
   

end