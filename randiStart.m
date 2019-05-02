
%EEG = datasetOne
y = isnan(EEG);
z = find(y); 
nn = length(z);  

if isempty(z) == 1
    disp('no NaN!')
else 
    disp('yes NaN')
    disp(nn)
end 

EEG(isnan(EEG)) = 0;

fs = 500 
%[row,col] = size(EEG)  

row = 18000000; 

s = row;  

w = 10*60*fs; %this is the window time * seconds * fs, converts mintues to frequency  

maxStart = s-w  

minStart = 1; 

minEnd = w; 

maxEnd = s; 

rs =randi(maxStart) 
  
randiEEG = EEG(rs: rs+w, 1:4);

EEG = randiEEG; 

run plotEEG

run basestatsEEG


