function instrcleanup_com7

s = instrfind('Port', 'COM7');

snum = length(s);

if ~snum
	disp('instrcleanup_com7: no robot instruments to clean!')
	return;
end

for i = 1:snum
	fclose(s(i))
	delete(s(i))
end

