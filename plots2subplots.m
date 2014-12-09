function plots2subplots(haxes)
%PLOTS2SUBPLOTS Copy multiple figures to a single subplot-formatted figure.
%   PLOTS2SUBPLOTS(haxes) creates a single subplot-formatted figure from
%   the axes handles specified in haxes.
%
%   PLOTS2SUBPLOTS() creates a single subplot-formatted figure from copies
%   of all open figures.
%
%   hFig = PLOTS2SUBPLOTS(...) retrieves the subplot figure handle.
%
%   The order of subplots is made as square as possible (width >= height).
%
%   See also PRETTYPLOTS.
%   https://github.com/keelanc/

%   Author: Keelan Chu For
%   2014-09-03
%   https://github.com/keelanc/plots2subplots

% test
% close all
% for ii=1:14
%     figure
%     ezplot(['x^',num2str(ii)])
% end

if nargin == 0          % find all open figures if none are specified
    haxes = findobj('type','axes');
    haxes = haxes(end:-1:1);                      % plot oldest first
end

% make as square as possible, longest dimension along horizontal
ll = length(haxes);
if ll < 2
    error('plots2subplots requires at least two figures')
end
yy = floor(sqrt(ll));
xx = ceil(ll/yy);
hFig = figure;                                  % new figure
for ii=1:ll
    dummy = subplot(yy,xx,ii,'Parent',hFig);    % temporary subplot
    newPos = get(dummy,'Position');             % get its position
    delete(dummy);
    haxesnew = copyobj(haxes(ii),hFig);         % copy a figure to hFigure
    set(haxesnew,'Position',newPos);            % and adjust position
    set(get(haxesnew,'parent'), 'Colormap',...  % and maintain original
        get(get(haxes(ii),'parent'), 'Colormap')); % colormap
end
