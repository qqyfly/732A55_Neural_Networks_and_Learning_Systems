%% Select setup

SetupNr = 1;

%% Setup 1 - Linear
if (SetupNr == 1)
    Name = "Linear problem with linear kernel";
    % Seed RNG
    rng(1110);
    % Data
    [X,Y,N] = GetData(1);
    %Kernel
    Kernel = GetKernel('Linear');
    % SVM settings
    NrIter = 100;
    Step   = 1;
    Reg    = 0.5;
    Tol    = 0;
    % Plotting
    PauseTime = 0.1;
end

%% Setup 2 - Square with linear
if (SetupNr == 2)
    Name = "Quadratic problem with linear kernel";
    % Data
    [X,Y,N] = GetData(2);
    %Kernel
    Kernel = GetKernel('Linear');
    % SVM settings
    NrIter = 100;
    Step   = 10;
    Reg    = 0.5;
    Tol    = 0;
    % Plotting
    PauseTime = 0.1;
end

%% Setup 3 - Square
if (SetupNr == 3)
    Name = "Quadratic problem with quadratic kernel";
    % Data
    [X,Y,N] = GetData(2);
    %Kernel
    Kernel = GetKernel('Polynomial', 2);
    % SVM settings
    NrIter = 100;
    Step   = 1;
    Reg    = 0.5;
    Tol    = 0;
    % Plotting
    PauseTime = 0.1;
end

%% Setup 4 - Cubic with square
if (SetupNr == 4)
    Name = "Cubic problem with quadratic kernel";
    % Data
    [X,Y,N] = GetData(3);
    %Kernel
    Kernel = GetKernel('Polynomial', 2);
    % SVM settings
    NrIter = 100;
    Step   = 100;
    Reg    = 0.5;
    Tol    = 0;
    % Plotting
    PauseTime = 0;
end

%% Setup 5 - Cubic
if (SetupNr == 5)
    Name = "Cubic problem with cubic kernel";
    % Seed RNG
    rng(2222);
    % Data
    [X,Y,N] = GetData(3);
    %Kernel
    Kernel = GetKernel('Polynomial', 3);
    % SVM settings
    NrIter = 400;
    Step   = 5;
    Reg    = 0.5;
    Tol    = 0;
    % Plotting
    PauseTime = 0;
end

%% Setup 6 - Cubic with Gaussian
if (SetupNr == 6)
    Name = "Cubic problem with gaussian kernel";
    % Data
    [X,Y,N] = GetData(3);
    %Kernel
    Kernel = GetKernel('Gaussian', 6);
    % SVM settings
    NrIter = 1000;
    Step   = 1;
    Reg    = 100;
    Tol    = 0.1;
    % Plotting
    PauseTime = 0;
end

%% Setup 7 - XOR with linear
if (SetupNr == 7)
    Name = "XOR-problem with linear kernel";
    % Data
    [X,Y,N] = GetData(4);
    %Kernel
    Kernel = GetKernel('Linear');
    % SVM settings
    NrIter = 1000;
    Step   = 10;
    Reg    = 10;
    Tol    = 0;
    % Plotting
    PauseTime = 0;
end

%% Setup 8 - XOR with square
if (SetupNr == 8)
    Name = "XOR-problem with quadratic kernel";
    % Data
    [X,Y,N] = GetData(4);
    %Kernel
    Kernel = GetKernel('Polynomial', 2);
    % SVM settings
    NrIter = 1000;
    Step   = 1;
    Reg    = 100;
    Tol    = 0;
    % Plotting
    PauseTime = 0;
end

%% Setup 9 - XOR with Gaussian
if (SetupNr == 9)
    Name = "XOR-problem with gaussian kernel";
    % Data
    [X,Y,N] = GetData(4);
    %Kernel
    Kernel = GetKernel('Gaussian', 6);
    % SVM settings
    NrIter = 1000;
    Step   = 1;
    Reg    = 100;
    Tol    = 0;
    % Plotting
    PauseTime = 0;
end

