clear all; close all; clc;

% load data
load('W_t_struct.mat')
load('W_t.mat')

subjs = W_t_struct;

i = 1;

% divide to first three & last three// CSP

while i < 18;
    subj{i} = subjs{i, 1};
    subj_1{i} = subj{i}(:,1);
    subj_2{i} = subj{i}(:,2);
    subj_3{i} = subj{i}(:,3);
    subj_4{i} = subj{i}(:,4);
    subj_5{i} = subj{i}(:,5);
    subj_6{i} = subj{i}(:,6);
    i = i + 1;
end

% topoplot

a1 = horzcat(subj_1{:})

figure(1)
for II = 1:17
    subplot(3,6,II)
    topoplot(a1(:,II),'channel_locations.loc');
end

a2 = horzcat(subj_2{:})

figure(2)
for II = 1:17
    subplot(3,6,II)
    topoplot(a2(:,II),'channel_locations.loc');
end


a3 = horzcat(subj_3{:})

figure(3)
for II = 1:17
    subplot(3,6,II)
    topoplot(a3(:,II),'channel_locations.loc');
end


a4 = horzcat(subj_4{:})

figure(4)
for II = 1:17
    subplot(3,6,II)
    topoplot(a4(:,II),'channel_locations.loc');
end


figure(5)
a5 = horzcat(subj_5{:})

for II = 1:17
    subplot(3,6,II)
    topoplot(a5(:,II),'channel_locations.loc');
end


figure(6)
a6 = horzcat(subj_6{:})

for II = 1:17
    subplot(3,6,II)
    topoplot(a6(:,II),'channel_locations.loc');
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