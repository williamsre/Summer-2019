clear global;
%%

%Initialize the pulling data session
session = IEEGSession( 'Study 021', 'williamsre', 'wil_ieeglogin.bin');
Working_dataset = session.data(1);
%%

%pulling file to analye
       
%pulling first part of the data
%datasetOne = Working_dataset.getvalues(30600000:39600000,083:);
%datasetOne = Working_dataset.getvalues(1:245760,1:2); 
datasetOne = Working_dataset.getvalues(1:18000000,1:4);


%%
%pulling second part of the data
datasetTwo = Working_dataset.getvalues(30600000:39600000, 116:);

%combine two datasets together
clean = [datasetOne datasetTwo];

%Replace invalid value with 0;
clean(isnan(clean)) = 0;

% use to pull continous channels
% clean = Working_dataset.getvalues(87439500:87451500, 1:8);

%save it to a file
save('a_sig_clean.mat', 'clean')

%clear variabless
clear clean tempFile datasetOne datasetTwo

%-pulling baseline file-

%pulling first part of the data
datasetOne = Working_dataset.getvalues(32500000:32529999, 1:4);

%pulling second part of the data
datasetTwo = Working_dataset.getvalues(32500000:32529999, 69:72);

%combine two datasets together
clean = [datasetOne datasetTwo];

%Replace invalid value with 0;
clean(isnan(clean)) = 0;

% use to pull continous channels
% clean = Working_dataset.getvalues(87439500:87451500, 1:8);

%save it to a file
save('baseline_sig_clean.mat', 'clean')

%clear variables
clear clean tempFile datasetOne datasetTwo

