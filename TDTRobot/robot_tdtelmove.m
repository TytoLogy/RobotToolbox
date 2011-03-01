function robot_tdtelmove(servo, el)
% robot_tdtelmove(servo, el)
%
%
global DEBUG;

% check input values
if nargin ~= 2
	disp('robot_tdtelmove: bad args');
end
if ~between(el, .25, 2.75)
	disp('invalid elevation pulse width value')
	return
end

RPsettag(servo, 'PulseWidth2', el);
