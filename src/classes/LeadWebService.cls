@RestResource(urlMapping='/Leads/*')

global class LeadWebService {
       @HttpGet
    global static List<Lead> getLeads() {
        List<Lead> result =  [SELECT FirstName,LastName,Email,Company
                        FROM Lead];
        return result;
    }
    @HttpPost
    global static ID createLead(String firstName, String lastName,
        String email, String company) {
        Lead thisLead = new Lead(
            FirstName=firstName,
            LastName=lastName,
            Email=email,
            Company=company);
        insert thisLead;
        return thisLead.Id;
    }   
    @HttpDelete
    global static void deleteLead() {
        RestRequest request = RestContext.request;
        String leadId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Lead thisLead = [SELECT Id FROM Lead WHERE External_Id__c = :leadId];
        delete thisLead;
    }     
    @HttpPut
    global static ID upsertLead(String firstName, String lastName,
        String email, String company, String id) {
        Lead thisLead = new Lead(
                Id=id,
                FirstName=firstName,
            	LastName=lastName,
            	Email=email,
            	Company=company);
       
        upsert thisLead;
        return thisLead.Id;
    }
    @HttpPatch
    global static ID updateLeadFields() {
        RestRequest request = RestContext.request;
        String leadId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Lead thisLead = [SELECT Id FROM Lead WHERE Id = :leadId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        for(String fieldName : params.keySet()) {
            thisLead.put(fieldName, params.get(fieldName));
        }
        update thisLead;
        return thisLead.Id;
    }    
	
}