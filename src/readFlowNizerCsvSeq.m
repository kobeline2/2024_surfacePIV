function [d, Meta] = readFlowNizerCsvSeq(dirPath)

COL_LIST = [6, 7, 9]; % 6:u, 7:v, 9:corr

dirPath = fullfile(dirPath, '*.csv');
fnList = dir(dirPath);
fnList = fnList(~startsWith({fnList.name}, '.'));

N = length(fnList);

% I = 1 (this treatment is for parfor)
fn = fullfile(fnList(1).folder, fnList(1).name);
[tmp, coordX, coordY, ~] = readFlownizerCsv(fn);
d = zeros(length(coordX), length(coordY), length(COL_LIST), N); 
d(:, :, :, 1) = tmp(:, :, COL_LIST);

% I > 2
parfor I = 2:N
    fn = fullfile(fnList(I).folder, fnList(I).name);
    tmp = readFlownizerCsv(fn);
    d(:, :, :, I) = tmp(:, :, COL_LIST);
    if mod(I, 100) == 0; fprintf("%d / %d finised \n", I, N); end
end
Meta = struct("coordX", coordX, "coordY", coordY);
end