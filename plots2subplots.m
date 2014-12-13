function hFig = plots2subplots(haxes, varargin)
%PLOTS2SUBPLOTS Copy multiple figures to a single subplot-formatted figure.
%   PLOTS2SUBPLOTS() creates a single subplot-formatted figure from copies
%   of all open figures.
%
%   PLOTS2SUBPLOTS('all') has the same effect as PLOTS2SUBPLOTS().
%
%   PLOTS2SUBPLOTS(HAXES) creates a single subplot-formatted figure from
%   a vector of axes handles specified in HAXES. HAXES can also be a vector
%   of figure handles.
%
%   PLOTS2SUBPLOTS(...,Name,Value) specifies special figure properties 
%   using one or more Name,Value pair arguments. Use this option with any 
%   of the input arguments in the previous syntaxes.
%
%   Name-Value Pair Arguments
%       'Colormap' - sets the subplots' colormaps
%       'inherit' (default) | 'gray' | 'jet' | 'default' | hsv(128)
%       Type HELP GRAPH3D to see more useful colormaps.
%
%       'Shape' - determines the overall arrangement of subplots
%       'square' (default) | 'row' | 'column'
%
%   hFig = PLOTS2SUBPLOTS(...) retrieves the subplot figure handle.
%
%   The order of subplots is made as square as possible (width >= height).
%
%   See also PRETTYPLOTS, COLORMAP.
%   https://github.com/keelanc/

%   Author: Keelan Chu For
%   2014-12-13
%   https://github.com/keelanc/plots2subplots


if nargin == 0 || (ischar(haxes) && strcmp(haxes,'all'))
    haxes = findobj('type','axes');         % Find all open figures
    haxes = haxes(end:-1:1);                % Plot oldest first
elseif all(ishghandle(haxes,'figure'))      % Convert figure handles
    haxes = cell2mat(gca(haxes));           % to axes handles
elseif iscell(haxes)                        % Cell array of axes handles
    haxes = cell2mat(haxes);
end

[Colormap,Shape] = parse_plots2subplots(varargin{:});

ll = length(haxes);
if ll < 2
    error('plots2subplots requires at least two figures')
end
if strcmp(Shape,'square')
    % make as square as possible, longest dimension along horizontal
    yy = floor(sqrt(ll));
    xx = ceil(ll/yy);
elseif strcmp(Shape,'row')
    yy = 1;
    xx = ll;
elseif strcmp(Shape,'column')
    yy = ll;
    xx = 1;
end
hFig = figure;                                  % new figure
for ii=1:ll
    dummy = subplot(yy,xx,ii,'Parent',hFig);    % temporary subplot
    newPos = get(dummy,'Position');             % get its position
    delete(dummy);
    haxesnew = copyobj(haxes(ii),hFig);         % copy a figure to hFigure
    set(haxesnew,'Position',newPos);            % and adjust position
    if strcmp(Colormap,'inherit')               % and maintain original
        set(get(haxesnew,'parent'), 'Colormap',... % colormap
            get(get(haxes(ii),'parent'), 'Colormap'));
    else
        set(get(haxesnew,'parent'), 'Colormap',...
        colormap(Colormap));
    end
end


function [Colormap,Shape] = parse_plots2subplots(varargin)
% 
p = inputParser;
defaultColormap = 'inherit';
defaultShape = 'square';
expectedShape = {'square','row','column'};

addParameter(p,'Colormap',defaultColormap);
addParameter(p,'Shape',defaultShape,...
             @(x) any(validatestring(x,expectedShape)));

parse(p,varargin{:});
Colormap = p.Results.Colormap;
Shape = p.Results.Shape;
