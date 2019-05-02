%clear all               % clear all variables



%%write to easily import EEG variable

%load('RoseEEG')
%load('EEG')



    %For UW Madison Data: 
    f = 500; %sampling rate is 1024 Hz
    CH = 4; %update as needed
    win0 = 125; %250 ms = 1024/4= 256
    DC = 4; %need to also try 4?
    
      
    % adjust window size so it can be evenly divided by the downsampling
    % factor identified by the decomposition level
    dc = 2^DC;
    win = floor(win0/dc)*dc;
    w = win/dc;
    
clear win0



%%
  %%
  
        for col = 1:CH    
                    % perform this loop on each channel individually
   %%     
            [C,L]  = wavedec(randiEEG(:,col),DC,'db4');
                    % perform wavelet decomposition on the designated channel
                    % to the indicated decomposition level (DC) using the 
                    % db4 wavelet
                    % for DC = 4 on 400 hz data, pull out XXXXX frequency
                    % for DC = 5 on 1024 hz data, pull out yyyyy frequency
                    
                               
               
            %L2 = [0; L]; % column of L with 0 added to the beginning
         %   Decomp = C((sum(L2(1:ww-1))+1):L(ww)); 
         Decomp = C(1:L(1));
                [rows,~] = size (Decomp); % '~' voids the 1 column. 
                    % Set Decomp equal to the approximation at the DC level
                    % The first value of L gives the number of coefficients 
                    % from the beginning of C that contains the 4th level
                    % approximation from the transform. This contains the 
                    % "most information" while reducing noise.


                    
                    
                    % find distance between datapoints n and n-1
        Dist = zeros(rows,1); 
            % creates a column vectors full of zeros that is the size of 
            % the decomposed/approximation of the EEG (rows).
            for m = 2:(rows-w) % size of Decomp (rows) - window (win = 96)
                %w = win/16 or win/DC^4
                
                Dist((m-1)) = abs(Decomp(m)-Decomp(m-1));
                    % modifies Dist and inputs the individual line lengths. 
                    % Starts from the 1st row in Dist and gives the
                    % absolute distance between the 2nd point and 1st point
                    % of the approximation/decomposed EEG.
                    % Ends at rows-6-1 and gives the abs diff between
                    % rows-6 and rows-6-1
            end
                                   
                    % sum distance between datapoints across window
           % LLength = zeros(length(Dist),col); 
                % creates LLength full of a column of zeros that has a
                % length of Dist which is the size of the decomp EEG
            LLStart = sum(Dist(1:w)); 
                % sums up line lengths of first window (6 numbers long,
                % represents ~100 datapoints from window)
                % which is Dist 1 to Dist 6,
                % which are line lengths between points 1 to 97 of the 
                % decomp EEG
            LLength(1) = LLStart;
                % modifies the first entry of LLength to the sum of line
                % lengths of first window
                
        for y = 2:rows-w 
            % this is the new LLength entry row, aka the 2nd window
                % which is sum of Dist 2 to Dist 97
                % which are line lengths between points 2 to 98 of the
                % decomp EEG
            % same as m, the number of times we calculated distance
                % runs from from 2 to rows-window(96) 
                % PROBLEM: the last window, from rows-96 to rows has 0 dist
                % because it wasn't calculated in Dist above.
            yy = y+w-1; 
                % starts at 2+96-1=97 to rows-96+96-1=rows-1
                    % specifies the new Dist entry to add to this 
                    % new window.
            LL_a = LLength(y-1)-Dist(y-1); 
                % LLength(2-1) - Dist(2-1),
                % LLength(rows-96-1) - Dist(rows-96-1)   
                    % takes the LL sum of previous window and subtracts
                    % the first Dist entry of that previous window
            LLength(y) = LL_a + Dist(yy);
                % Adds the next Dist entry to the new window 
                % Modifies LLength with this new sum of dist in new window
        end
        %%
        
 
            BaseStatMedian(1,col) = median(LLength);
            BaseStatStDev(1,col) = std(LLength);
            
            clear Decomp rows Dist LLength LLStart LL_a y yy C L
        end

    clear EEG 
 

    



    
     BaseStats = [BaseStatMedian; BaseStatStDev];

