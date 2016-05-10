
function image_feats = get_bags_of_sifts(image_paths)

load('vocab.mat')
vocab_size = size(vocab, 1);
t_vocab = vocab';
step_size = 4;
image_feats = zeros(size(image_paths,1),vocab_size);
%%
for i = 1:size(image_paths,1)
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

 
