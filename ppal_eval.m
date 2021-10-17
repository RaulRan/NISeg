
%% Code to evaluate and obtain the precision-recall curves 

%Include the benchmark code into the Matlab path
path(path,'BenchmarkBseg');
path(path,['BenchmarkBseg',filesep,'Benchmark']);
path(path,['BenchmarkBseg',filesep,'Benchmark',filesep,'Auxbenchmark']);
addpath(genpath('BenchmarkBseg'));


%Use the command Computerpimvid computes the Precision-Recall curves
benchmarkpath = '.\BenchmarkBseg\Evaluation\'; %The directory where all results directory are contained
benchmarkdir = 'Algorithm_BSeg'; %One the computed results set up for benchmark, here the output of the algorithm of Ochs and Brox (Ucm2 folder) set up for the general benchmark (Images and Groundtruth folders)
requestdelconf=true; %boolean which allows overwriting without prompting a message. By default the user is input for deletion of previous calculations
nthresh=51; %Number of hierarchical levels to include when benchmarking image segmentation
superposegraph=false; %When false a new graph is initialized, otherwise the new curves are added to the graph
testtemporalconsistency=true; %this option is set to false for testing image segmentation algorithms
bmetrics={'bdry','regpr','sc','pri','vi','lengthsncl','all'}; %which benchmark metrics to compute:
                                            %'bdry' BPR, 'regpr' VPR, 'sc' SC, 'pri' PRI, 'vi' VI, 'all' computes all available

output=Computerpimvid(benchmarkpath,nthresh,benchmarkdir,requestdelconf,0,'r',superposegraph,testtemporalconsistency,'all');
%The otuput contains the PR values in corresponding fields
%Outputs are written into a Output folder inside the benchmarkdir folder

