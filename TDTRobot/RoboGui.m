function varargout = RoboGui(varargin)
% ROBOGUI M-file for RoboGui.fig
%      ROBOGUI, by itself, creates a new ROBOGUI or raises the existing
%      singleton*.
%
%      H = ROBOGUI returns the handle to a new ROBOGUI or the handle to
%      the existing singleton*.
%
%      ROBOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOGUI.M with the given input arguments.
%
%      ROBOGUI('Property','Value',...) creates a new ROBOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RoboGui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RoboGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

%--------------------------------------------------------------------------

% Last Modified by GUIDE v2.5 19-Dec-2007 12:51:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RoboGui_OpeningFcn, ...
                   'gui_OutputFcn',  @RoboGui_OutputFcn, ...
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


% --- Executes just before RoboGui is made visible.
function RoboGui_OpeningFcn(hObject, eventdata, handles, varargin)
	handles.output = hObject;
	
	handles.az_motor = 0;
	handles.el_motor = 1;
	handles.az_val = 1.5;
	handles.el_val = 1.5;
	set(handles.az_value, 'String', sprintf('%.3f', (handles.az_val)));
	set(handles.el_value, 'String', sprintf('%.3f', (handles.el_val)));
	set(handles.AzimuthCtrl, 'Value', handles.az_val);
	set(handles.ElevationCtrl, 'Value', handles.el_val);

	handles.servoinit = 0;
	
	% Update handles structure
	guidata(hObject, handles);
%--------------------------------------------------------------------------



function varargout = RoboGui_OutputFcn(hObject, eventdata, handles) 
	varargout{1} = handles.output;
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
function move_button_Callback(hObject, eventdata, handles)
	if handles.servoinit
		
		az_val = (get(handles.AzimuthCtrl, 'Value'));
		if between(az_val, .25, 2.75)
			handles.az_val = az_val;
			set(handles.az_value, 'String', sprintf('%.3f', (handles.az_val)));
		else
			warning('Az value out of range');
			set(hObject, 'Value', handles.az_val);
			set(handles.az_value, 'String', sprintf('%.3f', (handles.az_val)));
		end

		el_val = (get(handles.ElevationCtrl, 'Value'));

		if between(el_val, .25, 2.75)
			handles.el_val = el_val;
			set(handles.el_value, 'String', sprintf('%.3f', (handles.el_val)));
		else
			warning('Elevation value out of range');
			set(hObject, 'Value', handles.el_val);
			set(handles.el_value, 'String', sprintf('%.3f', (handles.el_val)));
		end
		
		set(handles.move_button, 'String', 'Moving');
		set(handles.move_button, 'Enable', 'inactive');
		robot_tdtmove(handles.servo, handles.az_val, handles.el_val);
		pause(1);
		set(handles.move_button, 'String', 'Set Position');
		set(handles.move_button, 'Enable', 'on');
	end
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
function AzimuthCtrl_Callback(hObject, eventdata, handles)
	az_val = (get(hObject, 'Value'));

 	if between(az_val, .25, 2.75)
		handles.az_val = az_val;
		set(handles.az_value, 'String', sprintf('%.3f', (handles.az_val)));
	else
		warning('Az value out of range');
		set(hObject, 'Value', handles.az_val);
		set(handles.az_value, 'String', sprintf('%.3f', (handles.az_val)));
	end

	guidata(hObject, handles)
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
function ElevationCtrl_Callback(hObject, eventdata, handles)
	el_val = (get(hObject, 'Value'));

	if between(el_val, .25, 2.75)
		handles.el_val = el_val;
		set(handles.el_value, 'String', sprintf('%.3f', (handles.el_val)));
	else
		warning('Elevation value out of range');
		set(hObject, 'Value', handles.el_val);
		set(handles.el_value, 'String', sprintf('%.3f', (handles.el_val)));
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
%	instrcleanup_com7
	set(handles.move_button, 'Enable', 'on');

%--------------------------------------------------------------------------



% --- Executes when user attempts to close GuiRobotFigure.
function GuiRobotFigure_CloseRequestFcn(hObject, eventdata, handles)
	pause(0.5);
	delete(hObject);


