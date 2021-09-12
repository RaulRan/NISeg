
function [ret_img] = segmentacion(im,sigma,K,min_size,escala)
% sigma = 0.8;
% K = 400;
% min_size = 500;
color = 0;

[m,n,~] = size(im);
im2 = imresize(im, escala); 
im2 = double(im2);

[H, W, ~] = size(im2);
num_nodes = H*W;

% imshow(uint8(im2))
% figure

im2 = filter_image(im2, sigma);
% imshow(uint8(im2))

graph = build_graph(im2);
[uf, sorted_graph] = segment_graph(graph, num_nodes, K);
[uf, sorted_graph] = remove_small_components(uf, sorted_graph, min_size);
[ret_img] = build_seg_image(uf, H, W, color);
count = 1;
for j = unique(ret_img)'
[rows, cols] = find(ret_img == j);
ind = sub2ind(size(ret_img),rows,cols);
ret_img(ind) = count;
count = count + 1;
end
% figure
% ret_img = imresize(ret_img, 2, 'nearest');
% imshow(ret_img,[])
numseg = uf.count
end