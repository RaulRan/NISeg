function graph = build_graph(im)
%% Build graph on image
% Input:
%   im: RGB image
% Output:
%   graph: [4*H*W, 3] each row is [pointA_idx, pointB_idx, AB_diff]


% Get image size
[H, W, ~] = size(im);
im8 = im/255;
if isa(im, 'uint8') % cast uint8 to double
    im = double(im);
end

% graph = zeros(4*H*W-2*H-2*W+2, 3);  
% note that after the iteration, there will be same edges not be assigned
% TODO: eliminate these edges

% Cambie las lineas...
% HSV = rgb2hsv(im/255);
% im = HSV(:,:,1)*255;
lab = rgb2lab(im8);
L = lab(:,:,1)./100;
a = lab(:,:,2);
b = lab(:,:,3);
L = L*255;
ar = max(a,0)./50*255;
% ar = ar.*L;
av = min(a,0).*-1./50*255;
% av = av.*L;
bam = max(b,0)./50*255;
% bam = bam.*L;
baz = min(b,0).*-1./50*255;
% baz = baz.*L;

im(:,:,1) = ar; 
im(:,:,2) = av;
im(:,:,3) = bam;
im(:,:,4) = baz;
im(:,:,5) = L;

% ...Hasta aqu�

graph = zeros(2*(H-1)*(W-1)+(H-1)*W+(W-1)*H, 3);
cnt = 1;
fprintf('building graph...\n')
for w = 1:W
    for h = 1:H
        idx = (w-1)*H + h;   % current point index
        point = im(h, w, :); % corrent point color
        point = point(:);    % reshape to 1 column
        
        if h < H
            idx_d = idx + 1;    % down point
            point_d = im(h+1, w, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_d;
            graph(cnt, 3) = norm(point-point_d(:));    % Euclidean distance
            cnt = cnt + 1;
        end
        
        if w < W
            idx_r = idx + H;    % right point
            point_r = im(h, w+1, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_r;
            graph(cnt, 3) = norm(point-point_r(:));
            cnt = cnt + 1;
        end
        
        if h < H && w < W
            idx_rd = idx + H + 1;    % right-down point
            point_rd = im(h+1, w+1, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_rd;
            graph(cnt, 3) = norm(point-point_rd(:));
            cnt = cnt + 1;
        end
        
        if h > 1 && w < W
            idx_ru = idx + H - 1;    % right-up point
            point_ru = im(h-1, w+1, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_ru;
            graph(cnt, 3) = norm(point-point_ru(:));
            cnt = cnt + 1;
        end
    end
end
fprintf('done!\n')

% fprintf('%d\n%d', cnt, 4*H*W)



