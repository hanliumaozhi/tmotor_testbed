% add a user dialog to decide whether to save the recorded data
% recorded data file is named after the current time
% MUST run setup.m before used

f=SimulinkRealTime.fileSystem;
h=fopen(f,'caData.dat');
data=fread(f,h);
f.fclose(h);
log_data = SimulinkRealTime.utils.getFileScopeData(data); 
fileName=string(datetime('now','Format','uuuu_MM_dd''T''HH_mm_ss'));
fileName=sprintf('%s.mat',fileName);
que=['Save the recorded data to ' fileName '?'];
res=questdlg(que,'Data Save?','Yes','No','Yes');
dataRecFolder='%s\\DataRec\\%s';
dir=sprintf(dataRecFolder,projectRoot,fileName);
if strcmp(res,'Yes')
    save(dir,'log_data');
end
clear fileName que res dataRecFolder dir res;