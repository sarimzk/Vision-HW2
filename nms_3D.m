function [ scaleSpace3D ] = nms_3D( scaleSpace2D, originalScaleSpace, scales ) 
%Referenced from lambertoballan's code on GitHub, at [https://github.com/lambertoballan/handsonbow/blob/master/matlab/BlobDetector.m]
i = 1;
while i <= scales
    if i == 1
        lowerScale = i;
        upperScale = i+1;
    elseif i < scales
        lowerScale = i-1;
        upperScale = i+1;
    else
        lowerScale = i-1;
        upperScale = i;
    end
    scaleSpace2D(:,:,i) = max(scaleSpace2D(:,:,lowerScale:upperScale),[],3);
    i = i+1;
end

%mark every location where the max value is the actual value from that
%scale with a 1, and a 0 otherwise.
originalMarkers = scaleSpace2D == originalScaleSpace;
%only keep the max vals that were actually from those locations
scaleSpace3D = scaleSpace2D .* originalMarkers;

end