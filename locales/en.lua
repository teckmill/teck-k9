local Translations = {
    error = {
        not_authorized = 'You are not authorized to use K9',
        no_k9_spawned = 'You need to spawn your K9 first',
        no_target = 'No valid target found',
        too_far = 'Target is too far away',
        already_spawned = 'You already have a K9 spawned',
    },
    success = {
        k9_spawned = 'K9 unit spawned',
        k9_dismissed = 'K9 unit dismissed',
        k9_attacking = 'K9 is attacking target',
        k9_searching = 'K9 is searching',
        k9_following = 'K9 is following',
        k9_staying = 'K9 is staying',
        contraband_found = 'K9 indicates presence of contraband!',
        no_contraband = 'K9 found nothing suspicious',
    },
    info = {
        k9_command_help = 'Usage: /k9 [spawn/dismiss/attack/search/follow/stay]',
    }
}

if GetConvar('qb_locale', 'en') == 'en' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
