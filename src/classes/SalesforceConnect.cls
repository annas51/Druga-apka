public class SalesforceConnect {
    
    public static void getLeadFromSecondSFOrg(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:LanguideAPI/services/apexrest/Leads');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
       		 List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
            for(Object result : results){
                Map<String, Object> leadProperties = (Map<String, Object>) result;
                System.debug('FirstName: ' + leadProperties.get('FirstName') + ' LastName: ' + leadProperties.get('LastName'));
            }
            
        }
  
    }
    public static void createLeadFromSecondSFOrg(){
        Http httpObject = new Http();
        	HttpRequest req = new HttpRequest();
        	req.setEndpoint('https://britenet40-dev-ed.my.salesforce.com/services/apexrest/Leads');
       		req.setMethod('POST');
			req.setHeader('Authorization', 'Bearer 00D7Q000008Nvgb!AR0AQH7hO05iS.bE3iYsrn1cLnBnKSspEUhVub2kruNqYDJ7lM4Iiesn1ULhyasi2Gd6AsYHn6pph0w9wfGX0Z8KT3OqOFxq');
        	req.setBody('{"firstName":"waclllllll","lastName":"walclll","email":"waclllll@test.test","company":"waclllllll"}');
            HttpResponse response = httpObject.send(req);
       	    System.debug(response.getBody());

        if(response.getStatusCode() == 200) {
            System.debug(response.getBody());
        }
    }
    
}