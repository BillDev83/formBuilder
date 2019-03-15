/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Main controller to orchestrate the different processors 
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

************************************************************************************************************************************/
public with sharing class LB_FormBuilderController {
          
    @AuraEnabled
    public static LB_EntityProcessOutcome getFormData(LB_EntityExternalParameters UIParameters) {
        
        LB_EntityProcessOutcome processOutCome = new LB_EntityProcessOutcome();
        
        try{
        
            if(UIParameters != null || String.isBlank(UIParameters.configurationName) || String.isBlank(UIParameters.objectType)){
                                
                List<LB_EntityFromUIMetadata> listData = new List<LB_EntityFromUIMetadata>();
                
                //Get the Configuration
                    LB_FormConfiguration__mdt formConfig =  LB_FormConfigurationSelector.getFormConfigurationByName(UIParameters.configurationName);  
                
                if(formConfig != null){
                
                    //Prefill the valus calling the proper class or create an empty record
                    
                        List<sObject> prefilledObjects = null;
                                    
                        if(formConfig.PreProcessFormClass__c != null){                        
                           LB_IPreProcessForm preprocessInstance = (LB_IPreProcessForm)Type.forName(formConfig.PreProcessFormClass__c).newInstance(); 
                           prefilledObjects = preprocessInstance.prePropulateObjects(new List<LB_EntityExternalParameters>{UIParameters});   
                        }else{
                           //for now single object generated
                           sObject sObj = Schema.getGlobalDescribe().get(UIParameters.objectType).newSObject() ;
                           prefilledObjects = new List<sObject>{sObj};                        
                        }                    
                        
                    //Get the Schema fields
                        List<Schema.FieldSetMember> fieldSetMemberList =  LB_SchemaMetadataUtil.readFieldSet(formConfig.Field_Set_Name__c,UIParameters.objectType);

                     if(fieldSetMemberList != null && fieldSetMemberList.size() > 0){  
                        for(sObject defaultedObject : prefilledObjects){  
                            for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList){  
                                /*system.debug('API Name ====>' + fieldSetMemberObj.getFieldPath()); //api name
                                system.debug('Label ====>' + fieldSetMemberObj.getLabel());
                                system.debug('Required ====>' + fieldSetMemberObj.getRequired());
                                system.debug('DbRequired ====>' + fieldSetMemberObj.getDbRequired());
                                system.debug('Type ====>' + fieldSetMemberObj.getType());   //type - STRING,PICKLIST/*/
                                
                                LB_EntityFromUIMetadata UiMetadata = new LB_EntityFromUIMetadata();
                                
                                UiMetadata.fieldApiName   = fieldSetMemberObj.getFieldPath();
                                UiMetadata.fieldtype 	  = fieldSetMemberObj.getType()+'';
                                UiMetadata.fieldLabel     = fieldSetMemberObj.getLabel();
                                UiMetadata.fieldValue     = (String)defaultedObject.get(fieldSetMemberObj.getFieldPath());
                                UiMetadata.required 	  = fieldSetMemberObj.getDbRequired() || fieldSetMemberObj.getRequired();               
                                                                                                            
                                listData.add(UiMetadata);                                      
                            
                            }
                        }
                        
                        //Prepare Outcome
                            processOutCome.isValid = true;
                            processOutCome.errorTittle = null;
                            processOutCome.errorMessage = null;
                            processOutCome.metadataInfo = listData;  
                         
                    }else{
                        processOutCome.isValid = false;
                        processOutCome.errorTittle = 'Form Builder Error';
                        processOutCome.errorMessage = 'Field set no found ' + formConfig.Field_Set_Name__c;
                        processOutCome.metadataInfo = null;     
                    }
                    
                }else{
                    
                    system.debug(':LB_FormBuilderController: - getFormData - formConfig is empty');
                    
                }   
                            
                
                
            }else{
                
                processOutCome.isValid = false;
                processOutCome.errorTittle = 'Missing Preprocess Parameters';
                processOutCome.errorMessage = 'Missing Items ' + (String.isBlank(UIParameters.configurationName) ? ' + Configuration Name ' : '') + 
                                                                 (String.isBlank(UIParameters.objectType) ? ' + Object type ' : '');
                processOutCome.metadataInfo = null; 
                
            }    
                             
        }catch(exception e){
            system.debug(':LB_FormBuilderController: - getFormData - exception '+ e.getMessage() + ' ' + e.getStackTraceString());
            processOutCome.isValid = false;
            processOutCome.errorTittle = 'Exception';
            processOutCome.errorMessage =  e.getMessage();
            processOutCome.metadataInfo = null; 
            
        }
        
        return processOutCome;    
        
    }
    

}