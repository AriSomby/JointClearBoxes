clear all;
close all; clc;
participants = [212 213 214 215];%[201 202 203 204 205 206 207 208 211];

%Conditions:
% Individual = 1
% Joint = 2
% Choice = 3  in Choice trials: 1=Individual, 2=Joint
for p = participants;

filename = ['JointClearingBoxes_' num2str(p) '.xlsx'];
readtable(filename); data = table2array(ans);ans=[];
filenamed = ['JointClearingBoxesDData_' num2str(p) '.xlsx'];
readtable(filenamed); ddata = table2array(ans);ans=[];

%variables_headers for Pair data
participant_data = data(data(:,1)==p,:);
condition = data(:,2);choice = data(:,3);
num_of_patches = data(:,4);trial = data(:,5);
touch_time = data(:,7);Acc = data(:,9);Asynch = data(:,10);

%variables_headers for Decision data
conditiond = ddata(:,2); choiced = ddata(:,3);
num_of_patchesd = ddata(:,4);triald = ddata(:,5);
decisionTime = ddata(:,6);

%# of touches x Joint NO Choice
%NOchoice_Joint = data(data(:,2)==2 & data(:,3)==2,:);
%# of touches x Joint Choice
%choice_Joint = data(data(:,2)==3 & data(:,3)==2,:);

%# of touces x Individual NO Choice
%NOchoice_Individual = data(data(:,2)==1 & data(:,3)==1,:);
%# of touces x Individual Choice
%choice_Individual = data(data(:,2)==3 & data(:,3)==1,:);

all_trials_duration =[];
for t = 1:180
    trial_time=[];
    %average asynch x trial
    curr_trial = data(trial==t,7);curr_asynch = data(trial==t,10);
    curr_Acc = data(trial==t,9); ave_asynch = mean(curr_asynch(curr_Acc==1),1);
    %number of actions x trial
    num_of_actions = size(data(trial==t & data(:,1)==p,1));
    num_of_actions = num_of_actions(1);
    %trial duration ordering rows x touchtime
    S = sortrows(data,7); trial_time=S(S(:,5)==t,:);
    trial_duration = trial_time(end,7)-trial_time(1,7);
    
    %saving line x trial with all info
    trial_line = [p t conditiond(t) choiced(t) num_of_patchesd(t) num_of_actions trial_duration ave_asynch decisionTime(t)];
    all_trials_duration = [all_trials_duration;trial_line];
end
save(['all_trials_duration_' num2str(p)]); 
end
