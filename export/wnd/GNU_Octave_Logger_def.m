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

## @deftypefn  {} {} connectToArduino_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of connectToArduino control.
##
## @end deftypefn
function connectToArduino_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user click the button control.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallback' from the properties editor

% Get selected com port
index = get(GNU_Octave_Logger.arduinoPortsComboBox, 'Value');
comports = get(GNU_Octave_Logger.arduinoPortsComboBox, 'String');

% Connect
global selectedArduino;
selectedArduino = arduino(comports{index});
end

## @deftypefn  {} {} scanForArduinoPorts_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of scanForArduinoPorts control.
##
## @end deftypefn
function scanForArduinoPorts_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user click the button control.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallback' from the properties editor

% Load arduino
pkg load instrument-control
pkg load arduino

% Scan ports
arduinos = scanForArduinos;
[m, n] = size(arduinos);

% Collect them
names = {};
for i = 1:n
   portName = arduinos{i}.port;
   names{i} = portName;
end

% Set them
set(GNU_Octave_Logger.arduinoPortsComboBox, 'String', names);
end

## @deftypefn  {} {} installArduinoUNOfirmware_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of installArduinoUNOfirmware control.
##
## @end deftypefn
function installArduinoUNOfirmware_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user click the button control.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallback' from the properties editor

% Install instrument control and load it
pkg load instrument-control
pkg load arduino

% Setup firmware
helpdlg('Remember to have Arduino IDE installed. This GNU Octave Logger is tested with Arduino IDE 1.8.19.', 'Setup');
arduinosetup()
end

## @deftypefn  {} {} testLEDPin13_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of testLEDPin13 control.
##
## @end deftypefn
function testLEDPin13_doIt(src, data, GNU_Octave_Logger)

% Get button state
global buttonState = 0;

% Toggle LED 13
global selectedArduino;
writeDigitalPin(selectedArduino, 'D13', buttonState);
buttonState = !buttonState;
end

## @deftypefn  {} {} createNewFile_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of createNewFile control.
##
## @end deftypefn
function createNewFile_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user click the button control.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallback' from the properties editor

% Get new file 
[fname, fpath] = uiputfile("*.csv");

% Save file path
global filePath;
filePath = strcat(fpath, fname);
set(GNU_Octave_Logger.filePath, 'String', filePath);

% Create file 
fid = fopen(filePath, 'w');
fclose(fid);
end

## @deftypefn  {} {} openExcistingFile_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of openExcistingFile control.
##
## @end deftypefn
function openExcistingFile_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user click the button control.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallback' from the properties editor

% Select existing file
[fname, fpath] = uigetfile("*.csv");

% Save it
global filePath;
filePath = strcat(fpath, fname);
set(GNU_Octave_Logger.filePath, 'String', filePath);

end

## @deftypefn  {} {} analogInputPinComboBox_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of analogInputPinComboBox control.
##
## @end deftypefn
function analogInputPinComboBox_doIt(src, data, GNU_Octave_Logger)

global analogInputPin;
index = get(GNU_Octave_Logger.analogInputPinComboBox, 'Value');
analogInputPins = get(GNU_Octave_Logger.analogInputPinComboBox, 'String');
analogInputPins = strsplit(analogInputPins, '|');
analogInputPin = analogInputPins{index};
end

## @deftypefn  {} {} analogOutputPinComboBox_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of analogOutputPinComboBox control.
##
## @end deftypefn
function analogOutputPinComboBox_doIt(src, data, GNU_Octave_Logger)

global analogOutputPin;
index = get(GNU_Octave_Logger.analogOutputPinComboBox, 'Value');
analogOutputPins = get(GNU_Octave_Logger.analogOutputPinComboBox, 'String');
analogOutputPins = strsplit(analogOutputPins, '|');
analogOutputPin = analogOutputPins{index};
end

## @deftypefn  {} {} sampleTimeComboBox_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of sampleTimeComboBox control.
##
## @end deftypefn
function sampleTimeComboBox_doIt(src, data, GNU_Octave_Logger)

global sampleTime;
index = get(GNU_Octave_Logger.sampleTimeComboBox, 'Value');
sampleTimes = get(GNU_Octave_Logger.sampleTimeComboBox, 'String');
sampleTimes = strsplit(sampleTimes, '|');
sampleTime = str2num(sampleTimes{index});
end

