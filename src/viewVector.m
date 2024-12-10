function viewVector(d, Meta, outGif, secPause)

% general
CM = "jet";
YLIMS = [-100, 2100];
XLIMS = [-200, 3200];
FN_GIF = "animation.gif";
RES = 300;
% scaling color bar 
LEVELS = 5;
ROUND_ORDER = -1;

if nargin == 3; secPause = 0.1; end
maxc = max(sqrt(d(:, :, 1, :).^2 + d(:, :, 2, :)), [], "all");
maxc = round(maxc, ROUND_ORDER); 
fprintf("max value is %.2f", maxc)
N = size(d, 4);
[xx, yy] = meshgrid(Meta.coordX, Meta.coordY);

for I = 1:N
    magQuiver(xx', yy', d(:, :, 1, I), d(:, :, 2, I), maxc, CM);
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