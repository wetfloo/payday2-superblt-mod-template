Hooks:Add(
	"MenuManagerSetupCustomMenus",
	"MenuManagerSetupCustomMenus_" .. MyExampleMod.mod_name,
	function(_menu_manager, _nodes)
		MyExampleMod:load_configuration()

		MenuHelper:LoadFromJsonFile(
			MyExampleMod.mod_path .. "menus/blt_options.json",
			MyExampleMod,
			MyExampleMod._data
		)

		-- Add our own callbacks to handle menu value changes
		MenuCallbackHandler.my_example_mod__menu_callback__example_value_percent = function(
			_self,
			item
		)
			local val = item:value() / 100
			MyExampleMod._data.example_value = val
		end

		MenuCallbackHandler.my_example_mod__menu_callback__closed = function(_self)
			MyExampleMod:save_configuration()
		end
	end
)
