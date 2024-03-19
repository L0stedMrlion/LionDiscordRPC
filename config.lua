Config = {
    UpdateTime = 60,
    Framework = "ESX", -- Change to "QBCORE" if using QBCore framework
    Strings = {
        Male = "Male",
        Female = "Female",
        Dead = "Dead",
        Loading = "Loading",
    },
    Text = "{ServerPlayers} - {PlayerName} - {PlayerCharacterJob} - {PlayerCharacterHealth}", -- Customize your Discord status text here
    ApplicationID = "YOUR_DISCORD_APP_ID", -- Replace with your Discord application ID
    Assets = {
        BigAsset = { ID = "big_asset_id", Text = "Big Asset Text" }, -- Replace with your big asset details
        SmallAsset = { ID = "small_asset_id", Text = "Small Asset Text" }, -- Replace with your small asset details
    },
    Buttons = {
        FirstButton = { Enabled = true, Text = "Button 1", Link = "https://example.com" }, -- Customize your first button
        SecondButton = { Enabled = true, Text = "Button 2", Link = "https://example.com" }, -- Customize your second button
    }
}
