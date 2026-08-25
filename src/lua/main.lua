---@alias Color any
---@alias Font any
---@alias HUD any
---@alias HUDPanel any

_G.MyExampleMod = _G.MyExampleMod or {}

MyExampleMod.mod_name = MyExampleMod.mod_name or "MyExampleMod"

MyExampleMod.mod_path = MyExampleMod.mod_path or ModPath
MyExampleMod.save_path = MyExampleMod.save_path
	or SavePath .. MyExampleMod.mod_name .. "_options.json"

function MyExampleMod.dofile(name)
	return dofile(MyExampleMod.mod_path .. "lua/" .. name .. ".lua")
end

-- keep-sorted start
MyExampleMod.dofile("functions/tbl")
-- keep-sorted end

-- keep-sorted start
MyExampleMod.dofile("classes/example")
-- keep-sorted end

MyExampleMod._data = MyExampleMod._data or {
	example_value = 0.42,
}

MyExampleMod._mt_data = MyExampleMod._mt_data
	or {
		__index = function(t, k)
			local m = {}

			local function percent(val)
				return val * 100
			end

			function m.example_value_percent()
				return percent(rawget(t, "example_value"))
			end

			local result = m[k]
			if result and type(result) == "function" then
				return result()
			end
		end,
	}

setmetatable(MyExampleMod._data, MyExampleMod._mt_data)

--- Loads the mod's configuration,
--- saving it to [LowAmmoText._data] and returning it as a table.
function MyExampleMod:load_configuration()
	local file = io.open(self.save_path, "r")
	if not file then
		return
	end

	local result = json.decode(file:read("*all")) or {}
	file:close()

	self.tbl.fill_missing(result, self._data)
	setmetatable(result, MyExampleMod._mt_data)
	self._data = result

	return result
end

function MyExampleMod:save_configuration()
	local file = io.open(self.save_path, "w+")
	if not file then
		return
	end

	local result = file:write(json.encode(self._data))
	file:close()

	return result
end

MyExampleMod.dofile("hooks/" .. RequiredScript)
