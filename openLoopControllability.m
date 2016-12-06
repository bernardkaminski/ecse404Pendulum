load('statespace');
Co = ctrb(sys_ss);
Ctlbility = rank(Co);
if (Ctlbility > rankA)
    disp('The system is controllable.');
else 
    disp('The system is not controllable.')
end
