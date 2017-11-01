

targetImg = imread('butterfly.jpg');
targetImg = im2double(targetImg);
img_GrayScale = rgb2gray(targetImg);

scales = 13; %number of scales
sigma = 2; %value of sigma
k = sqrt(sqrt(2)); %scale multiplication constant  
threshold = 0.017; %threshold
n = 2; %keep n = 1 for downsampling image and then applying kernel, choose n = 2 for upscaling the kernel and keeping the image same (inefficient method)

scaleSpace3D = detectBlobs( img_GrayScale, scales, sigma, k, threshold, n ); %detects blobs in the given image using the defined parameters

j = 1;


%Referenced from lambertoballan's code on GitHub, at [https://github.com/lambertoballan/handsonbow/blob/master/matlab/BlobDetector.m]

ScaleRadii = zeros(1,scales); %initializing the ScaleRadii array to zero, which store the blob radius value for each scale
while j <= scales
    ScaleRadii(j) =  sqrt(2) * sigma * k^(j-1); 
    j = j+1;
end

i = 1;
blobMarkers = []; %blob markers is a 3 column matrix that stores the x coordinate, y coordinate and the corresponding radius of each blob
while i <= scales
    %find indices in the scale slice where the pixel value is not 0
    [newMarkerRows, newMarkerCols] = find(scaleSpace3D(:,:,i));
    
    newMarkers = [newMarkerCols'; newMarkerRows'];
    newMarkers(3,:) = ScaleRadii(i);
     
    %append the calculated positions/radius for this slice to the
    %entire collection (transpose of course)
    blobMarkers = [blobMarkers; newMarkers'];   
    i = i + 1;
end

xPos = blobMarkers(:,1); %col positions
yPos = blobMarkers(:,2); %row positions
radius = blobMarkers(:,3); %radii

show_all_circles(img_GrayScale, xPos, yPos, radius, 'r', .5); %overlay on gray img