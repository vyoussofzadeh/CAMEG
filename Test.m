
clear all;close all; clc;

TimefreqFile = spm_select(1,'.mat','Select source MEG files');

load(TimefreqFile);

TF = process_compress_sym('Expand', TF, length(RowNames));

TF1 = reshape(TF, sqrt(size(TF,1)),sqrt(size(TF,1)),size(TF,3));

figure,
for i = 1:length(Freqs)
    tmp = squeeze(TF1(:,:,i));
    subplot(2,2,i)
    plot_conn(tmp,[], 'npsi'); title(Freqs(i,1))
end
Freqs

figure,
load('cameg_meshfile');
Mesh = files;
Node = 'node.node';
Edge = 'edge.edge';
for i = 1:length(Freqs)
    tmp = squeeze(TF1(:,:,i));
    edge{i} = tmp > 0.9;
    subplot(2,2,i)
    plot_conn(edge{i},[], 'npsi'); title(Freqs(i,1));
end

display('1: Delta');
display('2: Theta');
display('3: Alpha');
display('4: Beta');
in  = input('surface visualisation (1-4):');
dlmwrite('edge.edge',edge{in},'\t');
figure,
BrainNet_MapCfg(Mesh,Node,Edge);title(Freqs(in,1));
view([0 -90 0])