function [train_image_paths, test_image_path] = ... 
    get_image_paths(data_path, categories, num_train_per_cat)
num_categories = length(categories); 

train_image_paths = cell(num_categories * num_train_per_cat, 1);
test_image_path  = 'C:\Users\Harishankar Ayandev\OneDrive\Academics\FYP\Implementation\GVR\Dataset\Arranged\test\03.jpg'

train_labels = cell(num_categories * num_train_per_cat, 1);
test_labels  = cell(num_categories * num_train_per_cat, 1);

for i=1:num_categories
   images = dir( fullfile(data_path,'train',categories{i},'*.jpg'));
   for j=1:num_train_per_cat
       train_image_paths{(i-1)*num_train_per_cat + j} = fullfile(data_path, 'train', categories{i}, images(j).name);
       train_labels{(i-1)*num_train_per_cat + j} = categories{i};
   end
   
  
end