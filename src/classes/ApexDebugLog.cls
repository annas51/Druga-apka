global class ApexDebugLog{

    public virtual class Log{
        public String ApexClass;
        public String Method;
        public String RecordId;
        public String Message;
        public String StackTrace;
    }
    
 
    public class Error extends Log{
        public Error(String cls, String routine, String recId, Exception e){
            this.ApexClass = cls;
            this.Method = routine;
            this.RecordId = recId;
            this.Message = e.getMessage();
            this.StackTrace = e.getStackTraceString();
        }
    }


    public class Information extends Log{
        public Information(String cls, String routine, String recId, String msg){
            this.ApexClass = cls;
            this.Method = routine;
            this.RecordId = recId;
            this.Message = msg;
            this.StackTrace = NULL;
        }
    }


    
    public void createLog(Log logToCreate){
        try{
            if(
                (Limits.getDMLRows() < Limits.getLimitDMLRows()) && 
                (Limits.getDMLStatements() < Limits.getLimitDMLStatements())
            )
            {
                Apex_Debug_Log__c apexDebuglog = new Apex_Debug_Log__c(
                    Apex_Class__c=logToCreate.ApexClass,
                    Method__c=logToCreate.Method,
                    Record_Id__c=logToCreate.RecordId,
                    Message__c=logToCreate.Message,
                    Stack_Trace__c=logToCreate.StackTrace
                );

                Database.insert(apexDebuglog, FALSE);
            }
            else{
                System.debug('The Governor exhausted');
            }
        }
        catch(DMLException e){
            System.debug('Something wrong! Error:' + e.getMessage());
        }
    }

   
    webService
    static void createLog(String log){
        try{
            /*
                 
                {
                    "ApexClass"  : "---",
                    "Method"     : "---",
                    "RecordId"   : "---",
                    "Message"    : "---",
                    "StackTrace" : "---",
                }
            */


            ApexDebugLog.Log logToCreate = (ApexDebugLog.Log)JSON.deserialize(log, ApexDebugLog.Log.class);
            
            new ApexDebugLog().createLog(logToCreate);
        }
        catch(Exception e){
            System.debug('Something wrong, Error:' + e.getMessage());
        }
    }
}