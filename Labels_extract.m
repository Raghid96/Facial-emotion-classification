%& The six emotions

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
j = 1;
t = 1;
file_names_all = strings;
file_names_png = strings;
emotion_Labels = strings;
for d = 1:length(string_names)
    myDir = strcat('/home/raghid/Desktop/Intelegence/fileread/Data_1', char(string_names(d)));
    myfiles = dir(fullfile(myDir, strcat(string_names(d), "_E_*.lm3")));
    myfiles2 =  dir(fullfile(myDir, strcat(string_names(d), "_E_*.bnt")));
    myfiles3 = dir(fullfile(myDir, strcat(string_names(d), "_E_*.png")));
    

    for e = 1:length(myfiles2)
        back_slash = '/';
        file_names_all_test = strcat(myfiles2(e).folder,back_slash);%string(myfiles2(e).name);
        file_names_all(t) = strcat(file_names_all_test, string(myfiles2(e).name));
        file_names_png(t) = strcat(file_names_all_test, string(myfiles3(e).name));
        t = t+1;
    end
    
    file_name = string(myDir(end-4:end));

    for k = 1:length(myfiles)
        baseFileName = myfiles(k).name;
        fullFileName = fullfile(myDir, baseFileName);

        [pts3D, labels] = read_lm3file(fullFileName);
        
        
        if string(baseFileName) == strcat(file_name, "_E_HAPPY_0.lm3") || string(baseFileName) == strcat(file_name, "_E_HAPPY_1.lm3")
            emotion_Labels(j,1) =strcat(file_name, "_E_HAPPY_0.png");
            emotion_Labels(j,2) = "Happy";
            
            
            png = strcat(file_name, "_E_HAPPY_0.png");
            png_fullname = fullfile(myDir, png);

        end
        
        
        if string(baseFileName) == strcat(file_name, "_E_FEAR_0.lm3")
            emotion_Labels(j,1) =strcat(file_name, "_E_FEAR_0.png");
            emotion_Labels(j,2) = "Fear";
            
            
            png = strcat(file_name, "_E_FEAR_0.png");
            png_fullname = fullfile(myDir, png);
            
        end
        
        if string(baseFileName) == strcat(file_name, "_E_SADNESS_0.lm3")
            emotion_Labels(j,1) =strcat(file_name, "_E_SADNESS_0.png");
            emotion_Labels(j,2) = "Sadness";
            
            
            png = strcat(file_name, "_E_SADNESS_0.png");
            png_fullname = fullfile(myDir, png);
            
            
            %RGB = imread(png_fullname);
            %I = rgb2gray(RGB);
            %imshow(I)
            
        end
        
        if string(baseFileName) == strcat(file_name, "_E_DISGUST_0.lm3")
            emotion_Labels(j,1) =strcat(file_name, "_E_DISGUST_0.png");
            emotion_Labels(j,2) = "DISGUST";
            
            
            png = strcat(file_name, "_E_DISGUST_0.png");
            png_fullname = fullfile(myDir, png);
            
            
        end
        
        
        if string(baseFileName) == strcat(file_name, "_E_ANGER_0.lm3")
            emotion_Labels(j,1) =strcat(file_name, "_E_ANGER_0.png");
            emotion_Labels(j,2) = "Anger";
            
            
            png = strcat(file_name, "_E_ANGER_0.png");
            png_fullname = fullfile(myDir, png);
            
            
        end
        
        
        if string(baseFileName) == strcat(file_name, "_E_SURPRISE_0.lm3")
            emotion_Labels(j,1) =strcat(file_name, "_E_SURPRISE_0.png");
            emotion_Labels(j,2) = "Surprise";
            
            
            png = strcat(file_name, "_E_SURPRISE_0.png");
            png_fullname = fullfile(myDir, png);
            

        end
        j= j+1;
    end

end


% %% Write labels to a file
% 
fid = fopen('lables.txt','wt');

for i = 1:length(emotion_Labels(:,2))
   if emotion_Labels(i,2).ismissing == 0
        fprintf(fid, "%s", emotion_Labels(i,1));
        fprintf(fid, "%s", ' ');
        fprintf(fid, "%s", emotion_Labels(i,2));
        fprintf(fid , "\n");
   end
end
% 
