public with sharing class ErrorLogger {
    public static void logError(
        String message,
        String comment,
        String contextType,
        String errorClass,
        String stackTrace
    ) {
       Log_Entry__c logEntry = new Log_Entry__c();
       LogEntry.Error_Message__c = message;
       LogEntry.Comment__c = comment;
       LogEntry.Context_Type__c = contextType;
       LogEntry.Error_Class__c = errorClass;
       LogEntry.Stack_Trace__c = stackTrace;
       
       insert logEntry;
    }

    //overload your method to make sure you get all exceptions
    public static void logError(Exception exceptionToLog) {
        logError(
            exceptionToLog.getMessage(),
            String.valueOf(exceptionToLog.getLineNumber()),
            '',
            '',
            exceptionToLog.getStackTraceString()
        );
    }
}