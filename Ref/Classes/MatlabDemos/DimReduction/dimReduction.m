%% PCA and LDA demo using county data.
%  Note that this code only works in Matlab 2017 and later due to using
%  broadcasting when working with the data. It's possible to do all the
%  same operations using loops, but these solutions are not shown here.

%% Setup
%  You should not change this section.

load countrydata
countries = cellstr(countries);
countryclass = countryclass + 1;
VarNames = {'Population density', ...
            'Proportion of town residents', ...
            'Average lifespan of women', ...
            'Average lifespan of men', ...
            'Ability to read', ...
            'Increase in population', ...
            'Infant mortality', ...
            'Births per 1000', ...
            'Deceases per 1000', ...
            'GNP', ...
            'Nativity/Mortality', ...
            'Avg number of children', ...
            'Population'};
ClassNames = {'Developing', 'Middle', 'Industrialized'};
        
%% Normalization
%  Here you will create a new dataset that is normalized according to the
%  below instructions. You can play around with different normalizations,
%  but the solutions in the exercice compendium expect the data to be
%  according to these instructions.

% Normalize the data so that each feature (varible) has a mean of 0 and a
% standard deviation of 1.
% scaledData = ...;

% Plot original data
figure(101);
clf;
subplot(2,1,1);
imagesc(countrydata);
axis image;
set(gca, 'xTick', 1:size(countrydata, 2));
set(gca, 'xTickLabel', strcat(countries, ' (', extractBefore(ClassNames(countryclass)',2), ')'));
set(gca, 'xTickLabelRotation', 90);
set(gca, 'FontSize', 9);
set(gca, 'yTick', 1:size(countrydata, 1));
set(gca, 'yTickLabel', VarNames);
title({'Country data, original', ...
       'D = Developing, M = Middle, I = Industrialized'}, 'FontSize', 12);
colorbar('FontSize', 10);

% Plot scaled data
subplot(2,1,2);
imagesc(scaledData);
axis image;
set(gca, 'xTick', 1:size(countrydata, 2));
set(gca, 'xTickLabel', strcat(countries, ' (', extractBefore(ClassNames(countryclass)',2), ')'));
set(gca, 'xTickLabelRotation', 90);
set(gca, 'FontSize', 9);
set(gca, 'yTick', 1:size(countrydata, 1));
set(gca, 'yTickLabel', VarNames);
title({'Country data, normalized per feature', ...
       'D = Developing, M = Middle, I = Industrialized'}, 'FontSize', 12);
colorbar('FontSize', 10);

%% Covariance and correlation
%  Calculate and plot the covariance matrix and the correlation matrix. You
%  will analyze these to find the hidden correlation in the dataset.

% Number of samples
N = size(scaledData, 2);

% Calculate the covarance matrix of the dataset.
% Cov = ...;

% Calculate the Correlation matrix of the dataset using the Covarance
% matrix you just calculated. Hint: look at the diag() function.
% Corr = ...;

% Plot covariance
figure(102);
clf;
subplot(1,2,1);
imagesc(Cov);
axis image;
colorbar;
set(gca, 'xTick', 1:size(countrydata, 1));
set(gca, 'xTickLabel', VarNames);
set(gca, 'xTickLabelRotation', 45);
set(gca, 'yTick', 1:size(countrydata, 1));
set(gca, 'yTickLabel', VarNames);
title('Covariance');

% Plot correlation
subplot(1,2,2);
imagesc(Corr, [-1 1]);
axis image;
colorbar;
set(gca, 'xTick', 1:size(countrydata, 1));
set(gca, 'xTickLabel', VarNames);
set(gca, 'xTickLabelRotation', 45);
set(gca, 'yTick', 1:size(countrydata, 1));
set(gca, 'yTickLabel', VarNames);
title('Correlation');

%% Eigenvalues and eigenvectors
%  Calculate the eigenvalues and coresponding eigenvectors of the
%  correlation matrix. The calculation and plot is already implemented, but
%  you will analyze the results.

[E, L] = sorteig(Corr);

% Plot actual eigenvalues
figure(103);
clf;
subplot(1,3,1);
stem(L, 'LineWidth', 2);
set(gca, 'xtick', 1:size(countrydata, 1));
title('Eigenvalues (sorted)');
axis square;

% Plot scaled eigenvalues
subplot(1,3,2);
stem(L / sum(L) * 100, 'LineWidth', 2);
set(gca, 'xTick', 1:size(countrydata, 1));
ylim([0,100]);
ylabel('% of information');
title('Percent information in each principle direction');
axis square;

% Plot cumulative sum
subplot(1,3,3);
stem(cumsum(L / sum(L) * 100), 'LineWidth', 2);
set(gca, 'xTick', 1:size(countrydata, 1));
ylim([0,100]);
ylabel('% of total information');
title('Cumulative information when using first n principle components');
axis square;

%% Principle Components
%  Now we transform the data to principle component space and plot the
%  result.

% Project data onto 2D space of first two principle components
% PC1 = ...; % PC1 is scaledData projected to first PC
% PC2 = ...; % PC2 is scaledData projected to second PC

% Plot projections
figure(104);
hold on;
scatter(PC1(countryclass == 1), PC2(countryclass == 1), 400, '.r');
scatter(PC1(countryclass == 2), PC2(countryclass == 2), 400, '.k');
scatter(PC1(countryclass == 3), PC2(countryclass == 3), 400, '.b');
grid on;
box on;
xlabel('Principle direction 1');
ylabel('Principle direction 2');
title({'Projection onto first two PCs', ...
       'Remember that this plot still has more than 70% of the information in the original data, but is actually understandable!'});
legend(ClassNames, 'Location', 'northeastoutside');

%% Linear Discriminant Analysis
%  In this section you will only work with class 1 (developing countries)
%  and class 3 (industrial countries). You will use LDA to find the
%  direction of optimal separation, and analyze the results.

% Get data for class 0 and class 2
X1 = scaledData(:, countryclass == 1);
X3 = scaledData(:, countryclass == 3);

% Number of samples in each class
N1 = size(X1, 2);
N3 = size(X3, 2);

% Calculate the covariance matrix for class 1 and class 3 separatly, and
% their sum
% C1 = ...;
% C3 = ...;
% Ctot = ...;

% Calculate the direction of maximal separation of the two classes.
% Normalize the vector to length 1.
% W = ...;
% W = W / ...;

% Calculate projections onto W for the two classes
% XP1 = ...; X1 projected onto W
% XP3 = ...; X3 projected onto W

% Plot projection onto W
figure(105);
clf;
subplot(1,3,1);
hold on;
plot(XP1, 0, 'r.', 'MarkerSize', 30);
plot(XP3, 0, 'b.', 'MarkerSize', 30);
title({'Projection onto vector obtained by LDA', ''});
xlabel('Value when projecting onto W');
yticklabels([]);
yticks([]);
axis image;
ylim([-eps,eps]);
xlim([-0.5,0.5]);
box on;

% Separate in y-direction to make it more clear (still projection onto w)
subplot(1,3,2);
hold on;
plot(XP1, find(countryclass == 1), 'r.', 'MarkerSize', 30);
plot(XP3, find(countryclass == 3), 'b.', 'MarkerSize', 30);
title({'This is the same as the first plot,', ...
       'only separated in y-direction to improve visibility'});
xlabel('Value when projecting onto W');
ylabel('Country number in dataset');
xlim([-0.5,0.5]);
ylim([0,110]);
axis square;
box on;

% Plot w, shows importance of features for separation
subplot(1,3,3);
stem(W, 'LineWidth', 2);
title('Importance of features for separating Class 1 and 3');
ylabel('Size of W in each feature direction');
set(gca, 'xTick', 1:size(countrydata, 1));
set(gca, 'xTickLabel', VarNames);
set(gca, 'xTickLabelRotation', 45);
axis square;
box on;
grid on;
