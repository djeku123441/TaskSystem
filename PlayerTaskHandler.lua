wait()
local events = {
	["PlayerAdded"] = game.ReplicatedStorage.Events.PlayerAddedEvent,
	["ChangeExp"] = game.ReplicatedStorage.Events.ChangeExp,
	["CharacterAdded"] = game.ReplicatedStorage.Events.CharacterAddedEvent
}
local player = game.Players.LocalPlayer
local mainUI = player.PlayerGui:WaitForChild("MainTaskUI")
local enabled = false
local taskenabled = true
local tasks = {
	["Task1"] = "Play 10 minutes",
	["Task2"] = "Play 15 minutes",
	["Task3"] = "Play 30 minutes"
}
local taskscompleted = {
	["Task1"] = false,
	["Task2"] = false,
	["Task3"] = false
}
local day = 0
local timefortask = 0
local function changetasks(task1,task2,task3)
	print("debug: changetasks")
	-- change the text of the task uis
	mainUI.TaskUI.MainFrame.Task1Frame.Task.Text = task1
	mainUI.TaskUI.MainFrame.Task2Frame.Task.Text = task2
	mainUI.TaskUI.MainFrame.Task3Frame.Task.Text = task3
end
local function updatetasks()
	print("debug: update tasks")
	if day == os.date("%j") then -- checks if the variable day is equal to the day of today
		print("debug: changing tasks")
		changetasks(tasks.Task1,tasks.Task2,tasks.Task3) -- changes the tasks based on the day
		taskenabled = false
	elseif day ~= os.date("%j") then -- checks if the variable day is not equal to the day of today
		day = os.date("%j") -- changes the variable day of the day of today
	end
end
local function timer(timertask)
	if timertask == tasks.Task1 then
		for i=timefortask,600,1 do -- change the second parameter if depending on what you want the timer to be 
			timefortask += 1
			wait(1)
			print(i)
		end
	elseif timertask == tasks.Task2 then
		for i=timefortask,900,1 do
			timefortask += 1
			wait(1)
			print(i)
		end
	elseif timertask == tasks.Task3 then
		for i=timefortask,1800,1 do
			timefortask += 1
			wait(1)
			print(i)
		end
	end
end
local function completetasks(task1,task2,task3)
	if task1 == tasks.Task1 and taskenabled == false and taskscompleted.Task1 == false then -- debuging and checking if the tasks have been completed and if the tasks have updated
		print("task1")
		taskenabled = true
		timer(task1)
		taskscompleted.Task1 = true -- making  this true so this if statment dosent work anymore
		events.ChangeExp:FireServer("First")
		taskenabled = false
		mainUI.TaskUI.MainFrame.Task1Frame.X.Visible = false
		mainUI.TaskUI.MainFrame.Task1Frame.Checkmark.Visible = true --enables the checkmark
	elseif task2 == tasks.Task2 and taskenabled == false and taskscompleted.Task2 == false then
		print("task2")
		taskenabled = true
		timer(task2)
		taskscompleted.Task2 = true
		events.ChangeExp:FireServer("Second")
		taskenabled = false
		mainUI.TaskUI.MainFrame.Task2Frame.X.Visible = false
		mainUI.TaskUI.MainFrame.Task2Frame.Checkmark.Visible = true
	elseif task3 == tasks.Task3 and taskenabled == false and taskscompleted.Task3 == false then
		print("task3")
		taskenabled = true
		timer(task3) -- using the timer function to count down to 30 minutes
		taskscompleted.Task3 = true
		events.ChangeExp:FireServer("Third")
		taskenabled = false
		mainUI.TaskUI.MainFrame.Task3Frame.X.Visible = false
		mainUI.TaskUI.MainFrame.Task3Frame.Checkmark.Visible = true
	else
		print("all daily tasks completed")
	end
end
mainUI.OpenTasksUI.MainFrame.TextButton.MouseButton1Click:Connect(function()
	print("debug: clicked")
	if mainUI.TaskUI.Enabled == true then
		mainUI.TaskUI.Enabled = false
	elseif mainUI.TaskUI.Enabled == false then
		mainUI.TaskUI.Enabled = true
	end
end)
events.PlayerAdded.OnClientEvent:Connect(function()
	while true do
		updatetasks()-- checks if its a new day and updates the tasks(will be useful when more tasks are added)
		completetasks(tasks.Task1,tasks.Task2,tasks.Task3) -- using this function to start the tasks
		wait(5)
	end
end)
