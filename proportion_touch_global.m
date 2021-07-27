function[fig] = proportion_touch_global(data)
positions=[0 0 0 0 0;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0];
positions_normalised = [0 0 0 0 0; 0 0 0 0 0];
data = data(~any(cellfun('isempty', data(:,3)), 2), :);
test = data(find([data{:,9}] == 40 | [data{:,9}] == 70),:);

squares = [8 15 3 9 ; 8 15 -8 -3; -15 -8 -8 -3; -15 -8 3 9; -3 3 -3 3];

for i=1:length(data)
    for j=1:5
        if squares(j,1)<data{i,7}(1) && data{i,7}(1)<squares(j,2) && squares(j,3)<data{i,7}(2) && data{i,7}(2)<squares(j,4)
            positions(1,j) = positions(1,j) + 1;
        end
        if squares(j,1)<data{i,4}(1) && data{i,4}(1)<squares(j,2) && squares(j,3)<data{i,4}(2) && data{i,4}(2)<squares(j,4)
            positions(2,j) = positions(2,j) + 1;
        end 
    end
end 

for i=1:length(test)
    for j=1:5
        if squares(j,1)<test{i,7}(1) && test{i,7}(1)<squares(j,2) && squares(j,3)<test{i,7}(2) && test{i,7}(2)<squares(j,4)
            positions(3,j) = positions(3,j) + 1;
        end
        if squares(j,1)<test{i,4}(1) && test{i,4}(1)<squares(j,2) && squares(j,3)<test{i,4}(2) && test{i,4}(2)<squares(j,4)
            positions(4,j) = positions(4,j) + 1;
        end
    end
end

fig = figure('Position', [20 40 1200 600]);
t = tiledlayout(2,1);
title(t, 'Positions of touches and presentations during all phases of the task')
nexttile
names = categorical({'top right', 'bottom right', 'bottom left', 'top left','middle'});
names = reordercats(names, {'top right', 'bottom right', 'bottom left', 'top left','middle'});
prop = bar(names,positions, 'FaceColor', 'flat');
prop(1).CData = [0.86 0.5 0.11];
prop(2).CData = [0.86 0.5 0.11];
prop(2).FaceAlpha = 0.5;
prop(3).CData = [0.25 0.3 0.65];
prop(4).CData = [0.25 0.3 0.65];
prop(4).FaceAlpha = 0.5;
lgd = legend('Learning touch', 'Learning presentation', 'Test touch', 'Test presentation');
lgd.Location = 'northeastoutside';
title('Number of presentations and touches at each position')

for i = 1:5
    positions_normalised(1,i) = positions(1, i)/positions(2,i);
    positions_normalised(2,i) = positions(3, i)/positions(4,i);
end

nexttile 
prop_normalised = bar(names,positions_normalised, 'FaceColor', 'flat');
prop_normalised(1).CData = [0.86 0.5 0.11];
prop_normalised(2).CData = [0.25 0.3 0.65];
lgd = legend('Learning', 'Test');
lgd.Location = 'northeastoutside';
title('Proportion of touches compared to presentations at each position')
    
    