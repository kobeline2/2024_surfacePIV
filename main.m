%%
init
%% ind
% 1{'VelocityU[mm/s]'           }
% 2{'VelocityV[mm/s]'           }
%  {'VelocityW[mm/s]'           } NOT READ
% 3{'Correlation coefficient'   }
%  {'AveY'                      } NOT READ
%  {'Standard Deviation'        } NOT READ
%  {'Valid Flag'                } NOT READ


%% read csv
% fn = "dat/per1sec/dat0001.csv";
dirPath = '/Volumes/tk_main/selflining/PIV/case1_1/before/inner/csv';
% [d, coordX, coordY, columnNames] = readFlownizerCsv(fn); % signle csv
[d, Meta] = readFlowNizerCsvSeq(dirPath); % sequential csv

%% specify time
% When the interval is n sec, T(1) shoud be (0+n)/2.
fps = 1/300;
T = fps/2:fps:length(d)*fps; length(T) 
Meta.time = T';

%% view data
ind = 6;
viewMovie(dValid, 2, Meta)
viewVector(d, Meta, false, 0.5)

%% check mean vector
d = d; Meta = Meta;
meanV = nanmean(d, 4);
viewVector(meanV, Meta, false, 1);

%% resampling
% d2 を T1 にリサンプリング
[d2, Meta2] = resampleVector(d2, Meta2, d1, Meta1);
viewVector(d2, Meta2, false)

%% Merge two data
dMerge = mergeCsv(d1, d2, Meta1);
viewVector(dMerge, Meta2, false)

%% make new entities
% d = dMerge(:, :, :, 1:end-1);
Meta = Meta1;
TH_CORR = 0.8;
DO_INTERP = true;

dValid = interpVector(d, TH_CORR, DO_INTERP);
viewVector(dValid, Meta, false)


