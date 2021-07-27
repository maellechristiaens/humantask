function[fig] = plot_touch(stimuli)
touched = stimuli(~any(cellfun('isempty', stimuli(:,3)), 2), :);

fig = figure('Position', [20 40 1200 600]);
plot(touched{1,7}(1), touched{1,7}(2), '*','MarkerEdgeColor', [0.9290 0.6940 0.1250])
hold on
for i=2:length(touched)
    p = plot(touched{i,7}(1), touched{i,7}(2), '*');
    if touched{i,9} == 30
        p.MarkerEdgeColor = [0.9290 0.6940 0.1250];
    elseif touched{i,9} == 40
        p.MarkerEdgeColor = [0 0.4470 0.7410];
    elseif touched{i,9} == 60
        p.MarkerEdgeColor = [0.8500 0.3250 0.0980];
    elseif touched{i,9} == 70
        p.MarkerEdgeColor = [0.4940 0.1840 0.5560];
    end
end
title('Position of touches on the screen')
axis padded
hold off