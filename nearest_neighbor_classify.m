
function predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats)

N = size(test_image_feats,1);
predicted_categories = train_labels;
trans_train = train_image_feats';
trans_test = test_image_feats';

    %Simple Nearest Neighbour
    Distances = vl_alldist2(trans_test,trans_train);
    [min_value, index] = min(Distances, [], 2);
    for i = 1:N
        predicted_categories(i,1) = train_labels(uint16(index(i)),1);
    end
    disp('1 nn done');
end
%%
