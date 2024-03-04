function [X,Y,N] = GetData(DataNr)

switch DataNr
    
    case 1 % Linearly separable
        N1 = 100;
        N2 = 100;
        X1 = normrnd(0,0.75,[N1, 2]);
        X2 = normrnd(0,0.75,[N2, 2]) + [4 -4];
        N = N1 + N2;
        X = [X1; X2];
        Y = [ones(N1,1); -ones(N2,1)];
        
    case 2 % Concentric inside U-shape
        N1 = 100;
        N2 = 100;
        X1 = normrnd(0,0.75,[N1, 2]);
        X2 = [      linspace(-5, 5, N2)    + normrnd(0,0.3,[1,N2]);
            0.3 * linspace(-5, 5, N2).^2 + normrnd(0,0.3,[1,N2]) - 5]';
        N = N1 + N2;
        X = [X1; X2];
        Y = [ones(N1,1); -ones(N2,1)];
        
    case 3 % Interlocked U-shapes
        N1 = 100;
        N2 = 100;
        X1 = [       linspace(-1, 9, N1)    + normrnd(0,0.3,[1,N1]);
            -0.2 * linspace(-5, 5, N1).^2 + normrnd(0,0.3,[1,N1]) + 5]';
        X2 = [       linspace(-5, 5, N2)    + normrnd(0,0.3,[1,N2]);
            0.2 * linspace(-5, 5, N2).^2 + normrnd(0,0.3,[1,N2]) - 4]';
        N = N1 + N2;
        X = [X1; X2];
        Y = [ones(N1,1); -ones(N2,1)];
        
    case 4 % XOR-problem
        N1 = 100;
        N2 = 100;
        X1 = [normrnd(0,1,[N1/2, 2])+[3  3]; normrnd(0,1,[N1/2, 2])+[-3 -3]];
        X2 = [normrnd(0,1,[N2/2, 2])+[3 -3]; normrnd(0,1,[N2/2, 2])+[-3  3]];
        N = N1 + N2;
        X = [X1; X2];
        Y = [ones(N1,1); -ones(N2,1)];
        
    case 5 % Spiral
        N1 = 100;
        N2 = 100;
        X1 = [ 0.01 * ((1:N1).^1.5+100)' .* sin((1:N1) * 0.1)',  0.01 * ((1:N1).^1.5+100)' .* cos((1:N1) * 0.1)'] + normrnd(0,0.2,[N1,2]);
        X2 = [-0.01 * ((1:N2).^1.5+100)' .* sin((1:N2) * 0.1)', -0.01 * ((1:N2).^1.5+100)' .* cos((1:N2) * 0.1)'] + normrnd(0,0.2,[N1,2]);
        N = N1 + N2;
        X = [X1; X2];
        Y = [ones(N1,1); -ones(N2,1)];
        
    case 6 % Pure random
        N1 = 20;
        N2 = 20;
        X1 = rand(N1,2) * 10 - 5;
        X2 = rand(N2,2) * 10 - 5;
        N = N1 + N2;
        X = [X1; X2];
        Y = [ones(N1,1); -ones(N2,1)];
end

end

