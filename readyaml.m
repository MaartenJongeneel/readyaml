function results = ReadYaml(filePath)
% Lloyd Russell 2017
% Simple little function to read simple little YAML format parameter files
% Adapted by Maarten Jongeneel May 2021 to allow for arrays

% read file line by line
fid = fopen(filePath, 'r');
data = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
fclose(fid);

% remove empty lines
data = deblank(data{1});
data(cellfun('isempty', data)) = [];

% prepare final results structure
results = [];

%boolean to check what level you are in
instruct = false;

% parse the contents (line by line)
i=0;
while i < numel(data)
    i = i+1;
    % extract this line
    thisLine = data{i};
    
    % ignore if this line is a comment
    if strcmpi(thisLine(1), '#')
        continue
    end   
    
    if ~instruct
        % find the seperator between key and value
        sepIndex = find(thisLine==':', 1, 'first');
        
        % get the key name (remove whitespace)
        key = strtrim(thisLine(1:sepIndex-1));
        
        % get the value, ignoring any comments (remove whitespace)
        value = strsplit(thisLine(sepIndex+1:end), '#');
        value = strtrim(value{1});
    end
    
    if isempty(value) && ~instruct %it is extended underneath
        instruct = true;
        continue;
    end
    
    if instruct
        j = 0; value = [];
        while instruct && (i+j)<=numel(data)
            if startsWith(data{i+j},"  -") % if it is an array
                % find the seperator between key and value
                sepIndex = find(data{i+j}=='-', 1, 'first');
                array = strsplit(data{i+j}(sepIndex+2:end), '#');
                array = strtrim(array{1});
                value(j+1,:) = str2num(array);
                j = j+1;
                %         else %If it is not an array, the field is a subfield
                %             sepIndex = find(data{i+j}==':', 1, 'first');
                %             fn = strtrim(data{i+j}(3:sepIndex-1));
            else
                instruct = false;
            end       
        end
        i = i+j-1;
    elseif contains(value,'"') % check if the value is a string
        %Strings are always stored in cell, for easy hdf5 attr conversion 
        if contains(value,'[')% check if the string is a string array
            value = strsplit(erase(value,{'[',']','"'}),', ')';
        else
            value = cellstr(erase(value,'"')); 
        end
    else
        % attempt to convert value to numeric type
        [convertedValue, success] = str2num(value);
        if success
            value = convertedValue;
        end
    end
    
    % store the key and value in the results
    results.(key) = value;
end