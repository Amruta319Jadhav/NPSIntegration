/*
*  Developer Name: Amruta Jadhav
*  Created at : 19/09/2023
*  Purpose : This is test class for class clsNPSIntegration .
*/
@isTest
public class clsNPSIntegrationTest {
    
    // Define a mock response class for the HTTP callout
    public class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"message": "Mock response data"}');
            response.setStatusCode(200);
            return response;
        }
    }
    
    @isTest
    static void testSendDataToNPSAPI() {
        
        // Set the mock callout class
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
     
        // Call the sendDataToNPSAPI method
        Test.startTest();
        clsNPSIntegration.sendDataToNPSAPI('TestOrder123', 'test@example.com');
        Test.stopTest();
    }
}