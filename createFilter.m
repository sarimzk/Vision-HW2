function [LogKernel] = createFilter(j, sigma, scaleMultiplier)
    scaledSigma = sigma * scaleMultiplier^(j-1);
    kernelSize = max(1,fix(6*scaledSigma)+1);  %+1 to guarantee odd filter size
    % Create a Laplacian of Gaussian kernel ('log')
    LogKernel = fspecial( 'log', kernelSize, scaledSigma );
    % Nomrmalize the kernel 
    LogKernel = scaledSigma.^2 * LogKernel;
end