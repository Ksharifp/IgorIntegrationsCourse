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
public with sharing class IPAddressRequestTest {

    @isTest
    static void IPAddressReceiptTest() {
        // TO DO: implement unit test
        // We need to create a mock class and implement its methods to hard code the response so that
        // you do not rely on the changing data from the external server
        String expectedIPAddress = '167.247.142.173';

        Test.setMock(HttpCalloutMock.class, new IPAddressRequestTestMock());

        Test.startTest();
        IPAddressRequest.IPAddressResponse response = IPAddressRequest.getTransactionIPAddress();
        Test.stopTest();    

        Assert.areEqual(expectedIPAddress, response.ipAddress, 'The IP Address should be ' + expectedIPAddress);
    
    }
}