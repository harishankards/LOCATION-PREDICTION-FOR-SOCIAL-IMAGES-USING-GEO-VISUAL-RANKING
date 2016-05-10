function predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats)
categories = unique(train_labels); 
num_categories = length(categories);

lambda = 0.001;

labels = zeros(1,size(train_image_feats,1));
labels = labels - 1;

svmB = zeros(1,num_categories);
svmW = zeros(size(train_image_feats,2),num_categories);
predicted_categories = cell(size(test_image_feats,1),1);
fprintf('training svm...\n\n\n');
t_train_image_feats = train_image_feats';
for c = 1:num_categories
	matching_indices = strcmp(categories(c),train_labels);
	clabels= labels;
	for i = 1:size(matching_indices,1)
		if matching_indices(i)==1
            clabels(i) = 1;
        end
	end
	[W, B] = vl_svmtrain(t_train_image_feats,clabels,lambda);	
	svmW(:,c) = W;
	svmB(1,c) = B;
end
fprintf('finished training svm!\n\n')

fprintf('svm predicting location...\n\n');


for k = 1:size(test_image_feats)
    feature = test_image_feats(k,:);
    feature = feature';
    confidences = zeros(1,num_categories);
    for c=1:num_categories
        confidences(1,c) = dot(feature,svmW(:,c))+svmB(1,c);
    end
    [maxi, index] = max(confidences,[],2);
    predicted_categories(k,1) = categories(index);
end
%if predicted_categories(lambda)<-1 AND predicted_categories(lambda)>1
 %   fprintf('inappropriate image')
%end
    fprintf('svm done!\n\n\n');
fprintf('Locations are being extracted from candidate images...\n\n')