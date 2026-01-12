public with sharing class IPAddressRequestTestMock implements HttpCalloutMock{
    public static final String Mock_Body = '{"IP": "167.247.142.173"}';


    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(Mock_Body);
        response.setStatusCode(200);
        return response;
    }
}