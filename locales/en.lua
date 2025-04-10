local Translations = {
    char = {
        name = 'Name',
        name_placeholder = 'First Name',
        lastname = 'Surname',
        lastname_placeholder = 'Last Name',
        phone = 'Phone',
        phone_placeholder = 'Number...',
        areready = 'Are you ready...',
        year = 'Year of Birth...',
        letter = 'Letter',
    },
    notify = {
        anket = 'Job Applications',
        succefulapli = 'Application submitted successfully',
        cooldown = 'You must wait before submitting another application',
    },
    bossmenu = {
        noaplication = "There are currently no applications",
        yes = "Yes",
        no = "No",
        context = "Name: %s , Surname: %s , Year: %s , Phone: %s , Are you ready: %s , Letter: %s // Click to delete",
        aresure = "Are you sure you want to delete?",
        aresure2 = 'The application will be permanently deleted!',
        areusureyes = "Yes, delete",
        areusureno = "No, cancel",
        conexttable = "Boss menu applications",
        deltionyes = "Application successfully deleted!",
        deltionno = "Application successfully deleted!"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
