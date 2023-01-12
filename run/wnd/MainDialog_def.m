## -*- texinfo -*-
## @deftypefn  {} {} dummy()
##
## This is a dummy function documentation. This file have a lot functions
## and each one have a little documentation. This text is to avoid a warning when
## install this file as part of package.
## @end deftypefn
##
## Set the graphics toolkit and force read this file as script file (not a function file).
##
graphics_toolkit qt;
##


##
##
## Begin callbacks definitions 
##

 
## @deftypefn  {} {@var{ret} = } show_MainDialog()
##
## Create windows controls over a figure, link controls with callbacks and return 
## a window struct representation.
##
## @end deftypefn
function ret = show_MainDialog()
  _scrSize = get(0, "screensize");
  _xPos = (_scrSize(3) - 317)/2;
  _yPos = (_scrSize(4) - 89)/2;
   MainDialog = figure ( ... 
	'Color', [0.941 0.941 0.941], ...
	'Position', [_xPos _yPos 317 89], ...
	'resize', 'off', ...
	'windowstyle', 'normal', ...
	'MenuBar', 'none');
	 set(MainDialog, 'visible', 'off');

  MainDialog = struct( ...
      'figure', MainDialog);


  dlg = struct(MainDialog);

%
% The source code writed here will be executed when
% windows load. Work like 'onLoad' event of other languages.
%

  set(MainDialog.figure, 'visible', 'on');
  ret = MainDialog;
end

