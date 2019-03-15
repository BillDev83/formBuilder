({
    
    /**
     * Load the metadata from the server
     **/
    loadDefaultValeus : function (component, event, helper){
    	
     	//Get parameters
        	var recordId = component.get("v.recordId");        	
        	var objectType = component.get("v.objectType");
        	var configurationName = component.get("v.configurationName");
        
         console.log('Helper recordId = ' + component.get("v.recordId") + ' configurationName = ' + configurationName + ' objectType = ' + objectType);
        
        //Set Controller parameters
        	var LB_EntityFromUIMetadata = {recordId: recordId, configurationName: configurationName, objectType: objectType};
            console.log('LB_EntityFromUIMetadata = ' + LB_EntityFromUIMetadata);
        
        //Set controller call        
	        var action = component.get("c.getFormData");
			action.setParams({UIParameters: LB_EntityFromUIMetadata });
        
        //Prepare the call back
        	// Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {                
                
                console.log("From server: " + response.getReturnValue()); 
                
                var res = response.getReturnValue(); 
                
                if(res.isValid){                    
                    
                	component.set("v.formfieldsData",res.metadataInfo);
                    
                    for(var i = 0; i < res.metadataInfo; i++){
                        console.log('fieldLabel = ' + res.metadataInfo[i].fieldLabel);
                        console.log('fieldtype = ' + res.metadataInfo[i].fieldtype);
                        console.log('fieldValue = ' + res.metadataInfo[i].fieldValue);
                    }
                    
                }else{                    
                    helper.fireToast(res.errorTittle, res.errorMessage , "error");
                }

                
            }else if (state === "ERROR") {
                
                var errorMessage = "Unknown error";
                
                var errors = response.getError();                
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                    }
                }                
                helper.fireToast("Error",errorMessage, "error");
                
            }else{
                
               helper.fireToast("INCOMPLETE","Server Side State = " + state, "error");
                
            }
        });
      
        $A.enqueueAction(action);   
    
	},
    
    //Generic Toast Generator
        fireToast : function(title, message, type) {        
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                    "title": title,
                            "duration": 10000,
                            "type":type,
                    "message": message
                });
            
            toastEvent.fire();              
            
        }
})