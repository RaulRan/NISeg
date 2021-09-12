
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

min_size = 600;
sigma = 0.8;
c = 0.9;

Bb = kGabor;
n = 4;

bin = 32;
escala = 0.6; 

opticFlow = opticalFlowLK('NoiseThreshold',0.0009);

MyFolderInfo = dir(Folder);

for j = 1:(numel(MyFolderInfo)-2)
D = [Folder,MyFolderInfo(j+2).name,'\'];
S = dir(fullfile(D,'*.jpg'));
for k = 1:numel(S)
filename = fullfile(D,S(k).name);
clear M I;
if k == 1 

im1  = imread(filename);


Lab = rgb2lab(im1);
a = Lab(:,:,2);
b = Lab(:,:,3);
L = Lab(:,:,1)./100;

[gMag,~] = CeNNGabor(L,Bb,n);
thres = 2*mean(gMag(:));
thres = -1*(-1+thres);
K = c*thres*min_size*c;

[ret_img1] = segmentacion(im1,sigma,K,min_size,escala);
ret_img1 = imresize(ret_img1, size(L), 'nearest');
ret_img = ret_img1;
values1 = histo(ret_img1, a, b, bin);

flow = estimateFlow(opticFlow,L); 

else 

im2  = imread(filename);

Lab = rgb2lab(im2);
a = Lab(:,:,2);
b = Lab(:,:,3);
L = Lab(:,:,1)./100;


[gMag,~] = CeNNGabor(L,Bb,n);
thres = 2*mean(gMag(:));
thres = -1*(-1+thres);
K = c*thres*min_size;

[ret_img2] = segmentacion(im2,sigma,K,min_size,escala);
if escala ~= 1
ret_img2 = imresize(ret_img2, size(L), 'nearest');
end
values2 = histo(ret_img2, a, b, bin);

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

if mov(jj) < 0.6 
temp2 = ret_img1.*temp;
[~,~,v] = find(temp2);
mod = mode(v);
ret_img3 = ret_img3+temp.*mod; 
end
temp = zeros(size(temp));
end

dist = zeros(size(values1,1),size(values2,1));
for jj = 1:size(values1,1)
for jjj = 1:size(values2,1)
dist(jj,jjj) = norm(values1(jj,:)-values2(jjj,:)); 
end
end
[M,I] = min(dist,[],1);

count = max(ret_img1(:)) + 1;
for jj = unique(ret_img2)'
[rows, cols] = find(ret_img2 == jj);
ind = sub2ind(size(ret_img2),rows,cols);
if mov(jj) >= 0.6
    
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

% Code to save segmentation for posterior evaluation
% level = 1;
% segs{level}= Uintconv(ret_img);   
% newStr = S(k).name;
% deleteMe = isletter(newStr); 
% newStr(deleteMe) = []; 
% save(['.\BenchmarkBseg\Evaluation\Algorithm_Bseg\Ucm2\',MyFolderInfo(j+2).name,'\image',newStr,'mat'],'segs');
end
reset(opticFlow)
end
%% Código para realizar la evaluación y obtener las curvas precision-recall
% 
% %Include the benchmark code into the Matlab path
% path(path,'BenchmarkBseg');
% path(path,['BenchmarkBseg',filesep,'Benchmark']);
% path(path,['BenchmarkBseg',filesep,'Benchmark',filesep,'Auxbenchmark']);
% addpath(genpath('BenchmarkBseg'));
% 
% 
% %Use the command Computerpimvid computes the Precision-Recall curves
% benchmarkpath = '.\BenchmarkBseg\Evaluation\'; %The directory where all results directory are contained
% benchmarkdir = 'Algorithm_BSeg'; %One the computed results set up for benchmark, here the output of the algorithm of Ochs and Brox (Ucm2 folder) set up for the general benchmark (Images and Groundtruth folders)
% requestdelconf=true; %boolean which allows overwriting without prompting a message. By default the user is input for deletion of previous calculations
% nthresh=51; %Number of hierarchical levels to include when benchmarking image segmentation
% superposegraph=false; %When false a new graph is initialized, otherwise the new curves are added to the graph
% testtemporalconsistency=true; %this option is set to false for testing image segmentation algorithms
% bmetrics={'bdry','regpr','sc','pri','vi','lengthsncl','all'}; %which benchmark metrics to compute:
%                                             %'bdry' BPR, 'regpr' VPR, 'sc' SC, 'pri' PRI, 'vi' VI, 'all' computes all available
% 
% output=Computerpimvid(benchmarkpath,nthresh,benchmarkdir,requestdelconf,0,'r',superposegraph,testtemporalconsistency,'all');
% %The otuput contains the PR values in corresponding fields
% %Outputs are written into a Output folder inside the benchmarkdir folder

