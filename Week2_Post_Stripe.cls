public with sharing class Week2_Post_Stripe {
/*
        //encoding saleforce data for Stripe
        String body = 'email=' + EncodingUtil.urlEncode(contact.Email, 'UTF-8') +
                  '&name=' + EncodingUtil.urlEncode(contact.FirstName + ' ' + contact.LastName, 'UTF-8');
        
        //adds phone if it exists
        if (String.isNotBlank(contact.Phone)) {
            body += '&phone=' + EncodingUtil.urlEncode(contact.Phone, 'UTF-8');
        }
        
        //adds description if it exists 
        if (String.isNotBlank(contact.Description)) {
            body += '&description=' + EncodingUtil.urlEncode(contact.Description, 'UTF-8');
        }
        
        //initialize http request
        HttpRequest request = new HttpRequest();
        request.setEndpoint ('https://api.stripe.com/v1/customers');
        request.setMethod ('POST');
        request.setHeader ('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader ('Authorization', 'Bearer sk_test_51SPbrHFjhktOljT6TXYjybNZR02vcSLe8wLoNjkBGoO8dcu5txOstL0m4gZIxcTd1ZJJqIExW72AcosloNhzn5gt00dbBk0V8G');
        request.setBody (body);

        //send http request
        Http http = new Http();
        HttpResponse response = http.send(request);

        System.debug('response body'+ response.getBody());
        System.debug('status code'+ response.getStatusCode());
        System.debug('status'+ response.getStatus());
    }*/
}
