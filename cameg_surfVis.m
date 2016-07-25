function cameg_surfVis()
% ___________________________________________________________________________
% Connectivity analysis of MEG data (CA-MEG)
%
% Copyright 2016 Cincinnati Children's Hospital Medical Center
% Reference 
% 
% 
% v1.0 Vahab Youssofzadeh 21/07/2016
% email: Vahab.Youssofzadeh@cchmc.org
% ___________________________________________________________________________
load('cameg_meshfile');
Mesh = files;
Node = 'node.node';
Edge = 'edge.edge';

load cameg_datafile
A

% load cameg_matfile
% plot_conn(edge,roi, 'thresholded conn');

BrainNet_MapCfg(Mesh,Node,Edge);
view([0 -90 0])