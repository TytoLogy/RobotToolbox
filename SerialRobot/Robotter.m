function varargout = Robotter(varargin)
% ROBOTTER M-file for Robotter.fig
%      ROBOTTER, by itself, creates a new ROBOTTER or raises the existing
%      singleton*.
%
%      H = ROBOTTER returns the handle to a new ROBOTTER or the handle to
%      the existing singleton*.
%
%      ROBOTTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOTTER.M with the given input arguments.
%
%      ROBOTTER('Property','Value',...) creates a new ROBOTTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Robotter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Robotter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

%--------------------------------------------------------------------------

% Last Modified by GUIDE v2.5 27-Nov-2007 16:14:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Robotter_OpeningFcn, ...
                   'gui_OutputFcn',  @Robotter_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT
%--------------------------------------------------------------------------


% --- Executes just before Robotter is made visible.
function Robotter_OpeningFcn(hObject, eventdata, handles, varargin)
	handles.output = hObject;

	handles.az_motor = 0;
	handles.el_motor = 1;
	handles.az_val = 3100;
	handles.el_val = 2900;
	set(handles.az_value, 'String', sprintf('%d', round(handles.az_val)));
	set(handles.el_value, 'String', sprintf('%d', round(handles.el_val)));
	set(handles.AzimuthCtrl, 'Value', handles.az_val);
	set(handles.ElevationCtrl, 'Value', handles.el_val);
	robot_azelmove(handles.az_val, handles.el_val);

	% Update handles structure
	guidata(hObject, handles);
%--------------------------------------------------------------------------



function varargout = Robotter_OutputFcn(hObject, eventdata, handles) 
	varargout{1} = handles.output;
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
function move_button_Callback(hObject, eventdata, handles)
	set(handles.move_button, 'String', 'Moving');
	set(handles.move_button, 'Enable', 'inactive');
	robot_azelmove(handles.az_val, handles.el_val);
	pause(1);
	set(handles.move_button, 'String', 'Set Position');
	set(handles.move_button, 'Enable', 'on');
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
function AzimuthCtrl_Callback(hObject, eventdata, handles)
	az_val = round(get(hObject, 'Value'));

 	if between(az_val, 1200, 5500)
		handles.az_val = az_val;
		set(handles.az_value, 'String', sprintf('%d', round(handles.az_val)));
	else
		warning('Az value out of range');
		set(hObject, 'Value', handles.az_val);
		set(handles.az_value, 'String', sprintf('%d', round(handles.az_val)));
	end

	guidata(hObject, handles)
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
function ElevationCtrl_Callback(hObject, eventdata, handles)
	el_val = round(get(hObject, 'Value'));

	if between(el_val, 1200, 5500)
		handles.el_val = el_val;
		set(handles.el_value, 'String', sprintf('%d', round(handles.el_val)));
	else
		warning('Elevation value out of range');
		set(hObject, 'Value', handles.el_val);
		set(handles.el_value, 'String', sprintf('%d', round(handles.el_val)));
	end
	guidata(hObject, handles)
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function el_value_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function az_value_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function AzimuthCtrl_CreateFcn(hObject, eventdata, handles)
	if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor',[.9 .9 .9]);
	end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function ElevationCtrl_CreateFcn(hObject, eventdata, handles)
	if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor',[.9 .9 .9]);
	end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function az_value_CreateFcn(hObject, eventdata, handles)
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
	end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function el_value_CreateFcn(hObject, eventdata, handles)
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
	end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function ResetButton_Callback(hObject, eventdata, handles)
	instrcleanup_com7
	set(handles.move_button, 'Enable', 'on');

%--------------------------------------------------------------------------

