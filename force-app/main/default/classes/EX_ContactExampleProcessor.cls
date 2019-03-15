/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Example of an LB_IPreProcessForm implementation
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/14/2019        Original Version

************************************************************************************************************************************/
public with sharing class EX_ContactExampleProcessor implements LB_IPreProcessForm {
    
    
    /**
     * Prepopulate contact Info
     *
     *
     **/
    public List<sObject> prePropulateObjects(List<LB_EntityExternalParameters> UIParameters){
        
        //for this version we support only one UI parameter
            String recordId = UIParameters[0].recordId;
            String objectType = UIParameters[0].objectType;
            String configurationName = UIParameters[0].configurationName;
        
        //Business Logic        
            Contact contact = new contact();
            contact.FirstName = 'Test';
            contact.LastName = 'Test';
            contact.AccountId = recordId;
        
        return new List<sObject>{contact};        
    }

}