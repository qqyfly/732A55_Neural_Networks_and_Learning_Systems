classdef KernelSVM < matlab.System
    
    % Generic implementation of a Kernel-SVM classifier.
    %
    % Supports configurable number of iterations and saves state between
    % training runs. This allows animating the training by running a few
    % steps, ploting the predictions, then repeating.
    %
    % Supports precalculating the Kernel-matrix for increased training
    % speed. This requires that the Kernel-matrix can fit in memory.
    %
    % Supports any arbitrary kernel so long as it can calculate a
    % similarity measure between two vectors in the input space.
    % The kernel should be a struct with the fields
    %   'func', a function for calculating the similarity matrix
    %   'canMatrix', a bool indicating if the 'func' supports matrix inputs
    % A kernel func that supports matrix inputs should return the complete
    % distance matrix (Gram matrix) in one call. This improves the speed of
    % training and prediction immensly and is highly recommended.
    %
    % Supports configurable slack regularization 'C', and optimization
    % tolerance 'tol'. Also supports configurable pruning tolerance for
    % support vectors, 'support_vector_tol'.
    %
    % Based on:
    % http://emilemathieu.fr/blog_svm.html
    
    properties (Access = public)
        kernel
        C = 1
        max_iter = 1000
        tol = 0.01
        support_vector_tol = 0.001;
        verbose = false
    end
    
    properties (Access = private)
        intercept_
        dual_coef_
        support_vectors_
        support_vector_indices_
        alpha_ = nan
        g_ = nan
        KMat_ = nan
    end
    
    methods (Access = public)
        function obj = KernelSVM(varargin)
            setProperties(obj, nargin, varargin{:});
        end
        
        function [obj, tol_reached] = fit(obj, X, y)
            [obj, lagrange_multipliers, intercept, tol_reached] = obj.compute_weights(X, y);
            obj.intercept_ = intercept; % Bias
            support_vector_indices = lagrange_multipliers > obj.support_vector_tol;
            if (nnz(support_vector_indices) < 2)
                [~, idx] = maxk(lagrange_multipliers,2);
                support_vector_indices(idx) = true;
            end
            obj.dual_coef_ = lagrange_multipliers(support_vector_indices) .* y(support_vector_indices); % Alpha
            obj.support_vectors_ = X(support_vector_indices,:);
            obj.support_vector_indices_ = support_vector_indices;
        end
        
        function [prediction, dist_score] = predict(obj, X)
            kernel_support_vectors = obj.compute_kernel_support_vectors(X);
            dist_score = obj.intercept_ + kernel_support_vectors * obj.dual_coef_;
            prediction = sign(dist_score);
        end
        
        function acc = score(obj, X, y)
            % Compute proportion of correct classifications given true labels
            predictions = obj.predict(X);
            scores = (predictions == y);
            acc = mean(scores);
        end
        
        function [svs, svs_i] = get_support_vectors(obj)
            svs = obj.support_vectors_;
            svs_i = obj.support_vector_indices_;
        end
        
        function obj = precompute_kernel_matrix(obj, X)
            if (obj.kernel.canMatrix)
                obj.KMat_ = obj.kernel.func(X,X);
            else
                for i = 1:size(X,1)
                    for j = 1:size(X,1)
                        obj.KMat_(i,j) = obj.kernel.func(X(i,:), X(j,:));
                    end
                end
            end
        end
        
        function obj = clear_kernel_matrix(obj)
            obj.KMat_ = nan;
        end
    end
    
    % --------------------------------------------------------------------
    
    methods (Access = private)
        function res = compute_kernel_support_vectors(obj, X)
            if (obj.kernel.canMatrix)
                res = obj.kernel.func(X, obj.support_vectors_);
            else
                res = zeros(size(X,1), size(obj.support_vectors_, 1));
                for i = 1:size(X,1)
                    for j = 1:size(obj.support_vectors_,1)
                        res(i,j) = obj.kernel.func(X(i,:), obj.support_vectors_(j,:));
                    end
                end
            end
        end
        
        function row = get_kernel_matrix_row(obj, X, index)
            if ~isnan(obj.KMat_)
                row = obj.KMat_(index,:);
            else
                if (obj.kernel.canMatrix)
                    row = obj.kernel.func(X(index,:), X);
                else
                    row = nan(1,size(X,1));
                    for j = 1:size(X,1)
                        row(j) = obj.kernel.func(X(index,:), X(j,:));
                    end
                end
            end
        end
        
        function intercept = compute_intercept(obj, alpha, yg)
            indices = (alpha < obj.C) & (alpha > 0);
            intercept = mean(yg(indices));
        end
        
        function [obj, alpha, intercept, tol_reached] = compute_weights(obj, X, y)
            iteration = 0;
            n_samples = size(X,1);
            
            if isnan(obj.alpha_)
                alpha = zeros(n_samples,1);
                g = ones(n_samples,1);
            else
                alpha = obj.alpha_;
                g = obj.g_;
            end
            
            while true
                yg = g .* y;
                
                % Working set selection via maximum violating contraints
                indices_y_positive = (y ==  1);
                indices_y_negative = (y == -1);
                indices_alpha_upper = (alpha >= obj.C);
                indices_alpha_lower = (alpha <= 0);
                
                indices_violate_Bi = (indices_y_positive & indices_alpha_upper) | (indices_y_negative & indices_alpha_lower);
                yg_i = yg;
                yg_i(indices_violate_Bi) = -inf; % Cannot select violating indices
                indices_violate_Ai = (indices_y_positive & indices_alpha_lower) | (indices_y_negative & indices_alpha_upper);
                yg_j = yg;
                yg_j(indices_violate_Ai) = inf; % Cannot select violating indices
                
                [~,i] = max(yg_i);
                [~,j] = min(yg_j);
                
                % Stopping criterion: stationary point or maximum iterations
                stop_criterion = yg_i(i) - yg_j(j) <= obj.tol;
                if (stop_criterion | (iteration >= obj.max_iter))
                    break;
                end
                
                % Compute lambda via Newton Method and constraints projection
                lambda_max_1 = (y(i) ==  1) * obj.C - y(i) * alpha(i);
                lambda_max_2 = (y(j) == -1) * obj.C + y(j) * alpha(j);
                lambda_max = min([lambda_max_1, lambda_max_2]);
                
                Ki = obj.get_kernel_matrix_row(X,i);
                Kj = obj.get_kernel_matrix_row(X,j);
                lambda_plus = (yg_i(i) - yg_j(j)) / (Ki(i) + Kj(j) - 2 * Ki(j));
                lambda_param = max([0, min(lambda_max, lambda_plus)]);
                
                % Update gradient
                g = g + lambda_param * y .* (Kj - Ki)';
                
                % Direction search update
                alpha(i) = alpha(i) + y(i) * lambda_param;
                alpha(j) = alpha(j) - y(j) * lambda_param;
                
                iteration = iteration + 1;
            end
            
            % Save g and alpha for next fit
            obj.alpha_ = alpha;
            obj.g_ = g;
            
            intercept = obj.compute_intercept(alpha, yg);
            
            if (obj.verbose)
                if (stop_criterion)
                    fprintf('Tolerance met, %i iterations for gradient acsent\n', iteration);
                else
                    fprintf('%i iterations for gradient acsent\n', iteration);
                end
            end
            
            tol_reached = stop_criterion;
        end
    end
end

