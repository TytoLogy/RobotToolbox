
disp('...closing robot devices...');
robs = instrfind
if length(robs)
    for i  = 1: length(robs)
        fclose(robs(i));
        delete(robs(i));
	end
end