trigger ProbabilityTrigger on Opportunity (before insert, before update) {
    for (Opportunity opportunity : Trigger.New) {
        if (opportunity.Amount <= 15000)
            opportunity.Amount = opportunity.ExpectedRevenue;
    }

}