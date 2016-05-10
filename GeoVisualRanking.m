run('C:\Users\Harishankar Ayandev\Documents\vlfeat-0.9.20\toolbox\vl_setup')

data_path = 'C:\Users\Harishankar Ayandev\OneDrive\Academics\FYP\Implementation\GVR\Dataset\Arranged';


categories = {'ArcDeTriomphe', 'EiffelTower', 'LesInvalides', 'NotreDame', ...
              'OperaGarnier', 'PalaisDuLouvre', 'Pantheon', 'SacreCouer'};
          
abbr_categories = {'Arc', 'Eif', 'Les', 'Not', 'Ope', 'Pal', 'Pan', 'Sac'};


num_categories = length(categories);

fprintf('Getting paths and labels for all train and test data...\n')


num_train_per_cat=50;

train_image_paths = cell(num_categories * num_train_per_cat, 1);
test_image_path  = 'C:\Users\Harishankar Ayandev\OneDrive\Academics\FYP\Implementation\GVR\Dataset\Arranged\test\test.jpg'


train_labels = cell(num_categories * num_train_per_cat, 1);
test_labels  = cell(num_categories * num_train_per_cat, 1);


for i=1:num_categories
   images = dir( fullfile(data_path, 'train', categories{i}, '*.jpg'));
   for j=1:num_train_per_cat
       train_image_paths{(i-1)*num_train_per_cat + j} = fullfile(data_path, 'train', categories{i}, images(j).name);
       train_labels{(i-1)*num_train_per_cat + j} = categories{i};
   end
   
  
end



fprintf('Using bag of sifts representation for images...\n')
% YOU CODE build_vocabulary.m
if ~exist('vocab.mat', 'file')
    fprintf('No existing visual word vocabulary found. Computing one from training images...\n')
    vocab_size = 400; 
    vocab = build_vocabulary(train_image_paths, vocab_size);
    save('vocab.mat', 'vocab')
end

% YOU CODE get_bags_of_sifts.m

image_paths = train_image_paths;

load('vocab.mat')
vocab_size = size(vocab, 1);
t_vocab = vocab';
step_size = 4;
image_feats = zeros(size(image_paths,1),vocab_size);
%%
for i = 1:(size(image_paths,1))
    image = imread(char(image_paths(i,1)));
    if size(image,3)==3
        image = rgb2gray(image);
    end
    g_image = single(image);
    [locations, sift_features] = vl_dsift(g_image,'step',step_size,'fast');
    sift_features = double(sift_features);
    distances = vl_alldist2(sift_features,t_vocab);
    [minimum, indices] = min(distances,[],2);
    histo = zeros(1,vocab_size);
    for k = 1:size(indices,1)
        nearest_cluster_center = uint16(indices(k,1));
        histo(1,nearest_cluster_center) = histo(1,nearest_cluster_center)+1;
    end
    histo = double(histo)./double(max(histo, [], 2));
    image_feats(i,:) = histo;
    
end

train_image_feats=image_feats;


%bag of sifts for test image
image_paths=test_image_path;
load('vocab.mat')
vocab_size = size(vocab, 1);
t_vocab = vocab';
step_size = 4;
image_feats = zeros(size(image_paths,1),vocab_size);
%%
for i = 1:size(image_paths,1)
    image = imread(char(image_paths));
    if size(image,3)==3
        image = rgb2gray(image);
    end
    g_image = single(image);
    [locations, sift_features] = vl_dsift(g_image,'step',step_size,'fast');
    sift_features = double(sift_features);
    distances = vl_alldist2(sift_features,t_vocab);
    [minimum, indices] = min(distances,[],2);
    histo = zeros(1,vocab_size);
    for k = 1:size(indices,1)
        nearest_cluster_center = uint16(indices(k,1));
        histo(1,nearest_cluster_center) = histo(1,nearest_cluster_center)+1;
    end
    histo = double(histo)./double(max(histo, [], 2));
    image_feats(i,:) = histo;
end

test_image_feats=image_feats;
fprintf('Using SVM classifier to predict test image category...\n')    

predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats);
 
fprintf('Computing geo-visual ranking...\n\n')

predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats);
fprintf('Geo-visual ranking done!\n\n')

fprintf(' The predicted location is:')
disp(predicted_categories)
