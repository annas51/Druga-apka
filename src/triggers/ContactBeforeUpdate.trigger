trigger ContactBeforeUpdate on Contact (before update){
    for(Contact contact:Trigger.new){
        contact.Description='Contact updated succesfully by' + userInfo.getUserName();
    }

}