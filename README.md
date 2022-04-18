# Object cacher

Object cacher is a simple way to cache objects. It returns a single table with the ability to loop or call

## Doccumentation

Cache workspace
```lua

--[[

type Added = "DescendantAdded" | "ChildAdded" | "PlayerAdded"
type Removing = "DescendantRemoving" | "ChildRemoved" | "PlayerRemoving"
type All = "GetChildren" | "GetPlayers" | "GetDescendants"

	Paramaters

	1#
	Instance

	2# "Added" RBXScriptSignal
	3# "Removing" RBXScriptSignal
	4# "GetAll" Array<Instance>
]]

local CacheWorkspace = ObjectCacher(workspace, "ChildAdded", "ChildRemoved", "GetChildren")

```

Loop over cache
```lua
for i, v in ipairs(CacheWorkspace) do
    print(i, v)
end

```

"ChildAdded"
```lua
local disconnect = CacheWorkspace("Added", function(Instance)
    
end)

task.wait(2)

disconnect()

```

"ChildRemoving"
```lua
local disconnect = CacheWorkspace("Removing", function(Instance)
    
end)

task.wait(2)

disconnect()
```