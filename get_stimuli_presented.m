function[stimuli] = get_stimuli_presented(name_file,saving)
addpath 'C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic' %to get the mlread function
data = mlread(name_file); %read the .bhv2 file
stimuli = cell(length(data), 14); %create a cell array that will be filed up with all the informations needed from the bhv2 file
for i=1:length(data) %for each row of the file (ie each trial)
    stimuli{i,11} = data(i).TrialError ; %store the type of error of each trial 
    if ismember(data(i).BehavioralCodes.CodeNumbers(3), [20 30 40 50 60 70]) %only look at the trials where pictures are displayed
        when = round(data(i).BehavioralCodes.CodeTimes(4)); %store the time when the computer detected the subject touched an image on the screen
        stimuli{i,7} = data(i).AnalogData.Touch(1, :); %initialisation of where the subject touched (to NaN values)
        for k = when-150:when %look in a 100ms window before the time the computer detected the touch
            if ~isnan(data(i).AnalogData.Touch(k,1)) %if the subject indeed touched the screen
                stimuli{i,7} = data(i).AnalogData.Touch(k, :); %store the position of the last touch
            end
        end
        stimuli{i,9} = data(i).BehavioralCodes.CodeNumbers(3);
        stimuli{i,10} = data(i).BehavioralCodes.CodeTimes(4)-data(i).BehavioralCodes.CodeTimes(3);
        h_low = stimuli{i,7}(1) - 3;
        h_high = stimuli{i,7}(1) + 3;
        l_low = stimuli{i,7}(2) - 3;
        l_high = stimuli{i,7}(2) + 3;
        if ismember(data(i).BehavioralCodes.CodeNumbers(3), [30 40 60 70])
            for j=1:3
                stimuli{i,j} = data(i).ObjectStatusRecord.SceneParam(4).AdapterArgs{1, 1}{1, 1}.AdapterArgs{1, 1}{1, j}.AdapterArgs{1, 2}{5, 2}{1};
                stimuli{i,3+j} = data(i).ObjectStatusRecord.SceneParam(4).AdapterArgs{1, 1}{1, 1}.AdapterArgs{1, 1}{1, j}.AdapterArgs{1, 2}{5, 2}{2};
                if (h_low<stimuli{i,3+j}(1)&&stimuli{i,3+j}(1)<h_high)&&(l_low<stimuli{i,3+j}(2)&&stimuli{i,3+j}(2)<l_high)
                    stimuli{i,8} = stimuli{i,j};
                end
            end
        else
            stimuli{i,1} = data(i).ObjectStatusRecord.SceneParam(4).AdapterArgs{1, 1}{1, 1}.AdapterArgs{1, 2}{5, 2}{1};  
            stimuli{i,2} = data(i).ObjectStatusRecord.SceneParam(4).AdapterArgs{1, 1}{1, 1}.AdapterArgs{1, 2}{5, 2}{2}; 
        end
    end
end

stimuli = stimuli(~any(cellfun('isempty', stimuli(:,2)), 2), :);
start_new_cond = find(cellfun('isempty', stimuli(:,3)));
start_test1 = find([stimuli{:,9}] == 40);
start_test2 = find([stimuli{:,9}] == 70);

while ~isempty(start_test1)
    start_new_cond = start_new_cond(start_new_cond > start_test1(1));
    for i = start_test1(1):start_new_cond(1)-1 
        stimuli{i,12} = 'Test1';
    end
    start_test1 = start_test1(start_test1 > start_new_cond(1));
end

while ~isempty(start_test2)
    start_new_cond = start_new_cond(start_new_cond > start_test2(1));
    if isempty(start_new_cond)
        start_new_cond = length(stimuli);
    end
    for i = start_test2(1):start_new_cond(1)-1 
        stimuli{i,12} = 'Test2';
    end
    start_test2 = start_test2(start_test2 > start_new_cond(1));
end
stimuli{end,12} = 'Test2';

change=[1];
for i=1:length(stimuli)-1
    if ~isequal(stimuli{i,12}, stimuli{i+1,12})
        change(end+1) = i+1;
    end
end
change(end+1) = length(stimuli);
nb_conditions = (length(change)-1)/4;

for i = 1:nb_conditions
    for j = change(i*2-1):change(i*2+1)
        stimuli{j,13} = i;
    end
    for k = change(nb_conditions*2 + i*2-1):change(nb_conditions*2 + i*2+1)
        stimuli{k,13} = i;
    end
end
        
if saving
    s = regexp(name_file, '_');
    e = regexp(name_file, '.bhv2');
    name = name_file(s(end)+1:e-1); 
    save(strcat('stimuli_', name, '.mat'), 'stimuli')
end