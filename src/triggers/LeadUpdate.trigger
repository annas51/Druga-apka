trigger LeadUpdate on Lead (before insert, after insert,after update, before delete) {
    
       try{ 

          List<String> LeadIds = new List<String>();
           if (Trigger.isBefore && Trigger.isInsert)
           {
               for(Lead l :Trigger.new){
                   l.External_Id__c = LeadManager.generateRandomString(10);
                                  
               }
           }
           if (Trigger.isAfter && Trigger.isUpdate){
                 for(Lead l :Trigger.new){
                   LeadIds.add(l.Id);
               }
               LeadManager.sendUpdateLeads(LeadIds);             
           }
           if (Trigger.isBefore && Trigger.isDelete){
               system.debug('deletgin');
                 for(Lead l :Trigger.old){
                   LeadIds.add(l.External_Id__c);
               }
               LeadManager.deleteLead(LeadIds);             
           }
           
           if(Trigger.isInsert && Trigger.isAfter){
               for(Lead l :Trigger.new){
                   LeadIds.add(l.Id);
               }
               LeadManager.sendLeads(LeadIds);

           }
                    else  if(Trigger.isUpdate && Trigger.isAfter){
               for(Lead l :Trigger.new){
                   LeadIds.add(l.Id);
               }
               LeadManager.sendLeads(LeadIds);

           }
         
        
         
         
        }catch(exception e){

            system.debug('Error:'+e.getMessage()+'At Line'+e.getLineNumber());
            System.debug( 'test catch');

        }

    }