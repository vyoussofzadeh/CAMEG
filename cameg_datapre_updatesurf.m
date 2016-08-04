function cameg_datapre_updatesurf(cp)
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
disp('Updating surface data ...')

load cameg_surffile

c = cp';

node = strcat(num2str([newPosMNI,m,c,L]),d);
node(:,end-4:end-3) = char(' ');
dlmwrite('node.node',node,'delimiter','');


disp('Surface file was updated!')