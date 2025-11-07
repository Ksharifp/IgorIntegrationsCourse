// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents
/*
string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);
*/
Contact customer = new Contact();

customer.FirstName = 'Jakarta';
customer.LastName = 'Jordan';
customer.Phone = '(888) 999-0096';
customer.email = 'kh.sh.2002@gmail.com';
customer.Description = 'Stripe Customer 6';

insert customer; 

Week2_Post_Stripe.createStripeCustomer(customer.Id);