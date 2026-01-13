public with sharing class Task3Find_CustomerTestMock implements HttpCalloutMock{
    
    public HTTPResponse respond(HTTPRequest req) {
    //the response might be from a get or a post to create or update
    //we need to check which response we have so that the mock can give the correct response
        String endpoint = req.getEndpoint();
        String method = req.getMethod();
        String foundCustomerBody = '{"data": [{"id": "cus_test123", "email": "test@test.com"}]}';
        String notFoundCustomerBody = '{"data": []}';  // Empty array

        if (endpoint.contains('search?query') && method == 'GET') { 
            HttpResponse response = new HttpResponse();
            response.setHeader('Content_Type', 'application/json');
            response.setBody(foundCustomerBody);
        } else {
            return null;
        }

        if (endpoint.contains('/customers/') && !endpoint.endsWith('/customers')) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody(foundCustomerBody);
            return response;
        } else {
            return null;
        }
        
        if (endpoint.contains('/customers/') && endpoint.endsWith('/customers')) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody(notFoundCustomerBody);
            return response;
        } else {
            return null;
        }
    }

}
