/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class Task3Find_CustomerTest {

    @isTest
    static void customerFoundTest() {
        Contact existingCon = new Contact();
        existingCon.Email = 'test@test.com';
        existingCon.FirstName = 'Test1';
        existingCon.LastName = 'Test1';
        insert existingCon;
    

    Test.setMock(HttpCalloutMock.class, new Task3Find_CustomerTestMock(true));

    Test.startTest();
    Task3Find_Customer task = new Task3Find_Customer(new List<Id> { existingCon.Id });
    System.enqueueJob(task);
    Test.stopTest();

    Contact customer = [SELECT Id, Email FROM Contact WHERE Id = :existingCon.Id];
    System.assertNotEquals(null, customer, 'Contact should still exist after processing');
    
    }

    @isTest
    static void customerNotFoundTest() {
        Contact existingCon = new Contact();
        existingCon.Email = 'test@test.com';
        existingCon.FirstName = 'Test1';
        existingCon.LastName = 'Test1';
        insert existingCon;
    

    Test.setMock(HttpCalloutMock.class, new Task3Find_CustomerTestMock(false));

    Test.startTest();
    Task3Find_Customer task = new Task3Find_Customer(new List<Id> { existingCon.Id });
    System.enqueueJob(task);
    Test.stopTest();

    Contact customer = [SELECT Id, Email FROM Contact WHERE Id = :existingCon.Id];
    System.assertNotEquals(null, customer, 'Contact should still exist after processing');
    
    }

}