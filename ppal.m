
addpath(genpath('BenchmarkBseg'),genpath('Video_examples'));
clear all; clc; close all;

choice = menu('Choose an option','Video example','Load video','Exit');
switch choice
    case 1
        Folder = '.\Video_examples\Video_example_1\';
    case 2
        Folder = [uigetdir,'\'];
    otherwise
        error ('Exit succesfully')
end

min_size = 600; % Parameter with minimum components
sigma = 0.8; % Sigma parameter for the coherency gaussian filter
c = 0.9; % Factor to adjust the value of k

Bb = kGabor; % Gabor filters
n = 4; % Number of filters

bin = 32; % Number of intervals of the color histogram
escala = 0.6; 

opticFlow = opticalFlowLK('NoiseThreshold',0.0009);

MyFolderInfo = dir(Folder);

%Cycle for the folders

for j = 1:(numel(MyFolderInfo)-2)
D = [Folder,MyFolderInfo(j+2).name,'\'];
S = dir(fullfile(D,'*.jpg'));
for k = 1:numel(S)
filename = fullfile(D,S(k).name);
clear M I;
if k == 1 

%%% Retina
im1  = imread(filename);

%%% Lateral geniculate nucleus
Lab = rgb2lab(im1);
a = Lab(:,:,2);
b = Lab(:,:,3);
L = Lab(:,:,1)./100;

%%% Visual areas V1 and V2
%Edges: for the calculation of the parameter k
[gMag,~] = CeNNGabor(L,Bb,n);
thres = 2*mean(gMag(:));
thres = -1*(-1+thres);
K = c*thres*min_size*c;

% Color: for the obtainment of the histograms
[ret_img1] = segmentacion(im1,sigma,K,min_size,escala);
ret_img1 = imresize(ret_img1, size(L), 'nearest');
ret_img = ret_img1;
values1 = histo(ret_img1, a, b, bin);
% Movement
flow = estimateFlow(opticFlow,L); 

else % Second image and subsequents

%%% Retina
im2  = imread(filename);

%%% LGN
Lab = rgb2lab(im2);
a = Lab(:,:,2);
b = Lab(:,:,3);
L = Lab(:,:,1)./100;

% Edges: for the calculation of the parameter k
[gMag,~] = CeNNGabor(L,Bb,n);
thres = 2*mean(gMag(:));
thres = -1*(-1+thres);
K = c*thres*min_size;

% Color: for the obtainment of the histograms
[ret_img2] = segmentacion(im2,sigma,K,min_size,escala);
if escala ~= 1
ret_img2 = imresize(ret_img2, size(L), 'nearest');
end
values2 = histo(ret_img2, a, b, bin);

% Movement
flow = estimateFlow(opticFlow,L); 
ofMag2 = flow.Magnitude;
bwofMag2 = imbinarize(ofMag2,0.01);

temp = zeros(size(ret_img2));
ret_img3 = zeros(size(ret_img2));
mov = zeros(max(ret_img2(:)),1);
for jj = unique(ret_img2)'
[rows, cols] = find(ret_img2 == jj);
ind = sub2ind(size(ret_img2),rows,cols);
temp(ind) = 1;
imprueba2 = bwofMag2.*temp;
mov(jj) = sum(imprueba2(:))/sum(temp(:));

% Check if the movement is greater than 50%
if mov(jj) < 0.6 
temp2 = ret_img1.*temp;
[~,~,v] = find(temp2);
mod = mode(v);
ret_img3 = ret_img3+temp.*mod; % Match regions that have more intersection
end
temp = zeros(size(temp));
end

% Match of regions by their histograms
dist = zeros(size(values1,1),size(values2,1));
for jj = 1:size(values1,1)
for jjj = 1:size(values2,1)
dist(jj,jjj) = norm(values1(jj,:)-values2(jjj,:)); 
end
end
[M,I] = min(dist,[],1);

% Rewrite tags
count = max(ret_img1(:)) + 1;
for jj = unique(ret_img2)'
[rows, cols] = find(ret_img2 == jj);
ind = sub2ind(size(ret_img2),rows,cols);
if mov(jj) >= 0.6

% If there is not much resemblance to the histograms it is a new segment
if M(jj) > 0.4
ret_img3(ind) = count;
count = count + 1;
else
ret_img3(ind) = I(jj);
end
end
end
values1 = values2;
ret_img1 = ret_img3;
ret_img = ret_img3;

end

% figure
if k == 1
subplot 121, imshow(im1);
else
subplot 121, imshow(im2);
end
subplot 122, imshow(label2rgb(ret_img));
pause(0.01);

% Uncomment to save segmentation for posterior evaluation
% level = 1;
% segs{level}= Uintconv(ret_img);   
% newStr = S(k).name;
% deleteMe = isletter(newStr); 
% newStr(deleteMe) = []; 
% save(['.\BenchmarkBseg\Evaluation\Algorithm_Bseg\Ucm2\',MyFolderInfo(j+2).name,'\image',newStr,'mat'],'segs');
end
reset(opticFlow)
end

