local Config = require('../config')
SetConvarReplicated("sv_maxclients", "true")

if Config.Updater then
    PerformHttpRequest("https://raw.githubusercontent.com/L0stedMrlion/versions/master/LionRPC", function(err, Version, headers)
        if Version then
            local ScriptVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
            Version = tonumber(Version)

            if tonumber(ScriptVersion) == Version then
                print("^2[INFO] LionRPC is running on the latest version")
            else
                print("^3[UPDATE] LionRPC has a new version! (" .. ScriptVersion .. " -> " .. Version .. ")")
                print("^3[UPDATE] https://github.com/L0stedMrlion/LionRPC")
            end
        else
            print("^1[ERROR] Failed to retrieve version information.")
        end
    end)
else
    print("^1[WARNING] Updater is disabled in the Config.")
end
