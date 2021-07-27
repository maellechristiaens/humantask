function[fig] = show_pictures(stimuli)
cd C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic\human_task_mc\Figures_control\Pictures

fig = figure('Position', [20 40 1200 600]);
t = tiledlayout(1,2);
nexttile(t)
s = tiledlayout(t, 2,2);
nexttile(s,[1 2])
imshow(stimuli{1,1})
axis off
hold on
for i=2:3
    nexttile(s)
    imshow(stimuli{i,1})
    axis off
end
hold off

nexttile(t)
s = tiledlayout(t, 2,2);
nexttile(s,[1 2])
imshow(stimuli{1,1})
hold on
for i=2:3
    nexttile(s)
    imshow(stimuli{i,1})
end
hold off