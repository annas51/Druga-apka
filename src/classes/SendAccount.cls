public class SendAccount {
    //Use your Client Id 
    String clientId = '3MVG9t0sl2P.pByqLoOEDjuIwsyPNkD5jVJQt4UM4LKZ4Z2qATt4k1CvYsgp7g_8cQzB5NuNJ0racqMVJBvMy';
    //Use your Client Secret
    String clientsecret='4B8E794A2E65086ADF56BD95409B9CA1D12A6A399F97E673215CCD5009C3E963';
    //Your Destination org username
    String username='anna.stachelek1@britenet.com.pl';
    //Your Destination orgPassword+Security Token
    String password='Wiatrak.0400D7Q000008Nvgb!AR0AQP0CrD7onwMD0UPt06F9t8R6EAjdEmrd5kIh_ocPZCi0m.W__UWdBX.VMHotM93aRFhyQ8PnyR68Rlwux3RNDmhra_rS';
    String accesstoken_url='https://britenet40-dev-ed.my.salesforce.com/services/oauth2/token';
    String authurl='https://login.salesforce.com/services/oauth2/authorize';
    public class deserializeResponse {
        public String id;
        public String access_token;
    }
    public String ReturnAccessToken(SendAccount Acc){
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='
        +clientSecret+'&username='+username+'&password='+password;
        // String reqbody='{"grant_type":password”,”client_id”:clientId,”client_secret”:clientSecret,
       // “username”:username,”password”:password}’;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        //Change “ap4” in url to your Destination Org Instance
        req.setEndpoint('https://britenet40-dev-ed.my.salesforce.com/services/oauth2/token');
        HttpResponse res=h.send(req);
        System.debug(res.getBody()+'By-AP-1986-Response');
        deserializeResponse resp1=
        (deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        System.debug(resp1+'By-AP-deserializeresponse');
        return resp1.access_token;
    }
    @future(callout=true)
    public static void createAccount(String Accname, String Phone, String Website){
        SendAccount acc1= new SendAccount();
        String accessToken=acc1.ReturnAccessToken(acc1);
        System.debug(accessToken+'###AP');
        if(accessToken!=null){
            //Change “ap4” in url to your Destination Org
            String endPoint='https://britenet40-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/Account';  
            String jsonstr='{"Name":"'+ Accname +'","Phone":"'+ Phone +'","Website":"'+ Website +'"}';
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+';;;Akash;;;');
            deserializeResponse deresp=                         (deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug(';;;; Deserialized Response ;;;;;'+deresp);
        }
    }
}