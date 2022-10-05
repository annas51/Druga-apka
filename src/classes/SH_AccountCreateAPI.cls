public class SH_AccountCreateAPI {

     //Write below clientId, clientSecret, username, password (combination of password and security token) from Org B (Target Org)
    private static String clientId = '3MVG9t0sl2P.pByp.ZVgjKw8s8VOwuOcG9JxYH1aupGgBFbGawZrSYq1M6ekzeWjc8f9pj9UbrwdckHVkdKvg';
    private static String clientSecret = '6E54A2498C6642E2132665C3DB07933191D1C048E0E5CE9EB4AD5CADC8077356';
    private static String username = 'anna.stachelek1@britenet.com.pl';
    private static String password = 'Wiatrak.04O6mx2ZQgVWKLBMggQr4az4vL';
    
    public class resWrapper
    {
        public String id;
        public String access_token;
    }
    public class accountWrap{
        public string case_region;
        public String wName;
        public String wPhone;
        public accountWrap(String name,String phone)
        {
            this.wName =name;
            this.wPhone =phone;
        } 
    }
    public String getRequestToken(SH_AccountCreateAPI accnt){
        String reqbody = 'grant_type=password'+'&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        Http h1 = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://hut-dev-ed.my.salesforce.com/services/oauth2/token');
        HttpResponse res = h1.send(req);
        resWrapper response = (resWrapper)JSON.deserialize(res.getBody(),resWrapper.class);
        System.debug('response--->>>'+response);
        return response.access_token;
    }
    @future(callout=true)
    public static void createAccountMethod(Set<id> accIdSet){
        SH_AccountCreateAPI accnt = new SH_AccountCreateAPI();
        String accessToken;
        String JSNBody;
        accessToken = accnt.getRequestToken(accnt);
        List<Account> accList = new List<Account>();
        if(accessToken != null) {
            //Set Endpoint URL Of the Target Org Webservice Class
            String endPoint = 'https://britenet40-dev-ed.my.salesforce.com/services/apexrest/v1/accountRecordCreate/';  
            For(Account acc:[SELECT Id, Name, Phone FROM Account WHERE Id IN: accIdSet]){
                accList.add(acc);
                if(accList.size() > 0)
                {
                    accountWrap accObj = new accountWrap(accList[0].name ,accList[0].phone );
                     JSNBody = JSON.serialize(accObj);
                }  
                    Http h2 = new Http();
                    HttpRequest req1 = new HttpRequest();
                    req1.setHeader('Authorization','Bearer ' + accessToken);
                    req1.setHeader('Content-Type','application/json');
                    req1.setHeader('accept','application/json');
                    req1.setMethod('POST');
                    req1.setBody(JSNBody);
                    System.debug('body--->>'+JSNBody);
                    req1.setEndpoint(endPoint);
                    HttpResponse res1 = h2.send(req1);
                    
                }
            }
            
        }
}