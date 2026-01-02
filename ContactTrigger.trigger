trigger ContactTrigger on Contact (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        System.enqueueJob(new PostDMLQueueable(Trigger.new));
    }
}