public with sharing class Task3Find_Customer implements Queueable, Database.AllowsCallouts {
    private List <Id> contactIds;
    private String apiKey = 'sk_test_51SPbrHFjhktOljT6TXYjybNZR02vcSLe8wLoNjkBGoO8dcu5txOstL0m4gZIxcTd1ZJJqIExW72AcosloNhzn5gt00dbBk0V8G';

    public Task3Find_Customer(List<Id> contactIds) {
        this.contactIds = contactIds;
    }

    public void execute(QueueableContext context) {
        Http http = new Http();

        List<Contact> contactsToFind = [
            SELECT Id, Email, FirstName, LastName, Phone, Description
            FROM Contact
            WHERE Id IN : contactIds
        ];

        If (contactsToFind.isEmpty()) {
            return;
        }

        for (Contact contact : contactsToFind) {
            
            String contactEmail = 'email:\'' + contact.Email + '\'';

            String encodedQuery = EncodingUtil.urlEncode(contactEmail, 'UTF-8');

            HttpRequest searchRequest = new HttpRequest();
            searchRequest.setEndpoint('https://api.stripe.com/v1/customers/search?query=' + encodedQuery);
            searchRequest.setMethod('GET');
            searchRequest.setHeader('Authorization', 'Bearer ' + apiKey);

            HttpResponse searchResponse = http.send(searchRequest);

            String existingCustomerId = null;

            if (searchResponse.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(searchResponse.getBody());
                List<Object> customers = (List<Object>) jsonResponse.get('data');
    
                if (customers != null && !customers.isEmpty()) {
                    // Customer exists! Get the ID
                    Map<String, Object> customer = (Map<String, Object>) customers[0];
                    existingCustomerId = (String) customer.get('id');
                }
            }

            if (existingCustomerId != null) {
                //update existing
                String updateBody = 'email=' + EncodingUtil.urlEncode(contact.Email, 'UTF-8') + 
                                    '&name=' + EncodingUtil.urlEncode(contact.FirstName + ' ' + contact.LastName, 'UTF-8');

                if (String.isNotBlank(contact.Phone)) {
                    updateBody += '&phone=' + EncodingUtil.urlEncode(contact.Phone, 'UTF-8');
                }   

                if (String.isNotBlank(contact.Description)) {
                    updateBody += '&description=' + EncodingUtil.urlEncode(contact.Description, 'UTF-8');
                }

                //initialize http request
                HttpRequest request = new HttpRequest();
                request.setEndpoint ('https://api.stripe.com/v1/customers/' + existingCustomerId);
                request.setMethod ('POST');
                request.setHeader ('Content-Type', 'application/x-www-form-urlencoded');
                request.setHeader ('Authorization', 'Bearer ' + apiKey);
                request.setBody (updateBody);

                HttpResponse updateResponse = http.send(request);
    
            } else {
                    // CREATE new customer
                    String createBody = 'email=' + EncodingUtil.urlEncode(contact.Email, 'UTF-8') +
                                    '&name=' + EncodingUtil.urlEncode(contact.FirstName + ' ' + contact.LastName, 'UTF-8');
                    
                    if (String.isNotBlank(contact.Phone)) {
                        createBody += '&phone=' + EncodingUtil.urlEncode(contact.Phone, 'UTF-8');
                    }
                    
                    if (String.isNotBlank(contact.Description)) {
                        createBody += '&description=' + EncodingUtil.urlEncode(contact.Description, 'UTF-8');
                    }
                    
                    HttpRequest createRequest = new HttpRequest();
                    createRequest.setEndpoint('https://api.stripe.com/v1/customers');
                    createRequest.setMethod('POST');
                    createRequest.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                    createRequest.setHeader('Authorization', 'Bearer sk_test_...');
                    createRequest.setBody(createBody);
                    
                    HttpResponse createResponse = http.send(createRequest);
                    
            }
        }
    }
}