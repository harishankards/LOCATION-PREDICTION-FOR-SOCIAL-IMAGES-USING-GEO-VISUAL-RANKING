
function vocab = build_vocabulary( image_paths, vocab_size )
%%
step = 16;
all_features = zeros(128,1);
for i = 1:size(image_paths,1)
    r3 = randi(10,1,1);
    if r3 > 5
        image = imread(char(image_paths(i,1)));
        if size(image,3)==3
            image = rgb2gray(image);
        end
        g_image = single(image);
        [locations, sift_features] = vl_dsift(g_image,'step',step,'fast');
        all_features = [all_features sift_features];
    end
end
%%
all_features = all_features(:,2:end);
all_features = double(all_features);
[centers, assignments] = vl_kmeans(all_features, vocab_size);
vocab = centers';
