clc; clear all;close all;

load cameg_multipletrialconn


display('1: Delta');
display('2: Theta');
display('3: Alpha');
display('4: Beta');
in  = input('surface visualisation (1-4):');

% Conn mat
Conn  = cat(3,edge{:,in});

St = zeros(size(Conn,1),size(Conn,2));
for i = 1: size(Conn,1)
    for j = 1: size(Conn,2)
        for k = 1: size(Conn,3)
            tmp(k)  = Conn(i,j,k);
        end
        [h,p,ci,stats] = ttest(tmp);
        St(i,j) = stats.tstat;
        St(i,j) = p;
    end
end
figure,imagesc(St);colorbar