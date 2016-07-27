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

for i = 1:size(Value,1)
    roi{i}= Atlas.Scouts(i).Region;
    roi_l{i}= Atlas.Scouts(i).Label;
end

figure, 
hl = plot(Time, Value);
xlabel('Time(s)');
ylabel('Amplitude(AU)');
title('source activities');
clickableLegend(hl,roi, 'plotOptions', {'MarkerSize', 6});
set(gcf, 'Position', [800   100   1200   800]);
% pause
%% Segmenting data
fs = size(Value,2);
in = input('Segment data (yes = 1)?');

if in ==1
    seg = input('Set time intervals e.g., [300,700] ms: ');
    Value = Value(:,floor(seg(1)*fs./1000):floor(seg(2)*fs./1000));
    Time = Time(:,floor(seg(1)*fs./1000):floor(seg(2)*fs./1000));
    
    % Upsampling
%     nValue = resample(Value1',fs,length(Value1))';
% %     y = interp1(Value1',Value');
%     nTime = resample(Time1',fs,length(Time1))';
% y = upsample(x,n)
end

clf, 
hl = plot(Time, Value);
xlabel('Time(s)');
ylabel('Amplitude(AU)');
title('source activities');
clickableLegend(hl,roi, 'plotOptions', {'MarkerSize', 6});
set(gcf, 'Position', [800   100   1200   800]);

A = (cell2table([roi;roi_l]'))

save cameg_datafile files A Value Time roi fs

disp('Data was imported!')