/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Generic class to use the schema
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

************************************************************************************************************************************/
public with sharing class LB_SchemaMetadataUtil {
    
    
    /**
	* @Name          readFieldSet
	* @Description   Given a Fieldset and an Object Name, it will return the memebers of that fieldset in a List
	* @Author        william.salesforce@gmail.com
	* @CreatedDate   2019-03-08
	*/
    public static List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName){
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        
        //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));
        
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        
        //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
    	//system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
    	return fieldSetObj.getFields(); 
	} 
    
      

}