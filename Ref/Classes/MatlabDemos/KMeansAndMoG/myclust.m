%% k-Means Prototype
%  -----------------
% (Only for demo purposes!)
% For the interested reader: Allow for more prototypes

close all
clear all

N=100;
X1=mvnrnd([-1 0],[0 1]*[0 1]'+0.001*eye(2),N)';
X2=mvnrnd([1 0],[0 1]*[0 1]'+0.001*eye(2),N)';
X = [X1 X2]; %More complicated dataset
%X = [-1 -1 -1 1 1 1; -1 0 1 -1 0 1]; %Simple dataset


%p = [-0.5 0.5; 0 0];
p = [1 1; 0.5 -0.5];

figure(1);
for cnt=1:20
   %Just plot stuff
   plot(X(1,:),X(2,:),'kx')
   axis([-3 3 -3 3]);hold on;
   plot(p(1,1),p(2,1),'ro')
   plot(p(1,2),p(2,2),'go')
   hold off;
   
   %Find nearest prototype! (Phase 1)
   [D,I] = pdist2(p',X','euclidean','Smallest',1);
   ind1 = (I==1); %Cluster 1
   ind2 = (I==2); %Cluster 2
   pause(0.1);
    
   %Just plot stuff
   plot(X(1,ind1),X(2,ind1),'rx')
   axis([-3 3 -3 3]);hold on;
   plot(X(1,ind2),X(2,ind2),'gx')
   plot(p(1,1),p(2,1),'ro')
   plot(p(1,2),p(2,2),'go')
   pause(0.1);
   
   %Calc new prototypes(Phase 2)
   p(:,1) = mean(X(:,ind1),2);
   p(:,2) = mean(X(:,ind2),2);
   
   %Just plot stuff
   plot(p(1,1),p(2,1),'ro')
   plot(p(1,2),p(2,2),'go')
   hold off;
   pause(0.1);
end
