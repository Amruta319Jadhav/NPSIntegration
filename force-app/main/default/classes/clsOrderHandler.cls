/*
*  Developer Name: Amruta Jadhav
*  Created at : 19/09/2023
*  Purpose : This class is used to retrive the order data and invoke/send the data to NPS API.
*  Test class name :  clsNPSIntegrationTest 
*/
public class clsOrderHandler {
    
    @InvocableMethod
    public static List<ReturnOrderVariables> returnOrderData(List<Id> ids){
        
        Map<Id, Order>  orderMap = new Map<Id, Order>();
        List<String> orderNumbers = new List<String>();
        List<String> emailAddresss = new List<String>();
        List<ReturnOrderVariables> returnOrderVarList = new  List<ReturnOrderVariables>();
        ReturnOrderVariables returnOrderVars = new  ReturnOrderVariables();
     
        for(Order order : [SELECT Id, OrderNumber,BillToContact.Email FROM Order WHERE Id =: ids]){
            orderMap.put(order.Id ,order) ;
        }
        
        if(!orderMap.isEmpty()){
            for(Order order : orderMap.values()){
                clsNPSIntegration.SendDataToNPSAPI(order.OrderNumber ,order.BillToContact.Email);
                orderNumbers.add(order.OrderNumber);
                emailAddresss.add(order.BillToContact.Email);
            }
        }
        
        //Get the output values
        returnOrderVars.OrderNumber = orderNumbers;
        returnOrderVars.EmailAddress = emailAddresss ;
        returnOrderVarList.add(returnOrderVars);
        return returnOrderVarList;    
    }
    
    public class ReturnOrderVariables{
        @InvocableVariable
        public List<String> OrderNumber;  
        @InvocableVariable
        public List<String> EmailAddress;  
    }
 }