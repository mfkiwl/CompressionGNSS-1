%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Users\scorr\Clouds\Dropbox\01 - ESTGP\2019_20\2� SEMESTRE\10 - Projecto\06 - Rafael Perez\01 - PRafael\01 - Dados\04 - Simulacao\03 - AnalisadorLZ77\01 - Compactados\Resultados\resultadosNMEAmD_30pts_ZigZag1.csv
%
% Auto-generated by MATLAB on 21-Jan-2021 20:41:35

function Graph(f)

pf = strcat(pwd,'\',f,'.csv')

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "OriginalSize", "LZ77Size", "LOOK_AHEAD", "SEARCH_SIZE"];
opts.SelectedVariableNames = ["OriginalSize", "LZ77Size", "LOOK_AHEAD", "SEARCH_SIZE"];
opts.VariableTypes = ["string", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");

% Import the data
rst = readtable(pf, opts);

%% Convert to output type
rst = table2array(rst);

%% Clear temporary variables
clear opts

x = 10:1:99;
y = 10:1:99;
[X,Y] = meshgrid(x,y);
Z = [];
L = length(y);

for i=1:length(x)
    ii = i-1;
    A = rst(1+ii*L:L+ii*L,1);
    B = rst(1+ii*L:L+ii*L,2);
    Z(:,i) = B./A;
end

h = surf(X,Y,Z);
xlabel('LookAhead');
ylabel('Search Size');
zlabel('Compression Rate');
%zlim([0.7 1.4]);

hf = strcat(f,'.png');

saveas(h,hf)