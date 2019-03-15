/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : 
Author              : William Lopez, william.salesforce@gmail.com - @BillSalesforce
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/14/2019        Original Version

MIT License

Copyright (c) 2019 William Lopez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

************************************************************************************************************************************/

({
    
    /**
     * Load the metadata from the server
     **/
    loadDefaultValeus : function (component, event, helper){
    	
     	//Get parameters
        	var recordId = component.get("v.recordId");        	
        	var objectType = component.get("v.objectType");
            var configurationName = component.get("v.configurationName");
            var formUtils = component.find("formUtils");
            
        
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
                
                formUtils.debugObject("From server: " , response.getReturnValue()); 
                
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
                    formUtils.displaymessage(component,res.errorTittle, res.errorMessage , "error");
                }

                
            }else if (state === "ERROR") {
                
                var errorMessage = "Unknown error";
                
                var errors = response.getError();                
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                    }
                }                
                formUtils.fireToast("Error",errorMessage, "error");
                helper.displaymessage(component,"Error",errorMessage, "error");                
                
            }else{
                
                formUtils.fireToast("INCOMPLETE","Server Side State = " + state, "error");
                
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
    
  
})