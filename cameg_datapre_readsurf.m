function cameg_datapre_readsurf()
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
disp('Reading surface data ...')

if nargin == 0
    files = spm_select(1,'.mat','Select surface file');
end

load(files);
% load(files);
save cameg_surffile files

%%
load cameg_mrifile
load(files);

sMri.Voxsize = Voxsize;
sMri.SCS = SCS;
sMri.NCS = NCS;

for i=1:length(Atlas)
    Atlasa{i} = Atlas(i).Name;
end
cell2table(Atlasa)
sel = input('Select an atlas consistant with the data file (e.g. 1-6)?');
At = Atlas(sel);

% ROI coordinates
for i = 1:length(At.Scouts)
    A = At.Scouts(i).Seed;
    L{i,:} = At.Scouts(i).Region;
    newPosScs = Vertices(A,:);
    newPosVox = round(cs_convert(sMri, 'scs', 'voxel', newPosScs));
    newPosMNI(i,:) = round((1e3.*cs_convert(sMri, 'voxel', 'mni', newPosVox)),1);
end

% Vertex color: modular information
m = ones(length(At.Scouts),1);

% Vertex size: centrality, T-value, etc information
c = ones(length(At.Scouts),1);

% Vertex label
L = zeros(length(At.Scouts),1);

load cameg_datafile

tmp = char(A.Var1);
node = strcat(num2str([newPosMNI,m,c,L]),tmp);
node(:,end-4:end-3) = char(' ');
dlmwrite('node.node',node,'delimiter','');


disp('Surface file was imported!')


%% junk
% nnode = [num2cell([newPosMNI,m,c,L]),tmp];
% nnnode = nnode{:,:};
% node = table2struct(cell2table([num2cell([newPosMNI,m,c,L]),tmp]));
% B = char(tmp);
% fid=fopen('Node_AAL90.node','r');
% s = '';
% while ~feof(fid)
%    line = fgetl(fid);
%    if isempty(line), break, end
%    s = strvcat(s,line);
% end
% s1 = s(1:length(At.Scouts),:);
% s1(2,1:6) = newPosMNI(1,1);
% 
% dlmwrite('test.node',s,'delimiter','');
% 
% 
% node = [newPosMNI,m,c,L];


% cell2struct

% xlswrite(node,node)
% dlmwrite(node.,M,'-append')
% % save filname.edge node -ascii
% % writetable(node,'node.txt');
% % dlmwrite('node.txt',node);
% % dlmwrite('node.node',node, ';');
% 
% 
% fid = fopen('edge.edge', 'w') ;
% fprintf(fid, '%s,', node{1,1:end-1}) ;6
% fprintf(fid, '%s\n', node{1,end}) ;
% fclose(fid) ;
% dlmwrite('node.node', node(2:end,:), '-append') ;


% dlmwrite('node.node',node,' ');
% dlmwrite('node.node', node, '-append') ;