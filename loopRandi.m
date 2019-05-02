%EEG= datasetOne
fs = 500 
%[row,col] = size(EEG) 

row = 18000000;

s = row; 
%w = 10*60*fs; %this is the window time * seconds * fs, converts mintues to frequency 
w = 10*60*60*fs; %hours to fequency
maxStart = s-w 
minStart = 1;
minEnd = w;
maxEnd = s;

t=5 %how many section of data do I want  

for i= 1:t;  

    rs =randi (s-w)  

    M= rs:t 
    randiEEG = EEG(rs: rs+w, 1:4);
end  
 