/***********************************************************************************************************************************
Created Date        : 03/14/2019
Function            : Basic selector to get the custom settings info 
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

************************************************************************************************************************************/
public with sharing class LB_FormConfigurationSelector {
    
    private static Map<String,LB_FormConfiguration__mdt> formConfigurationCache = new Map<String,LB_FormConfiguration__mdt>();

    /**
     * Get the Custom metadata based on Name
     *
     *
     **/
    public static LB_FormConfiguration__mdt getFormConfigurationByName(String FormConfigurationName){
        
        if(formConfigurationCache.get(FormConfigurationName) == null){
            
            List<LB_FormConfiguration__mdt> formConfig = [SELECT DeveloperName, Object_Type__c, Field_Set_Name__c, Post_Process_Form_Class__c, PreProcessFormClass__c, Process_Form_Class__c
                                                     FROM LB_FormConfiguration__mdt
                                                     where DeveloperName = :FormConfigurationName
                                                    ];
            
            if(formConfig != null && formConfig.size() > 0){                
                formConfigurationCache.put(FormConfigurationName, formConfig.get(0));
            }            
        }
        
        return formConfigurationCache.get(FormConfigurationName);
        	
    }	
}