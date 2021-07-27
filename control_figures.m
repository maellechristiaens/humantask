function[] = control_figures(name_file)
addpath 'C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic'
addpath 'C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic\human_task_mc'
cd C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic\human_task_mc
s = regexp(name_file, '_');
e = regexp(name_file, '.bhv2');
name = name_file(s(end)+1:e-1); 
mkdir(strcat('Figures_control\', name))
copyfile(name_file, strcat('Figures_control\', name))
cd(strcat('Figures_control\', name))
stimuli = get_stimuli_presented(name_file, 1);
where_touch = plot_touch(stimuli);
saveas(where_touch, strcat('plot_touch_', name, '.png'))
%time_trials = time_between_trials(stimuli);
%saveas(time_trials, strcat('time_between_trials_', name, '.png'))
touches_global = proportion_touch_global(stimuli);
saveas(touches_global, strcat('proportions_of_touch_global_', name, '.png'))
touches_test = proportion_touch(stimuli);
saveas(touches_test, strcat('proportions_of_touch_only_test_', name, '.png'))
reaction_times_global = plot_reaction_time_global(stimuli);
saveas(reaction_times_global, strcat('reaction_times_global_', name, '.png'))
reaction_times_test = plot_reaction_time(stimuli);
saveas(reaction_times_test, strcat('reaction_times_only_test_', name, '.png'))
times_errors = comparison_errors(stimuli);
saveas(times_errors, strcat('comparison_reaction_times_error_non_error_', name, '.png'))
repartition_errors = plot_errors(stimuli);
saveas(repartition_errors, strcat('errors_', name, '.png'))
whisker_times = time_responses(stimuli);
saveas(whisker_times, strcat('whisker_plot_time_response_', name, '.png'))
comparison_color = mean_color_picture(stimuli);
cd(strcat('Figures_control\', name))
saveas(comparison_color, strcat('comparison_mean_colors_in_pictures_', name, '.png'))


cd C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic\human_task_mc