Config = {}

-- General Settings
Config.Debug = false
Config.UseCommand = true -- Set to false if you want to use items instead
Config.CommandName = 'k9'
Config.RestrictJob = true -- Set to false to allow anyone to use K9
Config.AllowedJobs = {
    ['police'] = true,
    ['bcso'] = true
}

-- K9 Settings
Config.K9Model = 'a_c_shepherd' -- Dog model
Config.SearchTime = 5000 -- Time in ms for search animation
Config.AttackDistance = 15.0 -- Maximum distance for attack command
Config.FollowDistance = 5.0 -- Distance the dog maintains while following

-- K9 Abilities
Config.K9Config = {
    ['attack'] = {
        command = 'attack',
        animation = 'creatures@rottweiler@melee@',
        sound = 'bark'
    },
    ['search'] = {
        command = 'search',
        animation = 'creatures@rottweiler@indication@',
        sound = 'sniff'
    },
    ['follow'] = {
        command = 'follow',
        animation = 'creatures@rottweiler@move',
    },
    ['stay'] = {
        command = 'stay',
        animation = 'creatures@rottweiler@amb@world_dog_sitting@base',
    }
}

-- Items that K9 can detect
Config.DetectableItems = {
    ['weed'] = true,
    ['cocaine'] = true,
    ['meth'] = true,
    ['joint'] = true,
    ['coke_small_brick'] = true,
    ['weapon_pistol'] = true,
    ['weapon_smg'] = true
}

-- Animations
Config.Animations = {
    ['sit'] = {
        dict = 'creatures@rottweiler@amb@world_dog_sitting@base',
        anim = 'base',
        time = -1
    },
    ['laydown'] = {
        dict = 'creatures@rottweiler@amb@sleep_in_kennel@',
        anim = 'sleep_in_kennel',
        time = -1
    },
    ['searchhit'] = {
        dict = 'creatures@rottweiler@indication@',
        anim = 'indicate_high',
        time = 3000
    }
}
