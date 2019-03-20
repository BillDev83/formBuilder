/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Example of an LB_IPreProcessForm implementation
Author              : William Lopez, william.salesforce@gmail.com
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
public with sharing class EX_ContactExampleProcessor implements LB_IPreProcessForm, LB_IProcessForm {
    
    
    /**
     * Prepopulate contact Info from LB_IPreProcessForm
     * This method will be call it from the controller so we pre-propulate values before show to the customer for editing
     * 2019-03-15
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

/******************************************  LB_IProcessForm   ***********************************************************/

    /**
      * Validate recrods would be invoke before saving, here we should place any custom validation logic
      *
      **/
    public List<LB_EntityProcessOutcome> validateRecords(List<Contact> records){

        LB_EntityProcessOutcome outCome = new LB_EntityProcessOutcome();
           
           //perform any business logic
           for(Contact cont: records){

                 //as An example lest add a simple validation ... this will normally would go as a validation rule. Just an example
                if(String.isEmpty(cont.phone) || !cont.phone.contains('514')){
                    outCome.isValid = false;
                    outcome.record = cont;
                    outcome.errorTittle  =  'Contact Phone is not valid';
                    outcome.errorMessage =  'Phone must be not empty and it should start containt 514';
                }

           } 

        return new List<LB_EntityProcessOutcome>{outCome};   

    } 

    /**
      * Validate recrods would be invoke before saving, here we should place any custom validation logic
      *
      **/
    public List<LB_EntityProcessOutcome> saveRecords(List<Contact> records){

           LB_EntityProcessOutcome outCome = new LB_EntityProcessOutcome();

           //Simple save with no extra logic, but here we can inject values to the records (same values that we normally delegate to triggers)
            for(Contact cont: records){
                cont.Title = 'Business';
            } 

            insert records;


           return null; 

    }

/******************************************  PENDING post processing   ***********************************************************/

}