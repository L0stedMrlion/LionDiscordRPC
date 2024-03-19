SetConvarReplicated("sv_maxclients", "true")

if Config.Updater then
    PerformHttpRequest("https://raw.githubusercontent.com/L0stedMrlion/versions/master/LionRPC", function(err, Version, headers)

        local ScriptVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
    
        if GetResourceMetadata(GetCurrentResourceName(), "version") == Version then
            print("^2[INFO] LionRPC is running on latest")
        else
            print("^3[UPDATE] LionRPC have a new version! ("..ScriptVersion.. " -> " ..Version..")")
            print("^3[UPDATE] https://github.com/L0stedMrlion/LionRPC")
        end
    end)
end