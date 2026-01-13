public with sharing class Task3Find_CustomerTestMock implements HttpCalloutMock{
    
    private Boolean customerExists;

    public Task3Find_CustomerTestMock(Boolean customerExists) {
        this.customerExists = customerExists;
    }

    public HTTPResponse respond(HTTPRequest req) {
    //the response might be from a get and post(create) or get and post(update)
    //we need to check which response we have so that the mock can give the correct response
    //to allow the test to decide whether to test the scenarion where the customer is found or not found
    //I am using the boolean variable customerExists

        String endpoint = req.getEndpoint();
        String method = req.getMethod();
        String foundCustomerBody = '{"data": [{"id": "cus_test123", "email": "test@test.com"}]}';
        String notFoundCustomerBody = '{"data": []}';  // Empty array
        String updateResponseBody = '{"id": "cus_test123", "object": "customer"}';
        String createResponseBody = '{"id": "cus_new456", "object": "customer"}';

        // this.customerExists decides what to return
        if (endpoint.contains('search?query') && method == 'GET') {
            if (this.customerExists) {
                // Return found customer body
                HttpResponse response = new HttpResponse();
                response.setHeader('Content-Type', 'application/json');
                response.setBody(foundCustomerBody);
                response.setStatusCode(200);
                return response;
            } else {
                HttpResponse response = new HttpResponse();
                response.setHeader('Content-Type', 'application/json');
                response.setBody(notFoundCustomerBody);
                response.setStatusCode(200);
                return response;
            }
        }

        // Check for UPDATE
        if (method == 'POST' && endpoint.contains('/customers/') && !endpoint.endsWith('/customers')) {
            // Return update response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody(foundCustomerBody);
            response.setStatusCode(200);
            return response;
        }

        // Check for CREATE  
        if (method == 'POST' && endpoint.endsWith('/customers')) {
            // Return create response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody(notFoundCustomerBody);
            response.setStatusCode(200);
            return response;
        }
    }
}
