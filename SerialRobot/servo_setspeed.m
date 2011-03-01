function servo_setspeed(serobj, servonum, speed)

if ~between(servonum, 0, 15)
	warning('servo_setspeed: servonum out of range (0-15)');
	return
end

if ~between(speed, 0, 127)
	warning('servo_setspeed: speed out of range (0-127)');
	return
end

% command format is:
% 
% | start byte | device ID | command | servo # | data 1 | data 2
% 
% start byte: always '0x80' (128)  * () values are decimal 
% device ID: always '0x01' (1)
% command: specifies command, 6 values (see below)
% servo num: '0x00 - 0xFE' (0 - 254)
% data1, data2: bytes vary with command

% First, set the speed (pulse width)
% command: 1
% data 1: 0-127
% 		0 = default, instant
% 		1 = 50 us/second
% 		127 = 6.35 ms/second
fwrite(serobj, [128, 1, 1, servonum, speed]);