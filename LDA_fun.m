function omega = LDA_fun(s,m,n)
% to get the coefficients of LDA

% Example:
%   LDA_fun(file.csv,m,n)
%   file.csv: 'string',name of the input .csv file
%   m,n: numeric,the row and col to read data

% Liu jingchang     2016/3/9

% log:

% get data
data = csvread(s,m,n);

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
eig_value = sort(eig(inv(S_w)*S_b),'descend');
omega = eig_value(1:end-1);

end

