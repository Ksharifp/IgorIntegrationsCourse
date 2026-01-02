public class PostDMLQueueable implements Queueable, Database.AllowsCallouts{
    //assuming no more than 100 contacts are being insterted
    //define a list to get the contacts from the trigger 
    private List <Id> contactIds;

    //define the constructor to get the list of contacts from the trigger
    public PostDMLQueueable(List<Id> contactIds) {
        this.contactIds = contactIds;
    }

    public void execute (QueueableContext context)   {
        // Initiating request
        Http http = new Http();

        List<Contact> contacts = [SELECT Id, Email, FirstName, LastName, Phone, Description FROM Contact WHERE Id IN :contactIds];

        for (Contact contact : contacts) {
            try {
                String body = 'email=' + EncodingUtil.urlEncode(contact.Email, 'UTF-8') +
                          '&name=' + EncodingUtil.urlEncode(contact.FirstName + ' ' + contact.LastName, 'UTF-8');
                          
                if (String.isNotBlank(contact.Phone)) {
                body += '&phone=' + EncodingUtil.urlEncode(contact.Phone, 'UTF-8');}

                if (String.isNotBlank(contact.Description)) {
                body += '&description=' + EncodingUtil.urlEncode(contact.Description, 'UTF-8');}

                //initialize http request
                HttpRequest request = new HttpRequest();
                request.setEndpoint ('https://api.stripe.com/v1/customers');
                request.setMethod ('POST');
                request.setHeader ('Content-Type', 'application/x-www-form-urlencoded');
                request.setHeader ('Authorization', 'Bearer sk_test_51SPbrHFjhktOljT6TXYjybNZR02vcSLe8wLoNjkBGoO8dcu5txOstL0m4gZIxcTd1ZJJqIExW72AcosloNhzn5gt00dbBk0V8G');
                request.setBody (body);

                //send http request
                HttpResponse response = http.send(request);

                if (response.getStatusCode() == 200 || response.getStatusCode() == 201) {
                    System.debug('Successfully created Stripe customer for contact: ' + contact.Id);
                } else {
                    System.debug('Stripe API error for Contact ' + contact.Id + ': ' + response.getStatusCode() + ' ' + response.getStatus());

                    ErrorLogger.logError(
                        'Stripe API returned status ' + response.getStatusCode(),
                        'Contact Id: ' + contact.Id + ' , response: ' + response.getBody(),
                        'PostDMLQueueable',
                        'CalloutException',
                        ''
                    );
                }
            } catch (Exception ex) {
                System.debug('Error creating Stripe customer for contact: ' + contact.Id + ' ' + ex.getMessage());
                ErrorLogger.logError(ex);
            } 
        }  
    }
}