## @deftypefn  {} {} stopLogging_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of stopLogging control.
##
## @end deftypefn
function stopLogging_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user click the button control.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallback' from the properties editor

% Set global value 
global isLogging;
isLogging = 0;

% Change color
set(GNU_Octave_Logger.stopLogging, 'ForegroundColor', [0.027 0.976 0.027]);
set(GNU_Octave_Logger.startLogging, 'ForegroundColor',[0.667 0.000 0.000]);
end

## @deftypefn  {} {} startLogging_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of startLogging control.
##
## @end deftypefn
function startLogging_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user click the button control.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallback' from the properties editor

global isLogging;
isLogging = 1;

% Change color
set(GNU_Octave_Logger.stopLogging, 'ForegroundColor', [0.667 0.000 0.000]);
set(GNU_Octave_Logger.startLogging, 'ForegroundColor', [0.027 0.976 0.027]);

% Get values
sampleTimeComboBox_doIt(src, data, GNU_Octave_Logger);
analogOutputPinComboBox_doIt(src, data, GNU_Octave_Logger);
analogInputPinComboBox_doIt(src, data, GNU_Octave_Logger);
viewSamplesComboBox_doIt(src, data, GNU_Octave_Logger);
minCalibrationEdit_doIt(src, data, GNU_Octave_Logger);
maxCalibrationEdit_doIt(src, data, GNU_Octave_Logger);

% Start logging
GNU_Octave_Logger_thread(GNU_Octave_Logger);
end

## @deftypefn  {} {} viewSamplesComboBox_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of viewSamplesComboBox control.
##
## @end deftypefn
function viewSamplesComboBox_doIt(src, data, GNU_Octave_Logger)

global viewSamples;
index = get(GNU_Octave_Logger.viewSamplesComboBox, 'Value');
samples = get(GNU_Octave_Logger.viewSamplesComboBox, 'String');
samples = strsplit(samples, '|');
viewSamples = str2num(samples{index});
end

## @deftypefn  {} {} minCalibrationEdit_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of minCalibrationEdit control.
##
## @end deftypefn
function minCalibrationEdit_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when the control lost focus and text has 
% been changed or when press the "enter" key.
% As default, all events are deactivated, to activate must set the
% propertie 'have callback' from the properties editor

global minValueCalibration;
minValueCalibration = str2num(get(GNU_Octave_Logger.minCalibrationEdit, 'String'));
end

## @deftypefn  {} {} maxCalibrationEdit_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of maxCalibrationEdit control.
##
## @end deftypefn
function maxCalibrationEdit_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when the control lost focus and text has 
% been changed or when press the "enter" key.
% As default, all events are deactivated, to activate must set the
% propertie 'have callback' from the properties editor

global maxValueCalibration;
maxValueCalibration = str2num(get(GNU_Octave_Logger.maxCalibrationEdit, 'String'));
end

## @deftypefn  {} {} analogOutputValueSlider_doIt (@var{src}, @var{data}, @var{GNU_Octave_Logger})
##
## Define a callback for default action of analogOutputValueSlider control.
##
## @end deftypefn
function analogOutputValueSlider_doIt(src, data, GNU_Octave_Logger)

% This code will be executed when user change the value of slider.
% As default, all events are deactivated, to activate must set the
% propertie 'generateCallbck' from the properties editor

