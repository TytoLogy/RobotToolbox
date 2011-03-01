function robot_tdtazmove(servo, az)
% robot_tdtazmove(servo, az)
%
%
global DEBUG;

% check input values
if nargin ~= 2
	disp('robot_tdtazmove: bad args');
end

if ~between(az, .25, 2.75)
	disp('invalid azimuth pulse width value')
	return
end

RPsettag(servo, 'PulseWidth1', az);
