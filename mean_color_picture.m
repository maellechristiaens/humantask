function[fig] = mean_color_picture(stimuli)
stimuli = stimuli(~any(cellfun('isempty', stimuli(:,8)), 2), :);

cd C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic\human_task_mc\Figures_control\Pictures
means_all = zeros(length(stimuli), 6);
means_test = zeros(length(stimuli), 6);
for i=1:length(stimuli)
    picture_presented = imread(stimuli{i,1});
    picture_clicked = imread(stimuli{i, 8});
    for j=1:3
        means_all(i,(j*2)-1) = mean(mean(picture_presented(:,:,j)));
        means_all(i,j*2) = mean(mean(picture_clicked(:,:,j)));
    end 
end

means_test = means_all(find(~cellfun('isempty', stimuli(:,12))),:);

colors ={'r'; 'r'; 'g'; 'g'; 'c'; 'c'};
names = {'Presented'; 'Clicked on'; 'Presented'; 'Clicked on'; 'Presented'; 'Clicked on'};

fig = figure('Position', [20 40 1200 600]);
t = tiledlayout(1,2);
title(t, 'Comparison of the colors of the pictures presented and clicked on')
nexttile
boxplot(means_all, 'Labels', names)
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(length(h)-j +1),'XData'),get(h(length(h)-j+1),'YData'),colors{j},'FaceAlpha',.5);
end
title('All trials')
nexttile
boxplot(means_test, 'Labels', names)
h2 = findobj(gca,'Tag','Box');
for j=1:length(h2)
    patch(get(h2(length(h2)-j +1),'XData'),get(h2(length(h2)-j+1),'YData'),colors{j},'FaceAlpha',.5);
end
title('Only test trials')

cd C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic\human_task_mc