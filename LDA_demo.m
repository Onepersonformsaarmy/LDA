% A demo to LDA(Linear Discriminant Analysis)
% include a figure to discribe it

% Note:the demo data is watermelon_3.0_alpha.csv
% Liu Jingchang 2016/3/9
% log:

%% get the coefficients of LDA
% get data
data = csvread('.\watermelon_3.0_alpha.csv',1,1);

% get positive and negative class
y = data(:,end);
positive_class = data(find(y==1),1:end-1);
negative_class = data(find(y==0),1:end-1);

% get the average vector of each class
mu_1 = mean(positive_class);
mu_0 = mean(negative_class);

% get the between-class scatter matrix
S_b = (mu_0-mu_1)' * (mu_0-mu_1);

% get the within-class scatter matrix
% get the within-class scatter matrix of positive class
temp1 = size(positive_class);
n = temp1(1);
mu_0_repmat = repmat(mu_0,n,1);
delta_0 = (positive_class - mu_0_repmat)' * (positive_class - mu_0_repmat);

% get the within-class scatter matrix of negative class
temp2 = size(positive_class);
n = temp2(1);
mu_1_repmat = repmat(mu_1,n,1);
delta_1 = (positive_class - mu_1_repmat)' * (positive_class - mu_1_repmat);
%
S_w = delta_0 + delta_1;

% get the eigrnvalue of (S_w)^-1 * S_b
eig_value = sort(eig(inv(S_w)*S_b),'descend')

%% figure to discrobe LDA
% plot the scateer in different style to distinguish class
plot(positive_class(:,1),positive_class(:,2),'r+',...
    negative_class(:,1),negative_class(:,2),'y*')
hold on

% plot the line of LDA
t = 0:0.01:1;
plot(t,eig_value(1:end-1)'*t)