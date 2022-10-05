public class myFirstRestAPI {
    public static void getLeadInfo(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://britenet-a3-dev-ed.my.salesforce.com/services/oauth2/token?username=anna.stachelek@britenet.com.pl&password=Lipiec.04ij4Aj9bNLN7kgSX8vT28v9rY&grant_type=password&client_id=3MVG9t0sl2P.pByqLoOEDjuIwsyPNkD5jVJQt4UM4LKZ4Z2qATt4k1CvYsgp7g_8cQzB5NuNJ0racqMVJBvMy&client_secret=4B8E794A2E65086ADF56BD95409B9CA1D12A6A399F97E673215CCD5009C3E963');
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res = http.send(req);
        system.debug('response Auth ---' +res.getBody());
        Oauth objAuthInfo = (Oauth)JSON.deserialize(res.getBody(), Oauth.class);
        if(objAuthInfo.access_token != null){
            HttpRequest req1 = new HttpRequest();
            req1.setEndpoint('https://britenet-a3-dev-ed.my.salesforce.com/services/apexrest/getLeadInfo/00Q7Q000008E6qtUAC');
            req1.setMethod('GET');
            req1.setHeader('Content-Type', 'application/json');
            req1.setHeader('Authorization', 'Bearer '+ objAuthInfo.access_token);
            
            Http http1 = new Http();
            HttpResponse res1 = new HttpResponse();
            res1 = http.send(req1);
            system.debug('Lead Info ---' +res1.getBody());
            
        }
       
    }
		
    public class Oauth{
        public String access_token{get;set;}
        public String instance_url{get;set;}
        public String id{get;set;}
        public String token_type{get;set;}
        public String issued_at{get;set;}
        public String signature{get;set;}

    }
}