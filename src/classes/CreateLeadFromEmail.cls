global class CreateLeadFromEmail implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
    // Create an InboundEmailResult object for returning the result of the  
    // Apex Email Service 
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    String myPlainText= '';

    // Add the email plain text into the local variable  
    myPlainText = email.plainTextBody;

    Lead newLead = new Lead(Email = email.fromAddress, 
        LastName = email.fromName, 
        Company = email.fromName,
        Description = email.plainTextBody
        );

    Database.DMLOptions dmo = new Database.DMLOptions();

    dmo.assignmentRuleHeader.useDefaultRule = true;

    newLead.setOptions(dmo);

    // Insert a new lead
    insert newLead; 

    // Set the result to true. No need to send an email back to the user      
    // with an error message   
    result.success = true;

    // Return the result for the Apex Email Service 
    return result;
  }
}