Hooks:Add(
	"LocalizationManagerPostInit",
	"LocalizationManagerPostInit_" .. MyExampleMod.mod_name .. "_LoadLocStrings",
	function(loc_manager)
		loc_manager:load_localization_file(MyExampleMod.mod_path .. "loc/en.json")
	end
)
