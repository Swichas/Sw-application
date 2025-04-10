local Translations = {
    char = {
        name = 'Vardas',
        name_placeholder = 'Vardenis',
        lastname = 'Pavardė',
        lastname_placeholder = 'Pavardenis',
        phone = 'Telefonas',
        phone_placeholder = 'Numeris...',
        areready = 'Ar pasiruošes...',
        year = 'Gimtadienis...',
        letter = 'Laiškas',
    },
    notify = {
        anket = 'Darbo anketos',
        succefulapli = 'Anketa pateikta',
        cooldown = 'Turi palaukti prieš pildydamas kita anketa',

    },
    bossmenu = {
            noaplication = "Šiuo metu nėra jokių aplikacijų",
            yes = "Taip",
            no = "Ne",
            context = "Vardas : %s , Pavardė : %s , Metai :%s , Telefonas : %s , Ar pasiruošes : %s , Laiškas : %s // Spauskite norėdami ištrinti",
            aresure = "Ar tikrai norite ištrinti?",
            aresure2 = 'Aplikacija bus ištrinta visam laikui!',
            areusureyes = "Taip, ištrinti",
            areusureno = "Ne, atšaukti",
            conexttable = "Bosso menu aplikacijos",
            deltionyes = "Aplikacija ištrinta sėkmingai!",
            deltionno = "Aplikacija ištrinta sėkmingai!"

    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})