global analogOutputValueSlider;
analogOutputValueSlider = get(GNU_Octave_Logger.analogOutputValueSlider, 'Value');
end

 
## @deftypefn  {} {@var{ret} = } show_GNU_Octave_Logger()
##
## Create windows controls over a figure, link controls with callbacks and return 
## a window struct representation.
##
## @end deftypefn
function ret = show_GNU_Octave_Logger()
  _scrSize = get(0, "screensize");
  _xPos = (_scrSize(3) - 1138)/2;
  _yPos = (_scrSize(4) - 768)/2;
   GNU_Octave_Logger = figure ( ... 
	'Color', [0.941 0.941 0.941], ...
	'Position', [_xPos _yPos 1138 768], ...
	'resize', 'on', ...
	'windowstyle', 'normal', ...
	'MenuBar', 'none');
	 set(GNU_Octave_Logger, 'visible', 'off');
  connectionGroupPanel = uipanel( ...
	'parent',GNU_Octave_Logger, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [25 432 260 316], ... 
	'title', 'Connection', ... 
	'TitlePosition', 'lefttop');
  connectToArduino = uicontrol( ...
	'parent',connectionGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [16 57 223 44], ... 
	'String', 'Connect to Arduino UNO', ... 
	'TooltipString', '');
  scanForArduinoPorts = uicontrol( ...
	'parent',connectionGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 177 226 44], ... 
	'String', 'Scan for Arduino UNO ports', ... 
	'TooltipString', '');
  arduinoPortsLabel = uicontrol( ...
	'parent',connectionGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [20 147 142 19], ... 
	'String', 'Arduino UNO ports:', ... 
	'TooltipString', '');
  arduinoPortsComboBox = uicontrol( ...
	'parent',connectionGroupPanel, ... 
	'Style','popupmenu', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'bold', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 111 224 25], ... 
	'String', '', ... 
	'TooltipString', '');
  installArduinoUNOfirmware = uicontrol( ...
	'parent',connectionGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [17 236 225 45], ... 
	'String', 'Install Arduino UNO firmware', ... 
	'TooltipString', '');
  testLEDPin13 = uicontrol( ...
	'parent',connectionGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [20 11 217 35], ... 
	'String', 'Test LED Pin 13', ... 
	'TooltipString', '');
  fileHandlerGroupPanel = uipanel( ...
	'parent',GNU_Octave_Logger, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [27 281 258 147], ... 
	'title', 'File handler', ... 
	'TitlePosition', 'lefttop');
  createNewFile = uicontrol( ...
	'parent',fileHandlerGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 86 221 31], ... 
	'String', 'Create new file', ... 
	'TooltipString', '');
  openExcistingFile = uicontrol( ...
	'parent',fileHandlerGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 52 220 30], ... 
	'String', 'Open existing file', ... 
	'TooltipString', '');
  filePath = uicontrol( ...
	'parent',fileHandlerGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [20 18 233 19], ... 
	'String', 'File path:', ... 
	'TooltipString', '');
  loggingSettingsGroupPanel = uipanel( ...
	'parent',GNU_Octave_Logger, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [27 8 258 270], ... 
	'title', 'Logging settings', ... 
	'TitlePosition', 'lefttop');
  analogInputLabel = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [15 221 95 19], ... 
	'String', 'Analog input:', ... 
	'TooltipString', '');
  analogInputPinComboBox = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','popupmenu', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [150 220 80 25], ... 
	'String', 'A0|A1|A2|A3|A4|A5', ... 
	'TooltipString', '');
  sampleTimeLabel = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [15 91 130 19], ... 
	'String', 'Sample time [ms]:', ... 
	'TooltipString', '');
  analogOutputPinLabel = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [15 126 131 19], ... 
	'String', 'Analog output pin:', ... 
	'TooltipString', '');
  analogOutputPinComboBox = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','popupmenu', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [150 125 80 25], ... 
	'String', 'D11|D10|D9|D6|D5|D3', ... 
	'TooltipString', '');
  sampleTimeComboBox = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','popupmenu', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [150 90 80 25], ... 
	'String', '1|5|10|25|50|100|150|250|500|1000|1500|2000|5000|10000', ... 
	'TooltipString', '');
  stopLogging = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.027 0.976 0.027], ... 
	'Position', [15 15 114 30], ... 
	'String', 'Stop logging', ... 
	'TooltipString', '');
  startLogging = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.667 0.000 0.000], ... 
	'Position', [130 15 109 30], ... 
	'String', 'Start logging', ... 
	'TooltipString', '');
  viewSamples = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [15 56 104 19], ... 
	'String', 'View samples:', ... 
	'TooltipString', '');
  viewSamplesComboBox = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','popupmenu', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [150 55 79 25], ... 
	'String', '10|20|30|40|50|100|250|500|1000', ... 
	'TooltipString', '');
  minCalibrationEdit = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','edit', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [1.000 1.000 1.000], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [150 188 80 22], ... 
	'String', '0', ... 
	'TooltipString', '');
  maxCalibrationEdit = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','edit', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [1.000 1.000 1.000], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [150 153 78 22], ... 
	'String', '1023', ... 
	'TooltipString', '');
  minCalibrationLabel = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [15 186 111 19], ... 
	'String', 'Min calibration:', ... 
	'TooltipString', '');
  maxCalibrationLabel = uicontrol( ...
	'parent',loggingSettingsGroupPanel, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [15 156 114 19], ... 
	'String', 'Max calibration:', ... 
	'TooltipString', '');
  plot = axes( ...
	'Units', 'pixels', ... 
	'parent',GNU_Octave_Logger, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'Position', [321 43 814 695]);
  analogOutputValueSlider = uicontrol( ...
	'parent',GNU_Octave_Logger, ... 
	'Style','slider', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Max', 255, ... 
	'Min', 0, ... 
	'Position', [452 5 679 32], ... 
	'TooltipString', '', ... 
	'Value', 0);
  analogOutputValue = uicontrol( ...
	'parent',GNU_Octave_Logger, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [300 9 146 19], ... 
	'String', 'Analog output value:', ... 
	'TooltipString', '');

  GNU_Octave_Logger = struct( ...
      'figure', GNU_Octave_Logger, ...
      'connectionGroupPanel', connectionGroupPanel, ...
      'connectToArduino', connectToArduino, ...
      'scanForArduinoPorts', scanForArduinoPorts, ...
      'arduinoPortsLabel', arduinoPortsLabel, ...
      'arduinoPortsComboBox', arduinoPortsComboBox, ...
      'installArduinoUNOfirmware', installArduinoUNOfirmware, ...
      'testLEDPin13', testLEDPin13, ...
      'fileHandlerGroupPanel', fileHandlerGroupPanel, ...
      'createNewFile', createNewFile, ...
      'openExcistingFile', openExcistingFile, ...
      'filePath', filePath, ...
      'loggingSettingsGroupPanel', loggingSettingsGroupPanel, ...
      'analogInputLabel', analogInputLabel, ...
      'analogInputPinComboBox', analogInputPinComboBox, ...
      'sampleTimeLabel', sampleTimeLabel, ...
      'analogOutputPinLabel', analogOutputPinLabel, ...
      'analogOutputPinComboBox', analogOutputPinComboBox, ...
      'sampleTimeComboBox', sampleTimeComboBox, ...
      'stopLogging', stopLogging, ...
      'startLogging', startLogging, ...
      'viewSamples', viewSamples, ...
      'viewSamplesComboBox', viewSamplesComboBox, ...
      'minCalibrationEdit', minCalibrationEdit, ...
      'maxCalibrationEdit', maxCalibrationEdit, ...
      'minCalibrationLabel', minCalibrationLabel, ...
      'maxCalibrationLabel', maxCalibrationLabel, ...
      'plot', plot, ...
      'analogOutputValueSlider', analogOutputValueSlider, ...
      'analogOutputValue', analogOutputValue);


