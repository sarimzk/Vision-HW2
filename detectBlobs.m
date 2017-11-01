function [ scaleSpace3D ] = detectBlobs( img_GrayScale, scales, sigma, k, threshold, n )



% Define Parameters
[h, w] = size(img_GrayScale); 


% Generate the various scales by applying the filter
display('Generating Scale Space'); tic;
scaleSpace = generateScaleSpace(img_GrayScale, scales, sigma, k, n);
display('Finished generating scale space'); toc;


%first do nonmaximum suppression in each 2D slice separately
scaleSpace2D = zeros(h,w,scales);
i = 1;
while i <= scales
    scaleSpace2D(:,:,i) = nms_2D(scaleSpace(:,:,i),1);
    i = i + 1;
end


%3D Non Max Suppression Between Neighboring Scales
scaleSpace3D = nms_3D(scaleSpace2D, scaleSpace, scales);

%Threshold

threshBinaryFlag = scaleSpace3D > threshold;

scaleSpace3D = scaleSpace3D .* threshBinaryFlag;

end