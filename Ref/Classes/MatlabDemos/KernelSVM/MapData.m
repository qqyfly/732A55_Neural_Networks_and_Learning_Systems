%% Setup

% Data
[X,Y,~] = GetData(1);

%% Create background

% Data bounds
Margin = 2;
X1min = floor(min(X(:,1)) - Margin);
X1max =  ceil(max(X(:,1)) + Margin);
X2min = floor(min(X(:,2)) - Margin);
X2max =  ceil(max(X(:,2)) + Margin);

% Create grid
FieldX = linspace(X1min, X1max, 100);
FieldY = linspace(X2min, X2max, 100);
[Gx, Gy] = meshgrid(FieldX, FieldY);
G = [Gx(:), Gy(:)];

%% Mapping 3D
%  Maps data to the feature space defined by the kernel
%  K(x,y) = (x'*y + 0)^2, i.e. the polynomial combinations of x and y of
%  degree 1 and 2 (not degree 0, because of the constant being 0, otherwise
%  the space would be 6-dimensional and impossible to illustrate).

F1 = [X(Y==1 ,1).^2, X(Y==1 ,2).^2, sqrt(2).*X(Y==1 ,1).*X(Y==1 ,2)];
F2 = [X(Y==-1,1).^2, X(Y==-1,2).^2, sqrt(2).*X(Y==-1,1).*X(Y==-1,2)];

F = [F1 ; F2];

% Data bounds
F1min = floor(min(F(:,1)) - Margin);
F1max =  ceil(max(F(:,1)) + Margin);
F2min = floor(min(F(:,2)) - Margin);
F2max =  ceil(max(F(:,2)) + Margin);
F3min = floor(min(F(:,3)) - Margin);
F3max =  ceil(max(F(:,3)) + Margin);

%% Plot data

Fig = figure(101);
clf;

Ax2D = subplot(1,2,1);
hold on;

%Img = imagesc(FieldX, FieldY, ones(length(FieldY), length(FieldX)), [-5 1]);
%colormap(gray(256));

scatter(X(Y ==  1,1), X(Y ==  1,2), 150, '.b');
scatter(X(Y == -1,1), X(Y == -1,2), 150, '.r');

ylim([X2min, X2max]);
xlim([X1min, X1max]);

xlabel('X_1', 'FontWeight', 'bold');
ylabel('X_2', 'FontWeight', 'bold');

box on;
grid on;
axis square;

Ax3D = subplot(1,2,2);
hold on;

scatter3(F1(:,1), F1(:,2), F1(:,3), 150, '.b');
scatter3(F2(:,1), F2(:,2), F2(:,3), 150, '.r');

xlim([F1min F1max]);
ylim([F2min F2max]);
zlim([F3min F3max]);

xlabel('\phi_1', 'FontWeight', 'bold');
ylabel('\phi_2', 'FontWeight', 'bold');
zlabel('\phi_3', 'FontWeight', 'bold');

box on;
grid on;
axis square;

sgtitle('Mapping from 2D to 3D through K(X,Y)=(XY^T)^2');

ViewAngle = 0;
for i = 0:360
    view(Ax3D, ViewAngle, 15);
    ViewAngle = ViewAngle + 1;
    pause(0.05);
    drawnow;
end
