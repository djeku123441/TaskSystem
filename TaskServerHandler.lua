local expmodule = require(game.ReplicatedStorage.ModuleScripts.TaskModule)
game.Players.PlayerAdded:Connect(function(player)
	game.ReplicatedStorage.Events.PlayerAddedEvent:FireClient(player) --firing an event to notify the client side that a player has been added
	player.CharacterAdded:Connect(function()
		game.ReplicatedStorage.Events.CharacterAddedEvent:FireClient(player)
	end)
end)
game.ReplicatedStorage.Events.ChangeExp.OnServerEvent:Connect(function(player,taskdone)
	print(player)
	print(taskdone)
	if typeof(taskdone) == "string" then -- checking if the parameter is a string
		if taskdone == "First" then -- checking which one of the tasks it is
			print("first")
			player.stats.XP += expmodule.Exp["Play 10 minutes"] -- adding the exp
		elseif taskdone == "Second" then
			print("second")
			player.stats.XP += expmodule.Exp["Play 15 minutes"]
		elseif taskdone == "Third" then
			print("third")
			player.stats.XP += expmodule.Exp["Play 30 minutes"]
		end
	end
end)
