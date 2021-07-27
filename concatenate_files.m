function[all] = concatenate_files()
cd C:\Users\maell\Documents\ENS\Cours\Césure\Stage_Sliwa\MonkeyLogic\human_task_mc\Figures_control
d = dir;
all = {};
for k = 3:length(d)
    if ~isequal(d(k).name, 'Pictures')
        cd(d(k).name)
        fichier = dir('*.mat');
        f = load(fichier.name);
        f = f.stimuli;
        all = [all; f];
        cd ..
    end
end
save allfiles.mat all