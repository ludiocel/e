   game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.Started then
            syn.queue_on_teleport("teleport()")
        end
    end)

    local usernames = {"MilongVerrater","LuciferVerrater", "0ds7", "workera"}
    
    function chat(message)
       game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
    
    function getPlayer(shortcut)
        local player = nil
      
        local g = game.Players:GetPlayers()
        for i = 1, #g do
          if string.lower(string.sub(g[i].Name, 1, string.len(shortcut))) == string.lower(shortcut) then
            player = g[i]
            break
          end
        end
      
        return player
      
    end
    
    function indexOf(t, value)
      for i, v in ipairs(t) do
        if v == value then
          return i
        end
      end
      return nil
    end
    
    -- Get the players corresponding to the usernames
    local players = {}
    
    for i, username in ipairs(usernames) do
        local player = game.Players:FindFirstChild(username)
        if player then
            table.insert(players, player)
        end
    end
    
    rconsoleprint(unpack(usernames))
    
    local ownerName = "stopmen"
    local plr = game:GetService("Players"):FindFirstChild(ownerName)
    
    local function onChatted(msg)
        if msg:lower() == "line" then
            local x = plr.Character.HumanoidRootPart.Position.X
            local y = plr.Character.HumanoidRootPart.Position.Y
            local z = plr.Character.HumanoidRootPart.Position.Z
            for i, player in ipairs(players) do
                player.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position + plr.Character.HumanoidRootPart.CFrame.lookVector)
                player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
                x = x + 5
            end
        elseif msg:lower() == "index" then
            chat("Index "..indexOf(usernames, game.Players.LocalPlayer.Name))
        elseif msg:lower() == "rejoin" then
            game:GetService("TeleportService"):Teleport(game.PlaceId)
            
            
        end
    end
    
    if plr then
      plr.Chatted:Connect(onChatted)
    end
    
    game:GetService("Players").PlayerAdded:Connect(function(plr)
      if plr.Name == ownerName then
        plr.Chatted:Connect(onChatted)
      end
    end)
