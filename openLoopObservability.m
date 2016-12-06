load('statespace_vals');
Oo = obsv(sys_ss);
Obsvbility = rank(Oo);
if (Obsvbility > rankA)
    disp('The system is observable.');
else 
    disp('The system is not observable.')
end