/*
*  Developer Name: Amruta Jadhav
*  Created at : 19/09/2023
*  Purpose : This class is used to send the data to NPS API and on sucessful response send email notification to the user.
*  Test class name :  clsNPSIntegrationTest 
*/
public class clsNPSIntegration {
    @future(callout=true) 
    public static void sendDataToNPSAPI (string orderNumber , string email ){
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:NPS_Integration/orders');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody('{"orderNumber":"' + orderNumber + '" , customerEmail: "'+email+'"}');
            HttpResponse response = http.send(request);
            System.debug('response.getStatusCode() ::'+response.getStatusCode());
            
            string responseMessage ;
            if (response.getStatusCode() == 200) {
                responseMessage ='Successful response: ' + response.getBody();
                sendEmail(orderNumber ,email);
                
            } else {
                responseMessage='Error response: ' + response.getStatusCode() + ' ' + response.getStatus();
            }
            system.debug('responseMessage ::'+ responseMessage);
        }
        catch(Exception ex){
            system.debug('NPS Integration Exception ::'+ ex.getMessage() + ' Error caused at line number ::'+ex.getLineNumber() +'More Information ::'+ ex.getStackTraceString());
        }
    }
    
    public static void sendEmail(String orderNumber , string useremail){       
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toaddresses = new String[] {useremail}; 
            mail.setToAddresses(toaddresses);
            mail.setSenderDisplayName('NPS Integration :' + orderNumber);
            mail.setSubject('NPS Integration :'+ orderNumber);
            mail.setPlainTextBody('NPS Integration done sucessfully for OrderNumber - '+orderNumber +'');
            mail.setHtmlBody('<p>NPS Integration done sucessfully for OrderNumber - '+orderNumber +'</p>');
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            system.debug(useremail);
        }
        catch(Exception ex){
            system.debug('NPS Integration Send Email Exception ::'+ ex.getMessage() + ' Error caused at line number ::'+ex.getLineNumber() +'More Information ::'+ ex.getStackTraceString());
        }
    }
}