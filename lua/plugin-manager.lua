--------------------------------------------------------------------------------
-- Simple plugin manager -------------------------------------------------------
--------------------------------------------------------------------------------

-- Define the plugin module.
plugin_manager = {}

-- Default settings.
plugin_manager.config = {
	-- Where the plugins' repositories are stored.
	repositories = vim.fn.stdpath('config') .. "/plugins/repositories",
	-- Where the plugins' configurations are stored.
	configurations = vim.fn.stdpath('config') .. "/plugins/configurations"
}

-- Function for the user to setup the plugin.
function plugin_manager.setup(user_config)
	-- Merge user configuration with default configuration.
	plugin_manager.config = vim.tbl_extend("force", plugin_manager.config, user_config)
end

-- Function to load a plugin.
function plugin_manager.load_plugin(plugin_basename, has_config)
	-- Where the plugins' repositories are stored.
	local repositories = plugin_manager.config.repositories
	-- The path to the plugin's repository.
	local plugin_repo = repositories .. '/' .. plugin_basename

	-- Add the plugin's root directory in runtime path.
	vim.opt.rtp:prepend(plugin_repo)

	-- Add the plugin's after directory in runtime path.
	if vim.fn.isdirectory(plugin_repo .. '/after') == 1 then
		vim.opt.rtp:prepend(plugin_repo .. '/after')
	end

	if has_config then
		-- Where the plugins' configurations are stored.
		local configs = plugin_manager.config.configurations
		-- The path to the plugin's configuration.
		local plugin_config = configs .. '/' .. plugin_basename .. '.lua'

		-- Load the plugin's configuration.
		dofile(plugin_config)
	end
end

return plugin_manager
