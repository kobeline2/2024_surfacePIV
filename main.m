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
dirPath = 'dat/per4sec';
% [d, coordX, coordY, columnNames] = readFlownizerCsv(fn); % signle csv
[d, Meta] = readFlowNizerCsvSeq(dirPath); % sequential csv

%% specify time
% When the interval is n sec, T(1) shoud be (0+n)/2.
T = 2:4:65; length(T) 
T = 0.5:1:67; length(T) 
Meta1.time = T';

%% view data
ind = 6;
viewMovie(dValid, 2, Meta)
viewVector(d, Meta, false)

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

%% check mean vector
d = d2;
meanV = nanmean(d, 4);
viewVector(meanV, Meta, false);