%% Setup 10 - Spiral with Radial Basis Function
if (SetupNr == 10)
    Name = "Non-linear problem with radial basis function (RBF) kernel";
    % Data
    [X,Y,N] = GetData(5);
    %Kernel
    Kernel = GetKernel('RBF', 6);
    % SVM settings
    NrIter = 200;
    Step   = 5;
    Reg    = 100;
    Tol    = 0;
    % Plotting
    PauseTime = 0;
end

%% Setup 11 - Completely random with Radial Basis Function
if (SetupNr == 11)
    Name = "Random points with radial basis function (RBF) kernel";
    % Data
    [X,Y,N] = GetData(6);
    %Kernel
    Kernel = GetKernel('RBF', 1);
    % SVM settings
    NrIter = 200;
    Step   = 5;
    Reg    = 100;
    Tol    = 0.5;
    % Plotting
    PauseTime = 0;
end

%% Create background data

% Data bounds
Margin = 2;
X1min = floor(min(X(:,1)) - Margin);
X1max =  ceil(max(X(:,1)) + Margin);
X2min = floor(min(X(:,2)) - Margin);
X2max =  ceil(max(X(:,2)) + Margin);

% Create grid
FieldX = linspace(X1min, X1max, 300);
FieldY = linspace(X2min, X2max, 300);
[Gx, Gy] = meshgrid(FieldX, FieldY);
G = [Gx(:), Gy(:)];

%% Setup SVM

SVM = KernelSVM('kernel', Kernel, 'C', Reg, 'max_iter', Step, 'tol', Tol, 'verbose', false);
SVM = SVM.precompute_kernel_matrix(X);

%% Plot data and setup handles for animation

Fig = figure(101);
clf;
hold on;

Img = imagesc(FieldX, FieldY, ones(length(FieldY), length(FieldX)), [-1 1]);
Img.AlphaData = 0.2;
colormap([0.9 0 0; 1 1 1; 0 0 0.9]);

fill(nan,nan,[0.9 0   0  ], "FaceAlpha", 0.2, "DisplayName", "Predicted red");
fill(nan,nan,[0   0   0.9], "FaceAlpha", 0.2, "DisplayName", "Predicted blue");
fill(nan,nan,[1   1   1  ], "FaceAlpha", 0.2, "DisplayName", "Inside margin");

scatter(X(Y ==  1,1), X(Y ==  1,2), 150, '.b', "HandleVisibility", "off");
scatter(X(Y == -1,1), X(Y == -1,2), 150, '.r', "HandleVisibility", "off");
S = scatter(NaN, NaN, 75, 'ko', 'LineWidth', 1.5, "DisplayName", "Support vectors");

box on;
grid on;
axis equal;

ylim([X2min, X2max]);
xlim([X1min, X1max]);

xlabel('X_1', 'FontWeight', 'bold', "FontSize", 14);
ylabel('X_2', 'FontWeight', 'bold', "FontSize", 14, "Rotation", 0, "VerticalAlignment", "middle", "HorizontalAlignment", "right");
T = title('Iteration 0', "FontSize", 14);
legend("show", "Location", "eastoutside", "FontSize", 12);

%% Train and animate

for i = 1:NrIter
    % Train SVM
    [SVM, tolReached] = SVM.fit(X,Y);
    SVs = SVM.get_support_vectors();
    
    % Get background
    [GPred, GScore] = SVM.predict(G);
    GField = (GScore > 1) - (GScore < -1);
    
    % Get accuracy
    acc = SVM.score(X,Y);
    
    % Update data
    Img.CData = reshape(GField,[length(FieldY), length(FieldX)]);
    S.XData = SVs(:,1);
    S.YData = SVs(:,2);
    
    % Calc data reduction
    usage = size(SVs,1) / N;
    
    T.String = {Name, ...
                sprintf('Iteration %i', i * Step), ...
                sprintf('Accuracy = %.2f%%', 100 * acc), ...
                sprintf("Using %.2f%% of data as support vectors", 100 * usage)};
    
    if (PauseTime > 0)
        pause(PauseTime);
    end
    drawnow;
    
    % Early stop
    if (tolReached)
        fprintf('Training stopped after %i iterations because tolerance was reached.\n', i);
        break;
    end
end
