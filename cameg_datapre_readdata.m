function cameg_datapre_readdata()
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
disp('Reading source data ...')

if nargin == 0
    files = spm_select(1,'.mat','Select source MEG files');
end

load(files);

fs = input('Enter sampling frequency e.g. 1200 [Hz]: ');

L = length(Atlas.Scouts);

for i = 1:L
    roi{i}= Atlas.Scouts(i).Region;
    roi_l{i}= Atlas.Scouts(i).Label;
end

Value = Value(1:L,:);

figure, 
hl = plot(Time, Value(1:L,:));
xlabel('Time(s)');
ylabel('Amplitude(AU)');
title('source activities');
for i = 1:L, lab{i} = num2str(i); end
clickableLegend(hl,lab, 'plotOptions', {'MarkerSize', 6});
set(gcf, 'Position', [800   100   1200   800]);

B = num2cell(1:L);
ROI = (cell2table([B;roi;roi_l]'))

% pause
%% Segmenting data
fs = size(Value,2);
in = input('Segment data (yes = 1)?');

if in ==1
    seg = input('Set time intervals e.g., [300,700] ms: ');

    f1 = knnsearch(Time',seg(1)/1e3);
    f2 = knnsearch(Time',seg(2)/1e3);
    
    Value = Value(:,f1:f2);
    Time  = Time(:,f1:f2);
    
%     Value = Value(:,floor(seg(1)*fs./1000):floor(seg(2)*fs./1000));
%     Time  = Time(:,floor(seg(1)*fs./1000):floor(seg(2)*fs./1000));
end

clf, 
hl = plot(Time, Value);
xlabel('Time(s)');
ylabel('Amplitude(AU)');
title('source activities');
clickableLegend(hl,lab, 'plotOptions', {'MarkerSize', 6});
set(gcf, 'Position', [800   100   1200   800]);


save cameg_datafile files Value Time ROI fs

disp('Data was imported!')