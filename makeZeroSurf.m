fn = "/Users/takahiro/Desktop/scan/case3_3/out.csv";
dd = readmatrix(fn);
%%
d = dd(dd(:, 2) <-600, :); interval = 1;
% d = dd; interval = 100;
scatter3(d(1:interval:end, 1),...
         d(1:interval:end, 2),...
         d(1:interval:end, 3),...
         1, d(1:interval:end, 3))
axis equal

%%
ctmp = jet;
ctmp(1:110, :) = 0;
colormap(ctmp);
c = colorbar;
c.Limits = [0, 15];
ax = gca;
ax.Color = 'w';

%%
dnew = zeroSet(dd, ref);

function d = zeroSet(d, ref)
    N = length(ref);
    [x, y, z] = deal(zeros(N, 1));
    for I = 1:N
        x(I) = ref(I).Position(1);
        y(I) = ref(I).Position(2);
        z(I) = ref(I).Position(3);
    end
    % Set up fittype and options.
    ft = fittype( 'poly11' );
    % Fit model to data.
    [f, ~] = fit( [x, y], z, ft );
    zNew = @(x, y, z) z - f.p00 - x*f.p10 - y*f.p01;
    d(:, 3) = zNew(d(:, 1), d(:, 2), d(:, 3));
end 