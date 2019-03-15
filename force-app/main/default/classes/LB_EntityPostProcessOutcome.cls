/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Entity class to carry the info after a record was Post Processed (normally a redirect)
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

************************************************************************************************************************************/
public class LB_EntityPostProcessOutcome {
    
    @AuraEnabled
    public String messageType{get;set;} // Redirect // NavigateToUrl
    
    @AuraEnabled
    public String messageTittle{get;set;}
    
    @AuraEnabled
    public String messageContent{get;set;}    
    
    @AuraEnabled
    public string redirectURl{get;set;}
    
}