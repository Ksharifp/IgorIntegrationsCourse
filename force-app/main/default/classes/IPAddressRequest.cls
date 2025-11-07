public with sharing class IPAddressRequest {
    private static final String ENDPOINT = 'https://735ef563-176d-431c-85ce-2cc07056ef03.mock.pstmn.io/payments/link';
    
    public class IPAddressResponse {
        public String ipAddress;
        public String status;
        public String message;
    }
    
    public static IPAddressResponse getTransactionIPAddress() {
        IPAddressResponse response = new IPAddressResponse();
        
        try {
            
            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT);
            request.setMethod('GET');
            
            Http http = new Http();
            HttpResponse httpResponse = http.send(request);
            
            if (httpResponse.getStatusCode() == 200) {
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(httpResponse.getBody());
                
                response.ipAddress = String.valueOf(responseMap.get('IP'));
                response.status = 'SUCCESS';
                response.message = 'IP Address retrieved successfully';
            } else {
                response.status = 'ERROR';
                response.message = 'HTTP Request failed with status code: ' + httpResponse.getStatusCode();
            }
        } catch (Exception e) {
            response.status = 'ERROR';
            response.message = 'Error: ' + e.getMessage();
        }
        
        return response;
    }
}