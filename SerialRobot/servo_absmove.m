function servo_absmove(serobj, servonum, pos)

if ~between(servonum, 0, 15)
	error('servo_absmove: servonum out of range (0-15)');
end

if ~between(pos, 500, 5500)
	error('servo_absmove: pos out of range (500-5500)');
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

% set absolute position
% command: 4
% data 1: upper bits
% data 2: lower bits
% pos: absolute position value, 500<=pos<=5500
data1 = binvec2dec(bitget(pos, 8:13));
data2 = binvec2dec(bitget(pos, 1:7));
fwrite(serobj, [128, 1, 4, servonum, data1, data2]);