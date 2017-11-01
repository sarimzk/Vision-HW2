function [LogKernel] = createFilterConst(sigma)
    kernelSize = max(1,fix(6*sigma)+1);
    Kernel = fspecial( 'log', kernelSize, sigma );
    LogKernel = sigma.^2 * Kernel;
end

