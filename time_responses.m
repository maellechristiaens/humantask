function[fig] = time_responses(stimuli)
touched= stimuli(find(~cellfun('isempty', stimuli(:,12))),:);

react_times = zeros(1, 12);
phases = [30 40 60 70];

for k=1:length(touched)
    for j=1:4
        if touched{k,9} == phases(j) && touched{k,11} == 0
            react_times(end+1,(j*3)-2) = touched{k,10};
            react_times(end+1,(3*j)-1) = touched{k,10};
        elseif touched{k,9} == phases(j) && touched{k,11} ~= 0
            react_times(end+1,(j*3)-2) = touched{k,10};
            react_times(end+1,3*j) = touched{k,10};
        end
    end
end


react_times(react_times == 0) = missing;
react_times = rmoutliers(react_times);
fig = figure('Position', [20 40 1200 600]);
colors = {[0.9290 0.6940 0.1250]; [0.9290 0.6940 0.1250];[0.9290 0.6940 0.1250];[0.8500 0.3250 0.0980]; [0.8500 0.3250 0.0980];[0.8500 0.3250 0.0980];[0 0.4470 0.7410]; [0 0.4470 0.7410];[0 0.4470 0.7410];[0.4940 0.1840 0.5560];[0.4940 0.1840 0.5560];[0.4940 0.1840 0.5560]}; 
names = {'All trials'; 'Successful trials'; 'Error trials'; 'All trials'; 'Successful trials'; 'Error trials'; 'All trials'; 'Successful trials'; 'Error trials'; 'All trials'; 'Successful trials'; 'Error trials'};
b = boxplot(react_times, 'Labels', names);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(length(h)-j +1),'XData'),get(h(length(h)-j+1),'YData'),colors{j},'FaceAlpha',.5);
end
title('Distribution of the reaction times across phases')



