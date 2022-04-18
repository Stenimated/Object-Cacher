
type Added = "DescendantAdded" | "ChildAdded" | "PlayerAdded"
type Removing = "DescendantRemoving" | "ChildRemoved" | "PlayerRemoving"
type All = "GetChildren" | "GetPlayers" | "GetDescendants"
return function(Object:Instance, Added:Added, Removing:Removing, All:All)

	local function FireCallback(callbacks, child:Instance)
		for _, callback in ipairs(callbacks) do
			task.defer(callback, child)
		end
	end
	
	local addedCallback = {}
	local removingCallback = {}

	local self = setmetatable(Object[All](Object) :: {Instance}, {
		__call = function(_self, arg: "Added" | "Removing", callback: (Instance) -> nil)
			local reference = nil

			if arg == "Added" then
				reference = addedCallback
			elseif arg == "Removing" then
				reference = removingCallback
			else
				error("Invalid argument: " .. tostring(arg))
			end	

			table.insert(reference, callback)

			return function()
				local index = table.find(reference, callback)

				if index then
					table.remove(reference, index)
				end
			end
		end
	})

	Object[Added]:Connect(function(child:Instance)
		table.insert(self, child)
		FireCallback(addedCallback, child)
	end)
	
	Object[Removing]:Connect(function(child:Instance)
		local index = table.find(self, child)

		if index then
			table.remove(self, index)
			FireCallback(removingCallback, child)
		end
	end)

	return self
end
