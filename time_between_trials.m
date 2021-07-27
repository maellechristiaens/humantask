function[p] = time_between_trials(data)
figure;
p = plot(0, 0);
hold on
for i=1:(length(data)-1)
    t1 = data(i+1).AbsoluteTrialStartTime;
    t2 = data(i).AbsoluteTrialStartTime + data(i).BehavioralCodes.CodeTimes(end);
    p = plot(i, t1-t2, '*');
end
hold off
