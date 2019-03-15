/***********************************************************************************************************************************
Created Date        : 03/08/2019
Function            : Entity class to carry the info after a record was Post Processed (normally a redirect)
Author              : William Lopez, william.salesforce@gmail.com
Modification Log    :
* Developer                Date                 Description
* ----------------------------------------------------------------------------                 
* William Lopez           03/08/2019        Original Version

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