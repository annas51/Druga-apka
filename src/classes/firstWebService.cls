@RestResource(urlMapping='/getLeadInfo/*')
global class firstWebService {
    
    @HttpGet
    global static Lead getLead(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String urlId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        Lead ld = [SELECT Id, Name from Lead where Id =: urlId];
        return ld;
    }

}