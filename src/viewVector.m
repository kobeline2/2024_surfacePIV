function viewVector(d, Meta, outGif, scale, secPause)

% general
CM = "jet";
% YLIMS = [-100, 2100];
% XLIMS = [-200, 3200];
FN_GIF = "animation.gif";
RES = 300;
% scaling color bar 
LEVELS = 5;
ROUND_ORDER = -1;

% calc xlim, ylim
R = 1/20;
lb = min(Meta.coordX); ub = max(Meta.coordX); ll = ub - lb;
XLIMS = [lb-ll*R, ub+ll*R];
lb = min(Meta.coordY); ub = max(Meta.coordY); ll = ub - lb;
YLIMS = [lb-ll*R, ub+ll*R];

if nargin == 4; secPause = 0.1; end
maxc = max(sqrt(d(:, :, 1, :).^2 + d(:, :, 2, :)), [], "all");
maxc = round(maxc, ROUND_ORDER); 
fprintf("max value is %.2f", maxc)
N = size(d, 4);
[xx, yy] = meshgrid(Meta.coordX, Meta.coordY);

for I = 1:N
    magQuiver(xx', yy', d(:, :, 1, I), d(:, :, 2, I), maxc, CM, scale);
    axis equal
    ylim(YLIMS) % change accordingly
    xlim(XLIMS) % change accordingly
    c = colorbar;
    c.Ticks = linspace(0, 1, LEVELS);
    c.TickLabels = linspace(0, maxc, LEVELS);
    if outGif
        exportgraphics(gca, FN_GIF, Append=true, Resolution=RES)
    end
    pause(secPause)
    % drawnow
end
end