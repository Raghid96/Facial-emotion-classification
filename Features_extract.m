%%  Names

string_names = strings;
for i = 1:104
    if i <10
        string_names(i) = strcat("/bs00", string(i));
    elseif i<100
        string_names(i) = strcat("/bs0", string(i));
    else
        string_names(i) = strcat("/bs", string(i));
    end
end

last_string = strings;

for i = 1:104
    last_string(i) = strcat(string_names(i), '_E_*.lm3');
end

features = zeros();
feat_index= 1;
Res = [];
my_lab = strings;
emotion_Labels = strings;


%% Specify the emotion
for fl = 1:104
    
    
    myDir = strcat('/home/raghid/Desktop/Intelegence/fileread/Data_1/', string_names(fl));
    myfiles = dir(fullfile(myDir, last_string(fl)));

    for i = 1:length(myfiles)
        if string(myfiles(i).name) == myfiles(1).name
            my_lab(i) = "ANGER";
        elseif string(myfiles(i).name) == myfiles(2).name
            my_lab(i) = "DISGUST";
        elseif string(myfiles(i).name) == myfiles(3).name
            my_lab(i) = "FEAR";
        elseif string(myfiles(i).name) == myfiles(4).name
            my_lab(i) = "HAPPY";
        elseif string(myfiles(i).name) == myfiles(5).name
            my_lab(i)  = "SADNESS";
        else
            my_lab(i) = "SURPRISE";
        end
    end
    
    
    
    
    j = 1;
    g = 1;
    %%  Reading the files
    for k = 1:length(myfiles)
        baseFileName = myfiles(k).name;
        fullFileName = fullfile(myDir, baseFileName);
        [pts3D, labels] = read_lm3file(fullFileName);
        
        %% Mouth featiure
        for i = 1:22
            if(string(labels(i)) == 'Left mouth corner' || string(labels(i)) == 'Right mouth corner' )
                if(string(labels(i)) == 'Left mouth corner')
                    Res(:,1) = pts3D(:,i);
                else
                    Res(:,2) = pts3D(:,i);
                end
            end
        end

        
        D = norm(Res(:,1) - Res(:,2));
        features(feat_index,fl) = D;
        
        %% Left eye
        
        for i = 1:22
            if(string(labels(i)) == 'Outer left eye corner' || string(labels(i)) == 'Inner left eye corner' )
                if(string(labels(i)) == 'Outer left eye corner')
                    Res(:,1) = pts3D(:,i);
                else
                    Res(:,2) = pts3D(:,i);
                end
            end
        end
        
        D1 = norm(Res(:,1) - Res(:,2));
        features(feat_index,fl+1) = D1;
        
        
        
        
        %% Right eye
        for i = 1:22
            if(string(labels(i)) == 'Outer right eye corner' || string(labels(i)) == 'Inner right eye corner' )
                if(string(labels(i)) == 'Outer right eye corner')
                    Res(:,1) = pts3D(:,i);
                else
                    Res(:,2) = pts3D(:,i);
                end
            end
        end
        
        D2 = norm(Res(:,1) - Res(:,2));
        features(feat_index,fl+2) = D2;
        
        
        
        %% Nose saddle
        for i = 1:22
            if(string(labels(i)) == 'Nose saddle left' || string(labels(i)) == 'Nose saddle right')
                if(string(labels(i)) == 'Nose saddle left')
                    Res(:,1) = pts3D(:,i);
                else
                    Res(:,2) = pts3D(:,i);
                end
            end
        end
        
        D3 = norm(Res(:,1) - Res(:,2));
        features(feat_index,fl+3) = D3;
        
        %% Nose peak
        
        for i = 1:22
            if(string(labels(i)) == 'Left nose peak' || string(labels(i)) == 'Right nose peak')
                if(string(labels(i)) == 'Left nose peak')
                    Res(:,1) = pts3D(:,i);
                else
                    Res(:,2) = pts3D(:,i);
                end
            end
        end
        
        D4 = norm(Res(:,1) - Res(:,2));
        features(feat_index,fl+4) = D4;
        
        
        %% Lip outer
        
        for i = 1:22
            if(string(labels(i)) == 'Upper lip outer middle' || string(labels(i)) == 'Lower lip outer middle')
                if(string(labels(i)) == 'Upper lip outer middle')
                    Res(:,1) = pts3D(:,i);
                else
                    Res(:,2) = pts3D(:,i);
                end
            end
        end
        
        D5 = norm(Res(:,1) - Res(:,2));
        features(feat_index,fl+5) = D5;
        
        %% Lip inner
        
        for i = 1:22
            if(string(labels(i)) == 'Upper lip inner middle' || string(labels(i)) == 'Lower lip inner middle')
                if(string(labels(i)) == 'Upper lip inner middle')
                    Res(:,1) = pts3D(:,i);
                else
                    Res(:,2) = pts3D(:,i);
                end
            end
        end
        
        D4 = norm(Res(:,1) - Res(:,2));
        features(feat_index,fl+6) = D4;
        feat_index = feat_index + 1;
        
        
    end
    
end


%% Fix the features the input for the classifier
for i = 1:length(features)
    mat(:,i) = nonzeros(features(i,:)); % The input matrix to the classifier
end

mat = mat';
