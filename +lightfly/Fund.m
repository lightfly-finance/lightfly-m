classdef Fund
    %UNTITLED2 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties (SetAccess = private)
        AppId
        SecretKey 
        BaseUrl = "http://lightfly.cn:80"
    end
    
    methods
        function obj = Fund(app_id, secret_key)
           if nargin == 2
                obj.AppId = app_id;
                obj.SecretKey = secret_key;
           else
               throw(MException("Fund:ArgsRequired", "Please set the app id and secret key. ex. fund = Fund(appid, secret_key)"));
           end
        end
  
        function result = fetch(obj, path_info, params)
            import matlab.net.*;
            import matlab.net.http.*;
            url = obj.BaseUrl + path_info + "?" + lightfly.sort_map(params);
            params("path_info") = path_info;
            app_id = obj.AppId;
            params("app_id") = app_id;
            params("secret_key") = obj.SecretKey;
            token = lightfly.get_sign(params);
            headers = HeaderField("X-App-Id", app_id, "X-Token", token, "X-Software", "Math");
            reqline = RequestLine("get", url, "HTTP/1.1");
            request = RequestMessage(reqline, headers, MessageBody());
            response = send(request, obj.BaseUrl, HTTPOptions("ConvertResponse", true));
            result = response.Body.Data;  
        end
        
        function result = daily_history(self, symbol, date_from, date_to)
            result = self.fetch("/api/fund/history/daily", containers.Map(["symbol", "date_from", "date_to"], [symbol, date_from, date_to]));
        end
    end
    
end

