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
            
            //Hide spinner            
            var spinner = component.find("fieldLoadingSpinner");
        	//$A.util.toggleClass(spinner, "slds-hide");
        	$A.util.addClass(spinner, 'slds-hide');
            
            if (state === "SUCCESS") {                
                
                helper.debugObject("From server: " , response.getReturnValue()); 
                
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
                    helper.displaymessage(component,res.errorTittle, res.errorMessage , "error");
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
                helper.displaymessage(component,"Error",errorMessage, "error");                
                
            }else{
                
               helper.fireToast("INCOMPLETE","Server Side State = " + state, "error");
                
            }
        });
      
        $A.enqueueAction(action);   
    
	},
    
    //Generic message
    
    	displaymessage : function(component, title, message, type) {    
            /*component.find('notifLib').showNotice({
                "variant": type,
                "header": title,
                "message": message,
                closeCallback: function() {
                    alert('You closed the alert!');
                }
            });*/
            
            component.set("v.messageType", type );
            component.set("v.message",  message );
            component.set("v.messageTitle", title );
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
            
        },
    
    //Serialize the object and display in the console
        debugObject : function(message, object) {        
            var myJSON = JSON.stringify(object);
    		console.log(message+myJSON);            
        }
})