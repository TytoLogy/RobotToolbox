function robot_elmove(el)
% robot_simple.m
%
%
global DEBUG;

% check input values
if ~between(el, 1200, 5500)
	disp('invalid elevation value')
	return
end

% robobj = robot_open('COM7');

robobj = serial('COM7');
set(robobj, 'InputBufferSize', 2048);
set(robobj, 'BaudRate', 9600);
set(robobj, 'DataBits', 8);
set(robobj, 'Parity', 'none');
set(robobj, 'StopBits', 1);

fopen(robobj);

if ~strcmp(robobj.Status, 'open')
	delete(robobj);
	serobj = 0;
	return
else
	set(robobj, 'FlowControl', 'hardware');

	if exist('DEBUG')
		if DEBUG
			set(robobj, 'RecordName', 'robot.txt');
			set(robobj, 'RecordMode', 'index');
			set(robobj, 'RecordDetail', 'verbose');
			record(robobj, 'on')
		end
	end
end

servo_setspeed(robobj, 1, 10);

pause(0.5);
servo_absmove(robobj, 1, el);
pause(0.5)

fclose(robobj);
delete(robobj);
clear robobj



