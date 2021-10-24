%% Take input of bar mechanical/thermal info
% Author(s):
%  - Dr. Kendall Hunter (assumed)
% Dependancies:
%  - None

function [bar] = model_input ()
    bar.NElem = input('Total # of elements? ');
    bar.initT = input('Initial Temperature? ');
    bar.Nistp = input('Number of integration steps? ');

    for i = 1: 1: bar.NElem
        prompt = sprintf('Bar Element #%2d', i);
        bar.Area1(i) = input([prompt ' area near end = ']);
        bar.Area2(i) = input([prompt ' area far end  = ']);
        bar.Leng(i) = input([prompt ' length = ']);
        bar.Modu1(i) = input([prompt ' modulus near end = ']);
        bar.Modu2(i) = input([prompt ' modulus far end  = ']);
        bar.Alph(i) = input([prompt ' alpha = ']);
        bar.DeltT(i) = input([prompt ' Final Temperature = ']);
        if i == 1
            bar.EndGap = input([prompt ' end gap = ']);
        end
        if i > 1
            bar.EndLoad(i) = input([prompt ' end load = ']);
        else
            bar.EndLoad(1) = 0;
        end
    end

    yn = input('Save model to .mat file? (y/n) ','s');
    if strcmpi(yn,'y')
        name = input('Input model name (no trailing .mat): ','s');
        name = [name '.mat'];
        save (name, 'bar');
    end

end
