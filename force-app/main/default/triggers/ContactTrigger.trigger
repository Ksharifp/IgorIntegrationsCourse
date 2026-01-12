trigger ContactTrigger on Contact (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        List<Id> contactIds = new List<Id>();
        for (Contact c : Trigger.new) {
            contactIds.add(c.Id);
        }
        System.enqueueJob(new PostDMLQueueable(contactIds));
    }
}