function fig = CAMEG()
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
clc, close all

display('your current working path is,')
cd

display('Please change your path to the CAMEG directory for convenience!')

r = 50;
col = [0.6020 0.8072 0.6014];
h0 = figure(...
'Color',[1 1 1], ...
	'PaperPosition',[18 180 576 432], ...
	'PaperUnits','points', ...
	'Position',[50 250 390 280], ...
	'Tag','Main', ...
    'NumberTitle','off', ...
    'DoubleBuffer','on', ...
    'Visible','on', ...	
    'NumberTitle','off',...
	'Name','ToolBox : CA-MEG v.1', ...
    'ToolBar','none');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',col, ...
	'Position',[72 85+r 166 16], ...
	'String','Data prepration', ...
	'CallBack','cameg_datapre;');
h2 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',col, ...
	'Position',[72 60+r 166 16], ...
	'String','Compute & plot connectivity', ...
	'CallBack','cameg_conn;');
h3 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',col, ...
	'Position',[72 35+r 166 16], ...
	'String','Surface visualisation', ...
	'CallBack','cameg_surfVis');
h4 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',col, ...
	'Position',[72 10+r 166 16], ...
	'String','Data visualisation', ...
	'CallBack','cameg_DataVis');
h5 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',col, ...
	'Position',[72 r-15 166 16], ...
	'String','Close', ...
	'CallBack','delete(gcf)'); 
h6 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',11, ...
	'ListboxTop',0, ...
	'Position',[16 100+r 280 36], ...
	'String',['                      CA-MEG                           ';
              '      (Connectivity analysis of MEG data)              '], ...
	'Style','text', ...
	'Tag','StaticText5');
if nargout > 0, fig = h0; end