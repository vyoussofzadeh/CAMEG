function cameg_conn_psi()
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
disp('Connectivity measure, PSI ...')

load cameg_datafile
% load(files)

%% Connectivity analysis
cfg.method = 'psi';
% parameters for PSI-calculation
% fs = 1200;
fs = size(Value,2);
epleng = [];

fq = input('Enter frequency range [1,30]:');

freqs= fq(1):fq(2);
% [psi, stdpsi, psisum, stdpsisum]=data2psi(Value',segleng,epleng,freqs);
[psi, stdpsi, ~, ~] = data2psi(Value',fs,epleng,freqs);
n = length(psi);

% note, psi, as calculated by data2psi corresponds to \hat{\PSI}
% in the paper, i.e., it is not normalized. The final is
% the normalized version given by:
npsi = abs(psi./(stdpsi+eps));

% for i = 1:n
%     roi{i}= Atlas.Scouts(i).Region;
%     roi_l{i}= Atlas.Scouts(i).Label;
% end

% figure, 
% hl = plot(Time, Value);
% xlabel('Time(s)');
% ylabel('Amplitude(AU)');
% title('source activities');
% clickableLegend(hl,roi, 'plotOptions', {'MarkerSize', 6});
% set(gcf, 'Position', [800   100   1200   800]);

plot_conn(npsi,roi, 'npsi');
set(gcf, 'Position', [800   100   800   700]);
% save cameg_npsi npsi psi

in = input('Thresholding (yes = 1)?');

if in ==1
    thre = input('Set the threshold: ');
    edge = npsi > thre;
    plot_conn(edge,roi, 'thresholded npsi');
    set(gcf, 'Position', [800   100   800   700]);
else
    edge = npsi;
end
dlmwrite('edge.edge',edge,'\t');
save cameg_matfile edge roi

disp('(thresholded or org) connectivity matrix was saved!')