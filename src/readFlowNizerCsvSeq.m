function [d, Meta] = readFlowNizerCsvSeq(dirPath)

COL_LIST = [6, 7, 9]; % 6:u, 7:v, 9:corr

dirPath = fullfile(dirPath, '*.csv');
fnList = dir(dirPath);
fnList = fnList(~startsWith({fnList.name}, '.'));

N = length(fnList);

for I = 1:N
    fn = fullfile(fnList(I).folder, fnList(I).name);
    if I ~= 1
        tmp = readFlownizerCsv(fn);
    else
        [tmp, coordX, coordY, ~] = readFlownizerCsv(fn);
        d = zeros(length(coordX), length(coordY), length(COL_LIST), N);        
    end
    d(:, :, :, I) = tmp(:, :, COL_LIST);
end
Meta = struct("coordX", coordX, "coordY", coordY);
end