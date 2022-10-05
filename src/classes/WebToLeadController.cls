/**
 * Created by anna.stachelek on 31.08.2022.
 */

global with sharing class WebToLeadController {
    global List<String> countriesLabels {get;set;}
    global List<Schema.PicklistEntry> countries {get;set;}
    global String selectedCountry {get;set;}
//    public String testXD = 'dupa';

    public String getTestXD(){
        return 'dupa';
    }

    public static Boolean isCountryselectDisabled {get;set;}


    public WebToLeadController(){
    countriesLabels = getPickListValuesIntoList();
    isCountryselectDisabled = true;
//        testXD = 'dupa';
    }


    @RemoteAction
   public static void  filterCountries(String tmp){
    }

    public List<String> getPickListValuesIntoList(){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Lead.Country__c.getDescribe();
        countries = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : countries){
            pickListValuesList.add(pickListVal.getLabel());
        }
        return pickListValuesList;
    }
}