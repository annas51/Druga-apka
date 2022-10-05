public class ApexDebugLog_Test{
   public static void createErrorLog(){
        try{
            List<Lead> LeadIds = new List<Lead>();
            insert LeadIds;
        }
        catch(Exception ex){
            new ApexDebugLog().createLog(
                new ApexDebugLog.Error(
                    'ApexDebugLog_Test',
                    'createErrorLog',
                    NULL,
                    ex
                )
            );
        }
    }

   public static void createInformationLog(){
        new ApexDebugLog().createLog(
            new ApexDebugLog.Information(
                'ApexDebugLog_Test',
                'createInformationLog',
                NULL,
                'Logging Information from an Apex Class - ApexDebugLog_Test'
            )
        );

    }

   public static void ws_createErrorLog(){
        try{
            Integer result = 1 / 0;
        }
        catch(Exception ex){
            ApexDebugLog.createLog(
                '{"Type" : "Error","ApexClass" : "ApexDebugLog_Test","Method" : "createErrorLog","RecordId" : "","Message" : "System.MathException: Divide by 0","StackTrace" : "Line: 1, Column: 1 System.MathException: Divide by 0"}'
            );

           
        }
    }

  public static void ws_createInformationLog(){
        ApexDebugLog.createLog(
            '{"Type" : "Information","ApexClass" : "ApexDebugLog_Test","Method" : "createInformationLog","RecordId" : "","Message" : "Logging Information from an Apex Class - ApexDebugLog_Test"}'
        );

           }
}