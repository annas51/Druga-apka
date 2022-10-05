public class LeadManager {
    
    @future (callout=true)
    public static void sendLeads(List<String> LeadIds){
        	System.debug('zolta kartka');
        	List<Lead> leads = [SELECT Id, FirstName, LastName, Email, Company, External_Id__c FROM Lead WHERE Id In :leadIds];
        for(Lead l	: leads){
            system.debug('name >> ' + l.FirstName);
            Http httpObject = new Http();
        	HttpRequest req = new HttpRequest();
        	req.setEndpoint('https://britenet40-dev-ed.my.salesforce.com/services/apexrest/Leads');
       		req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');
			req.setHeader('Authorization', 'Bearer 00D7Q000008Nvgb!AR0AQBDbbQ40wdfjUewfeF.yC8bNpkGhhbXh08okFhua8OBJOoHusgPHdOrhGzqp9bslHf3FMpzsESUqUrfMa7JcWqu0lLHG');
               
               LeadWrapper newLead = new LeadWrapper();
               newLead.FirstName = l.FirstName;
               newLead.LastName = l.LastName;
               newLead.Email = l.Email;
               newLead.Company = l.Company;
               newLead.ExId=l.External_Id__c;
            
              string serializedLead = JSON.serialize(newLead);
                              
            system.debug('serializedLead >>'+ serializedLead);
        	req.setBody(serializedLead);
        	System.debug(req.getBody());
            
            HttpResponse response = httpObject.send(req);
	    	System.debug(response.getBody() + 'test end try');    
        }

        
    }
    
    @future (callout=true)
    public static void sendUpdateLeads(List<String> LeadIds){
        	List<Lead> leads = [SELECT Id, FirstName, LastName, Email, Company, External_Id__c FROM Lead WHERE Id In :leadIds];
        for(Lead l	: leads){
            Apex_Debug_Log__c log = new Apex_Debug_Log__c();
            system.debug('name >> ' + l.FirstName);
            Http httpObject = new Http();
        	HttpRequest req = new HttpRequest();
        	req.setEndpoint('https://britenet40-dev-ed.my.salesforce.com/services/apexrest/Leads');
       		req.setMethod('PATCH');
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');
			req.setHeader('Authorization', 'Bearer 00D7Q000008Nvgb!AR0AQBDbbQ40wdfjUewfeF.yC8bNpkGhhbXh08okFhua8OBJOoHusgPHdOrhGzqp9bslHf3FMpzsESUqUrfMa7JcWqu0lLHG');
            	
           // log.Message__c=l.getMessage();
            
               LeadWrapper newLead = new LeadWrapper();
               newLead.FirstName = l.FirstName;
               newLead.LastName = l.LastName;
               newLead.Email = l.Email;
               newLead.Company = l.Company;
               newLead.ExId=l.External_Id__c;
              
             
              
               
           string serializedLead = JSON.serialize(newLead);
                             
            system.debug('serializedLead >>'+ serializedLead);
        	req.setBody(serializedLead);
        	System.debug(req.getBody());

            try {
                HttpResponse response = httpObject.send(req);
	    		System.debug(response.getBody() + 'test end try'); 
               // Integer tmp = 1/0;
              //  log.Response__c = response.getBody();
             	log.Method__c=req.getMethod();
                
            } catch(Exception e) {
                log.Stack_Trace__c = e.getStackTraceString();
                log.Message__c = e.getMessage();
            }
         
            log.Name = newLead.ExId;
             insert log;
            
        }
        
    }   
    
     @future (callout=true)
    public static void deleteLead(List<String> LeadIds){
                    Apex_Debug_Log__c log = new Apex_Debug_Log__c();

        	System.debug('zielona kartka');
        System.debug(LeadIds);
        for(String l	: LeadIds){
            Http httpObject = new Http();
        	HttpRequest req = new HttpRequest();
        	req.setEndpoint('https://britenet40-dev-ed.my.salesforce.com/services/apexrest/Leads/' +l);
       		req.setMethod('DELETE');
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');
			req.setHeader('Authorization', 'Bearer 00D7Q000008Nvgb!AR0AQBDbbQ40wdfjUewfeF.yC8bNpkGhhbXh08okFhua8OBJOoHusgPHdOrhGzqp9bslHf3FMpzsESUqUrfMa7JcWqu0lLHG');
               try {
                HttpResponse response = httpObject.send(req);
	    		System.debug(response.getBody() + 'test end try'); 
               // Integer tmp = 1/0;
              //  log.Response__c = response.getBody();
             	log.Method__c=req.getMethod();
                
            } catch(Exception e) {
                log.Stack_Trace__c = e.getStackTraceString();
                log.Message__c = e.getMessage();
            }
        
        }
    }
      
    public static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    class LeadWrapper{
        public String FirstName;
        public String LastName;
        public String Email;
        public String Company;  
        public String ExId;
        
    }
}