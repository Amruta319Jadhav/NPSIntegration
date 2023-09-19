/*
*  Developer Name: Amruta Jadhav
*  Created at : 19/09/2023
*  Purpose : This is test class clsOrderHandler class. 
*/
@isTest
public class clsOrderHandlerTest {

    @isTest
    static void testReturnOrderData() {
        // Create test data - Orders and related Contacts
        List<Order> testOrders = new List<Order>();
        List<Contact> testContacts = new List<Contact>();
        
        Account testAccount = new Account (Name ='Test Account');
        insert testAccount ;
        
        for (Integer i = 0; i < 5; i++) {
            Contact testContact = new Contact(
                FirstName = 'Test',
                LastName = 'Contact' + i,
                Email = 'testemail' + i + '@example.com'
            );
            testContacts.add(testContact);
            
            Order testOrder = new Order(
                Name = 'Test Order ' + i,
                BillToContactId = testContact.Id,
                AccountId = testAccount.id,
                EffectiveDate = system.today(),
                Status ='Draft'
            );
            testOrders.add(testOrder);
        }
        
        insert testContacts;
        insert testOrders;

        List<Id> orderIds = new List<Id>();
        for (Order order : testOrders) {
            orderIds.add(order.Id);
        }
        
        Test.startTest();
        List<clsOrderHandler.ReturnOrderVariables> result = clsOrderHandler.returnOrderData(orderIds);
        Test.stopTest();
        
        System.assertNotEquals(null, result, 'Result should not be null');
        clsOrderHandler.ReturnOrderVariables returnOrderVars = result[0];
        
        System.assertNotEquals(null, returnOrderVars.OrderNumber, 'OrderNumber should not be null');
        System.assertNotEquals(null, returnOrderVars.EmailAddress, 'EmailAddress should not be null');
        System.assertEquals(testOrders.size(), returnOrderVars.OrderNumber.size(), 'OrderNumber list size should match the number of orders');
        System.assertEquals(testOrders.size(), returnOrderVars.EmailAddress.size(), 'EmailAddress list size should match the number of orders');
    }
}