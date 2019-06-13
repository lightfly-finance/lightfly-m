function result = sort_map(data)
    tmp = {};
    for index = sort(keys(data))
        param = index + "=" + data(char(index));
        tmp = [tmp param];
    end
    
    result = strjoin(tmp, "&");
end