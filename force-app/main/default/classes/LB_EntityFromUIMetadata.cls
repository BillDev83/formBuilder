/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Main entity class to return the values to display in the UI
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

************************************************************************************************************************************/
public class LB_EntityFromUIMetadata {
    
    //TODO expli lables and objects.
    
    @AuraEnabled
    public String fieldtype{get;set;}
    
    @AuraEnabled
    public String fieldLabel{get;set;}
    
    @AuraEnabled
    public String fieldValue{get;set;}
    
    @AuraEnabled
    public String fieldApiName{get;set;}
    
    @AuraEnabled
    public String ObjectApiName{get;set;}
    
    @AuraEnabled
    public boolean required{get;set;}
    
    public LB_EntityFromUIMetadata(){
        
    }
    
    public LB_EntityFromUIMetadata(String fieldApiName, String ObjectApiName, String fieldtype, String fieldLabel, String fieldValue, boolean  required){
        this.fieldApiName = fieldApiName;
        this.ObjectApiName = ObjectApiName;
        this.fieldtype = fieldtype;
        this.fieldLabel = fieldLabel;
        this.fieldValue = fieldValue;         
        this.required = required;
    }      

}