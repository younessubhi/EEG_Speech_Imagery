clear all; close all; clc;

% load data
load('W_t_struct.mat')
load('W_t.mat')

subjs = W_t_struct;

i = 1;

% divide to first three & last three// CSP

while i < 18;
    subj{i} = subjs{i, 1};
    subj_first{i} = subj{i}(:,1:3);
    subj_last{i} = subj{i}(:,4:6);
    i = i + 1;
end

a = horzcat(subj_first{:})

% topoplot

for II = 1:51
    subplot(17,3,II)
    topoplot(a(:,II),'channel_locations.loc');
end

%subj_first = subj_first';
%subj_last = subj_last';


% % topoplot
% for p = 1:17
%     plotthis = subj_first{p}
%     figure
%         for II = 1:3
%         subplot(1,3,II)
%         topoplot(plotthis(:,II),'channel_locations.loc');
%         end
% end