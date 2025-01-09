--[[
	 Author: MimoTaken
--]]

----- Define Module -----

local module = {}

----- Services -----

local HttpsService = game:GetService("HttpService")

----- Module Variables -----

module.Connections = {}

----- Module Functions -----

----- Adds a connection -----

function module:AddConnection(Connection: RBXScriptConnection, Path: string)
	Path = Path or HttpsService:GenerateGUID(false)

	if module.Connections[Path] then
		warn('This path has already been assigned to another Connection')
		return false
	end

	if typeof(Connection) ~= 'RBXScriptConnection' then
		warn('Attempted to add a Connection type of '..typeof(Connection)..' Only RBXScriptConnection is supported!')
		return false
	end

	module.Connections[Path] = Connection

	return Connection
end

----- Gets the Connection -----

function module:GetConnection(Path: string, nodebug)
	local Connection = module.Connections[Path]
	if not Connection then
		if nodebug then
			return nil	
		end

		warn("Connection with the given path does not exist. Please check the provided path: " .. tostring(Path))

		return false
	end

	return Connection
end

----- Gets all connections -----

function module:GetAllConnections()
	return module.Connections
end

----- Removes a connection -----

function module:RemoveConnection(Path: string)
	if module.Connections[Path] then
		if not module.Connections[Path].Connected then
			module.Connections[Path] = nil
			warn("The given path has already been disconnected, the path has been removed from the list.")
			return false
		end

		module.Connections[Path]:Disconnect()
		module.Connections[Path] = nil

		return true
	end
end

----- Removes all connections which starts by Given Name -----

function module:RemoveAllConnectionsStartsWith(Name: string)
	if not Name or #Name == 0 then
		warn("An invalid 'Name' has been supplied or an Empty Name Provided. Please check that a valid, non-empty string is supplied. If you wish to clear all connections use 'RemoveAllConnections()' instead.")
		return false
	end

	local RemoveArray = false
	for Path, Connection in pairs(module.Connections) do
		if type(Path) == 'string' and string.find(Path, "^"..Name) == Name then
			if Connection.Connected then Connection:Disconnect() end
			module.Connections[Path] = nil
		end
		RemoveArray = true
	end

	if not RemoveArray then
		warn("No connection has been removed with the provided Name.")
	end

	return true
end

----- Remove all connections -----

function module:RemoveAllConnections()
	for Path, Connection in pairs(module.Connections) do
		Connection:Disconnect()
		module.Connections[Path] = nil
	end

	return true
end

----- Returning Logic -----

return module
