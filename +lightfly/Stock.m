classdef Stock
    %UNTITLED2 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties (SetAccess = private)
        AppId
        SecretKey 
        BaseUrl = "http://localhost:8000"
    end
    
    methods
        function obj = Stock(app_id, secret_key)
           if nargin == 2
                obj.AppId = app_id;
                obj.SecretKey = secret_key;
           else
               throw(MException("Stock:ArgsRequired", "Please set the app id and secret key. ex. stock = Stock(appid, secret_key)"));
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
        
        function result = hs300(obj)
            result = obj.fetch("/api/stock/hs300", containers.Map());
        end
        
        function result = daily_history(obj, symbol, date_from, date_to)
            result = obj.fetch("/api/stock/history/daily", containers.Map(["symbol", "date_from", "date_to"], [symbol, date_from, date_to]));
        end
        
        function result = stock_realtime(obj, symbols)
            result = obj.fetch("/api/stock/realtime", containers.Map("symbols", symbols));
        end
        
        function result = hgs_trade_realtime(self)
            result = self.fetch("/api/stock/hgs/trade/realtime", containers.Map());
        end
        
        function result = hgtong_top10(self)
            result = self.fetch("/api/stock/hgtong/top10", containers.Map());
        end
        
        function result = sgtong_top10(self)
            result = self.fetch("/api/stock/sgtong/top10", containers.Map());
        end
        
        function result = ggtong_top10(self)
           result = self.fetch("/api/stock/ggtong/top10", containers.Map()); 
        end
        
        function result = stock_index(self)
           result = self.fetch("/api/stock/index", containers.Map()); 
        end
        
        function result = sh_index_component(self)
            result = self.fetch("/api/stock/component/shindex", containers.Map()); 
        end
        
        function result = sh_consumption_index_component(self)
            result = self.fetch("/api/stock/component/shconsumptionindex", containers.Map());
        end
        
        function result = sh50_index_component(self)
            result = self.fetch("/api/stock/component/sh50index", containers.Map());
        end
        
        function result = sh_medicine_index_component(self)
            result = self.fetch("/api/stock/component/shmedicineindex", containers.Map());
        end
        
        function result = sz_index_component(self)
            result = self.fetch("/api/stock/component/szindex", containers.Map());
        end
        
        function result = sz_composite_index_component(self)
            result = self.fetch("/api/stock/component/szcompositeindex", containers.Map());
        end
        
        function result = zz500_index_component(self)
           result = self.fetch("/api/stock/component/zz500index", containers.Map()); 
        end
        
        function result = indicator_main(self, symbol)
           result = self.fetch("/api/stock/indicator/main", containers.Map("symbol", symbol)); 
        end
        
        function result = profitability(self, symbol)
            result = self.fetch("/api/stock/indicator/profitability", containers.Map("symbol", symbol));
        end
        
        function result = solvency(self, symbol)
            result = self.fetch("/api/stock/indicator/solvency", containers.Map("symbol", symbol));
        end
        
        function result = growth_ability(self, symbol)
           result = self.fetch("/api/stock/indicator/growthability", containers.Map("symbol", symbol)); 
        end
    end
end

