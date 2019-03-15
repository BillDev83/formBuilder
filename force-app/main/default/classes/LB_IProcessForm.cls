/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Entity class to carry the info that is pass form UI to the Processing class. 
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

************************************************************************************************************************************/
public interface LB_IProcessForm {
        
    List<LB_EntityProcessOutcome> validateRecords(List<sObject> records); 
    
    List<LB_EntityProcessOutcome> saveRecords(List<sObject> records); 
    
}