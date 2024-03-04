function Kernel = GetKernel(Type, varargin)
% GETKERNEL returns a kernel object of Type.
% 
% The kernel object is a struct with two fields: "func", "canMatrix".
% func is the kernel function, and canMatrix indicates if the function can
% accept matrix inputs (this is usually much faster when training).
%
% Supported kernels:
%     'Linear'     - Normal dot product.
%     'Polynomial' - Polynomial kernel of configurable power.
%     'Gaussian'   - Gaussian kernel with configurable StD.
%     'Laplace'    - Laplace kernel with configurable StD.
%     'RBF'        - Radial Basis Function kernel with configurable StD.
%
% Example:
%     kernel = GetKernel('Linear')
%     kernel = 
%        struct with fields:
%                func: @(U,V)(U*V')
%           canMatrix: 1
%
%     kernel = GetKernel('Gaussian', 4)
%     kernel = 
%        struct with fields:
%                func: @(U,V)exp(-(pdist2(U,V).^2)/(stdev.^2))
%           canMatrix: 1

% Checking optinal inputs
switch Type
    case 'Polynomial'
        if (nargin < 2)
            error('When using "%s" kernel, the power must be specified.', Type);
        end
        power = varargin{1};
        if (~(isscalar(power) & isnumeric(power)))
            error('The polynomial power must be a numeric scalar.');
        end
    case {'Gaussian', 'Laplace', 'RBF'}
        if (nargin < 2)
            error('When using "%s" kernel, the standard deviation must be specified.', Type);
        end
        stdev = varargin{1};
        if (~(isscalar(stdev) & isnumeric(stdev)))
            error('The standard deviation of a "%s" kernel must be a numeric scalar.', Type);
        end
end

% Create kernel
switch Type
    case 'Linear'
        Kernel.func = @(U,V) (U*V');
        Kernel.canMatrix = true;
    case 'Polynomial'
        Kernel.func = @(U,V) (U*V' + 1).^power;
        Kernel.canMatrix = true;
    case 'Gaussian'
        Kernel.func = @(U,V) exp(-(pdist2(U,V).^2)/(stdev.^2));
        Kernel.canMatrix = true;
    case 'Laplace'
        Kernel.func = @(U,V) exp(-pdist2(U,V)/stdev);
        Kernel.canMatrix = true;
    case 'RBF'
        Kernel.func = @(U,V) exp(-(pdist2(U,V).^2)/(2 * stdev));
        Kernel.canMatrix = true;
    otherwise
        error('Kernel type "%s" is not supported!', Type);
end