set (connectToArduino, 'callback', {@connectToArduino_doIt, GNU_Octave_Logger});
set (scanForArduinoPorts, 'callback', {@scanForArduinoPorts_doIt, GNU_Octave_Logger});
set (installArduinoUNOfirmware, 'callback', {@installArduinoUNOfirmware_doIt, GNU_Octave_Logger});
set (testLEDPin13, 'callback', {@testLEDPin13_doIt, GNU_Octave_Logger});
set (createNewFile, 'callback', {@createNewFile_doIt, GNU_Octave_Logger});
set (openExcistingFile, 'callback', {@openExcistingFile_doIt, GNU_Octave_Logger});
set (analogInputPinComboBox, 'callback', {@analogInputPinComboBox_doIt, GNU_Octave_Logger});
set (analogOutputPinComboBox, 'callback', {@analogOutputPinComboBox_doIt, GNU_Octave_Logger});
set (sampleTimeComboBox, 'callback', {@sampleTimeComboBox_doIt, GNU_Octave_Logger});
set (stopLogging, 'callback', {@stopLogging_doIt, GNU_Octave_Logger});
set (startLogging, 'callback', {@startLogging_doIt, GNU_Octave_Logger});
set (viewSamplesComboBox, 'callback', {@viewSamplesComboBox_doIt, GNU_Octave_Logger});
set (minCalibrationEdit, 'callback', {@minCalibrationEdit_doIt, GNU_Octave_Logger});
set (maxCalibrationEdit, 'callback', {@maxCalibrationEdit_doIt, GNU_Octave_Logger});
  set (analogOutputValueSlider, 'callback', {@analogOutputValueSlider_doIt, GNU_Octave_Logger});
  dlg = struct(GNU_Octave_Logger);

%
% The source code writed here will be executed when
% windows load. Work like 'onLoad' event of other languages.
%

  set(GNU_Octave_Logger.figure, 'visible', 'on');
  ret = GNU_Octave_Logger;
end

