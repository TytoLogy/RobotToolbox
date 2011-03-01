function instrcleanup

s = instrfind

snum = length(s);

if ~snum
	disp('instrcleanup: no serial instruments to clean!')
	return;
end

for i = 1:snum
	fclose(s(i))
	delete(s(i))
end

