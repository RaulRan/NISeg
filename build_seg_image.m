function [ret_img] = build_seg_image(uf, H, W, color)
% save result image
num_nodes = H*W;
color_map = uint8(randi([0, 255], num_nodes, 3));
if color == 1
ret_img = zeros(H, W, 3, 'uint8');
else
ret_img = zeros(H, W);
end
for w = 1:W
    for h = 1:H
        id = uf.find_id((w-1)*H+h);
        if color == 1
        ret_img(h, w, :) = reshape(color_map(id, :), [1,1,3]);
        else
        ret_img(h, w) = id;
        end    
    end
end
end