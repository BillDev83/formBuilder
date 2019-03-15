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

    //handle the fire toast and call the helper
    doFireToast : function(component, event, helper) {
        var params = event.getParam('arguments');
        var title = params.title;
        var message = params.message;
        var type = params.type;
        helper.fireToast(title,message,type);
    },
    //handle the debug and call the helper
    doJsdebugObject : function(component, event, helper) {
        var params = event.getParam('arguments');
        var message = params.message;
        var object = params.object;      
        helper.debugObject(message,object);
    },
})
