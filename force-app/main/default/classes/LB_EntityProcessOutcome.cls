/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Entity class to carry the info after a record was processed (Validate or Upserted)
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

************************************************************************************************************************************/
public class LB_EntityProcessOutcome {

    @AuraEnabled
    public boolean isValid{get;set;}
    
    @AuraEnabled
    public String errorTittle{get;set;}
    
    @AuraEnabled
    public String errorMessage{get;set;}
    
    @AuraEnabled
    public sObject record{get;set;}
    
    @AuraEnabled
    public List<LB_EntityFromUIMetadata> metadataInfo{get;set;}
    
}